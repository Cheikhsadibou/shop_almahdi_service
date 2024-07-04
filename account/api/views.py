import jwt
from account.api.throttling import LoginViewThrottle, LogoutViewThrottle
from account.models import Account, UserProfile
from account.api.serializers import AccountSerializer, EmailVerificationSerializer, RegistrationSerializer, ResetPasswordRequestEmailSerializer, SetNewPasswordSerializer, UserProfileSerializer
from account.api.permissions import AccountUserOrReadOnly, AdminOrReadOnly
from django_filters.rest_framework import DjangoFilterBackend
from django.contrib.auth import authenticate
from django.contrib.sites.shortcuts import get_current_site
from django.utils.encoding import smart_str, force_str, smart_bytes, DjangoUnicodeDecodeError
from django.utils.http import urlsafe_base64_decode, urlsafe_base64_encode
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from account.utils import Util
from django.urls import reverse
from django.conf import settings

from rest_framework.decorators import api_view
from rest_framework.decorators import throttle_classes, permission_classes
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.permissions import IsAuthenticated
from rest_framework import status, views
from rest_framework import viewsets, filters, authentication, permissions
from rest_framework.permissions import IsAdminUser
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authentication import TokenAuthentication
from rest_framework import generics
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny

# class LoginView(APIView):
#     throttle_classes = [LoginViewThrottle]
#     authentication_classes = [TokenAuthentication]
#     def post(self, request):
#         # Your authentication logic here
#         user = authenticate(email=request.data['email'], password=request.data['password'])
#         if user:
#             token, created = Token.objects.get_or_create(user=user)
#             return Response({'token': token.key})
#         else:
#             return Response({'error': 'Invalid credentials'}, status=401)
 
class LoginView(APIView):
    throttle_classes = [LoginViewThrottle]
    authentication_classes = [TokenAuthentication]

    def post(self, request):
        try:
            email = request.data.get('email')
            password = request.data.get('password')

            # Ensure email and password are provided
            if not email or not password:
                return Response({'error': 'Email and password are required.'}, status=status.HTTP_400_BAD_REQUEST)

            user = authenticate(email=email, password=password)

            if user:
                token, created = Token.objects.get_or_create(user=user)
                return Response({
                    'user_id': user.id,
                    'token': token.key,
                    'message': f'Welcome back, {user.username} !',
                    'status': 'success'
                }, status=status.HTTP_200_OK)
            else:
                # Debugging statement
                print("Invalid credentials")
                return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

        except Exception as e:
            # Debugging statement
            print(f"Exception: {e}")
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# @api_view(['POST',])
# def login_view(request):
#         user = authenticate(email=request.data['email'], password=request.data['password'])
#         if user:
#             token, created = Token.objects.get_or_create(user=user)
#             return Response({'token': token.key})
#         else:
#             return Response({'error': 'Invalid credentials'}, status=401)

# @api_view(['POST',])
# @throttle_classes([LogoutViewThrottle])
# @permission_classes([IsAuthenticated])
# def logout_view(request):
#     if request.method == 'POST':
#         request.user.auth_token.delete()
#         return Response(status=status.HTTP_200_OK)
#     return Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)  # Handle non-POST requests appropriately

@api_view(['POST'])
@throttle_classes([LogoutViewThrottle])
@permission_classes([IsAuthenticated])
def logout_view(request):
    if request.method == 'POST':
        try:
            user = request.user
            user.auth_token.delete()
            return Response({
                'message': f'Successfully logged out, {user.username}.',
                'status': 'success'
            }, status=status.HTTP_200_OK)
        except Token.DoesNotExist:
            return Response({
                'error': 'Token not found. It seems you are already logged out.',
                'status': 'failure'
            }, status=status.HTTP_400_BAD_REQUEST)
    return Response({
        'error': 'Method not allowed. Please use POST to log out.',
        'status': 'failure'
    }, status=status.HTTP_405_METHOD_NOT_ALLOWED)

# class logout_view(APIView):
#     # permission_classes = [IsAuthenticated]
#     authentication_classes = [TokenAuthentication]
#     def post(self, request):
#         request.user.auth_token.delete()
#         return Response(status=status.HTTP_200_OK)

class UserRegisterView(generics.ListAPIView):
    serializer_class = AccountSerializer
    
    def get_queryset(self):
        queryset = Account.objects.all()
        username = self.kwargs['username']
        # username = self.request.query_params.get('username')
        return queryset.filter(username=username)


class UserRegisterDetailAPIView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = AccountSerializer
    permission_classes = [permissions.IsAuthenticated]  # Ensure user is authenticated
    queryset = Account.objects.all()
    lookup_field = 'username'  # Assuming username is the field you want to use for lookup


class RegistrationView(generics.GenericAPIView):
    serializer_class = RegistrationSerializer

    def post(selt, request):
        user = request.data
        serializer = selt.serializer_class(data=user)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        user_data = serializer.data
        user = Account.objects.get(email=user_data['email'])
        token = RefreshToken.for_user(user).access_token
        current_site = get_current_site(request).domain
        relativlink = reverse('email-verify')
        absolute_url = 'http://'+current_site+relativlink+"?token="+str(token)
        email_body = 'Hi '+user.username+' Use this link to verify your email\n'+absolute_url
        data = {'email_body': email_body, 'to_email': user.email, 'email_subject': 'Verify your email'}
        Util.send_confirmation_email(data)

        # Create User Profile 
        profile = UserProfile()
        profile.user_id = user.id
        profile.profile_picture = 'userprofile/default-user.png'
        profile.save()
        
        return Response(user_data, status=status.HTTP_201_CREATED)

class VerifyEmail(generics.GenericAPIView):
# class VerifyEmail(views.APIView):
    # authentication_classes = [TokenAuthentication]
    serializer_class = EmailVerificationSerializer
    def get(self, request):
        token = request.GET.get('token')
        try:
            # payload = jwt.decode(token, 'secret', algorithms=['HS256'])
            payload = jwt.decode(token, settings.SECRET_KEY, algorithms=['HS256'])
            account = Account.objects.get(id=payload['user_id'])
            if not account.is_active:
                account.is_active = True
                account.save()
            return Response({'email':'Successfully activated'}, status=status.HTTP_200_OK)
        except jwt.ExpiredSignatureError as identifier1:
            print(identifier1)
            return Response({'error':'Activation Expired'}, status=status.HTTP_400_BAD_REQUEST)
        except jwt.exceptions.DecodeError as identifier2:
            print(identifier2)
            return Response({'error':'Invalid token'}, status=status.HTTP_400_BAD_REQUEST)

# @api_view(['POST',])
# def registration_view(request):
#     if request.method == 'POST':
#         serializer = RegistrationSerializer(data=request.data)
#         data = {}
#         if serializer.is_valid():
#             account = serializer.save()
#             data['response'] = "Registration Successful !"
#             data['username'] = account.username
#             data['email'] = account.email
#             token = Token.objects.get(user=account).key
#             data['token'] = token
            
#         else:
#             data = serializer.errors
#         return Response(data, status=status.HTTP_201_CREATED)
    
# class ResgistrationAPI(APIView):
#     def get(self, request, format=None):
#         account = Account.objects.all()
#         serializer = RegistrationSerializer(account, many=True)
#         return Response(serializer.data)
    
#     def post(self, request, format=None):
#         serializer = RegistrationSerializer(data=request.data)
#         data = {}
#         if serializer.is_valid():
#             account = serializer.save()
#             data['response'] = "Registration Successful !"
#             data['username'] = account.username
#             data['email'] = account.email
#             token = Token.objects.get(user=account).key
#             data['token'] = token

#         else:
#             data = serializer.errors
#         return Response(data, status=status.HTTP_201_CREATED)
    
class UserProfileVS(viewsets.ModelViewSet):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer
    permission_classes = [IsAuthenticated]
    # permission_classes = [IsAdminUser]
    permissions_classes = [AccountUserOrReadOnly, AdminOrReadOnly]

class AccountSerializerVS(viewsets.ModelViewSet):
    queryset = Account.objects.all()
    serializer_class = AccountSerializer
    permission_classes = [IsAuthenticated]
    permissions_classes = [AccountUserOrReadOnly]

# class AccountViewSet(viewsets.ModelViewSet):
#       """API endpoint for listing users."""
      
#       lookup_field = Account.USERNAME_FIELD
#       lookup_url_kwarg = Account.USERNAME_FIELD
#       queryset = Account.objects.order_by(Account.USERNAME_FIELD) 
#       serializer_class = AccountSerializer

class RequestPasswordResetEmail(generics.GenericAPIView):
    serializer_class = ResetPasswordRequestEmailSerializer

    def post(self, request):
        data = {'request': request, 'data': request.data}
        serializer = self.serializer_class(data=data)
        email = request.data['email']
        if Account.objects.filter(email=email).exists():
            user = Account.objects.get(email=email)
            uidb64 = urlsafe_base64_encode(smart_bytes(user.id))
            token = PasswordResetTokenGenerator().make_token(user)
            current_site = get_current_site(request=request).domain
            relativlink = reverse('password-reset-confirm', kwargs={'uidb64':uidb64, 'token':token})
            absolute_url = 'http://'+current_site + relativlink
            email_body = 'Hello, '+user.username+' \n Use this link to reset your password \n'+ absolute_url
            data = {'email_body': email_body, 'to_email': user.email, 'email_subject': ' Reset your password'}
            Util.send_confirmation_email(data)

        return Response({'success': 'We have sent you a link to your email to reset your password !'}, status=status.HTTP_200_OK)

# class PasswordTokenCheckAPI(generics.GenericAPIView):
#     def get(self, request, uidb64, token):
#         try:
#             id = smart_str(urlsafe_base64_decode(uidb64))
#             user = Account.objects.get(id=id)

#             if not PasswordResetTokenGenerator().check_token(user, token):
#                 return Response({'error': 'Token is not valid, please request a new one'}, status=status.HTTP_401_UNAUTHORIZED)
#             return Response({'success': True, 'message': 'Credentials valid', 'uidb64': uidb64, 'token': token}, status=status.HTTP_200_OK)

#         except DjangoUnicodeDecodeError as identifier:
#                 print(identifier)   
#                 return Response({'error': 'Token is not valid, please request a new one'}, status=status.HTTP_401_UNAUTHORIZED)

class PasswordTokenCheckAPI(generics.GenericAPIView):
    def get(self, request, uidb64, token):
        try:
            id = smart_str(urlsafe_base64_decode(uidb64))
            user = Account.objects.get(id=id)

            if not PasswordResetTokenGenerator().check_token(user, token):
                return Response({'error': 'Token is not valid, please request a new one'}, status=status.HTTP_401_UNAUTHORIZED)

            return Response({'success': True, 'message': 'Credentials valid', 'uidb64': uidb64, 'token': token}, status=status.HTTP_200_OK)

        except Exception as e:
            # Log the exception for debugging
            print(e)
            return Response({'error': 'An error occurred while processing the token'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class SetNewPasswordAPIView(generics.GenericAPIView):
    serializer_class = SetNewPasswordSerializer

    def patch(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        return Response({'success':True, 'message': 'Password reset successfully'}, status=status.HTTP_200_OK)
    