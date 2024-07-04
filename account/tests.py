from django.urls import reverse
from account.models import Account
from django.conf import settings
from django.utils.http import urlsafe_base64_encode
from django.utils.encoding import smart_bytes
from django.contrib.auth.tokens import PasswordResetTokenGenerator
import jwt

from rest_framework.authtoken.models import Token
from rest_framework import status
from rest_framework.test import APITestCase
from rest_framework.authtoken.models import Token


class RegisterTestCase(APITestCase):
    def test_register(self):
        data = {
            "username": "testcase",
            "email": "cheikhdiouf035@gmail.com",
            "first_name": "testcase",
            "last_name": "testcase",
            "password": "123",
            "password2": "123",
        }
        response = self.client.post(reverse('register-api'), data)
        # token = Token.objects.get(user__username='testcase').key
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        
        # Check if the user is created
        user = Account.objects.get(username='testcase')
        self.assertIsNotNone(user)

        # Check if the token is created
        token = Token.objects.get(user=user)
        self.assertIsNotNone(token)
        self.assertEqual(token.key, user.auth_token.key)

class VerifyEmailTestCase(APITestCase):
    def setUp(self):
        # Create a use account
        self.user = Account.objects.create_user(
            first_name = 'Cheikh',
            last_name = 'Diop',
            username='testcase',
            email='cheikhdiouf035@gmail.com',
            password='password123',
            # is_active= False # Initial in  inactive
        )

    # Generate a JWT token for the user
        self.token = jwt.encode(
            {"user_id": self.user.id},
            settings.SECRET_KEY,
            algorithm='HS256'
        )

    def test_verify_email_success(self):
        # Simulate a GET request to the VerifyEmail endpoint with the token
        response = self.client.get(reverse('email-verify'), {'token': self.token})
        
        # Check the response
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['email'], 'Successfully activated')

        # Check that the user account is now active
        self.user.refresh_from_db()
        self.assertTrue(self.user.is_active)

    def test_verify_email_expired_token(self):
        # Simulate an expired token by manually setting an expired timestamp
        expired_token = jwt.encode(
            {"user_id": self.user.id, "exp": 0},  # Expired token
            settings.SECRET_KEY,
            algorithm='HS256'
        )
        # response = self.client.get(reverse('email-verify'), {'token': expired_token}, {'uidb64': self.uidb64})
        response = self.client.get(reverse('email-verify'), {'token': expired_token})
        
        # Check the response
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data['error'], 'Activation Expired')

    def test_verify_email_invalid_token(self):
        # Simulate an invalid token
        invalid_token = "thisisinvalidtoken"
        response = self.client.get(reverse('email-verify'), {'token': invalid_token})
        
        # Check the response
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data['error'], 'Invalid token')

# Ensure your urls.py has the correct path for the 'email-verify' view

class LoginLogoutTestCase(APITestCase):
    def setUp(self):
        self.user = Account.objects.create_user(
            first_name = "Cheikh Sadibou",
            last_name = "Diouf",
            email = "senxibaar220@gmail.com",
            username = "Cheikh",
            password = "password@124"
        )
        self.token, created = Token.objects.get_or_create(user=self.user)

        self.user.is_active = True # Ensure the user is active
        self.user.save()
    
        # # Generate a JWT token for the user
        # self.token = Token.objects.create(user=self.user)
    def test_login(self):
        data = {
            "email": "senxibaar220@gmail.com",
            "password": "password@124"
        }
        response = self.client.post(reverse('login-api'), data)
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_logout(self):
        # self.token = Token.objects.get(user__email=self.user.email)
        # self.client.credentials(HTTP_AUTHORIZATION='token' + self.key)
        # response = self.client.post(reverse('logout-api'))
        # self.assertEqual(response.status_code, status.HTTP_OK)
        # self.assertEqual(response.data['detail'], 'Successfully logged out')

        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token.key)
        response = self.client.post(reverse('logout-api'))

        # Debugging statement
        print(response.data) 

        self.assertEqual(response.status_code, status.HTTP_200_OK)


class PasswordTokenCheckAPITestCase(APITestCase):
    def setUp(self):
        self.user = Account.objects.create_user(
            first_name = "Cheikh Sadibou",
            last_name = "Diouf",
            email = "senxibaar220@gmail.com",
            username = "Cheikh",
            password = "password@124"
        )
        self.token, created = Token.objects.get_or_create(user=self.user)

    def test_request_reset_email(self):
        data = {
            "email": "senxibaar220@gmail.com"
        }
        response = self.client.post(reverse('request-reset-password'), data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['success'], 'We have sent you a link to your email to reset your password !')

        # Simulate the part where the user clicks the reset link in the email
        uidb64 = urlsafe_base64_encode(smart_bytes(self.user.id))
        token = PasswordResetTokenGenerator().make_token(self.user)
        reset_confirm_url = reverse('password-reset-confirm', kwargs={'uidb64': uidb64, 'token': token})

        # Perform a GET request to check the token
        response = self.client.get(reset_confirm_url)
        print(response.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['message'], 'Credentials valid')

    def test_set_newpassword_APIView(self):

        # Generate token and uidb64
        uidb64 = urlsafe_base64_encode(smart_bytes(self.user.id))
        token = PasswordResetTokenGenerator().make_token(self.user)

         # Prepare data for the set new password request
        data = {
            "password": "password@125",
            "confirm_password": "password@125",
            "uidb64": uidb64,
            "token": token
        }

        # Make the patch request to set the new password
        response = self.client.patch(reverse('password-reset-complete'), data,  format='json')
        print(response.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['message'], 'Password reset successfully')
