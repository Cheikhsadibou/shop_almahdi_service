from account.models import Account, UserProfile
from drf_writable_nested import WritableNestedModelSerializer
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.utils.encoding import force_str
from django.utils.http import urlsafe_base64_decode, urlsafe_base64_encode
from django.utils.encoding import smart_str, force_str, smart_bytes, DjangoUnicodeDecodeError
from account.utils import Util
from django.contrib.sites.shortcuts import get_current_site

from rest_framework import serializers
from rest_framework.reverse import reverse
from rest_framework.exceptions import AuthenticationFailed 

class RegistrationSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(style={'input_type': 'password'}, write_only=True)
    class Meta:
        model = Account
        fields = ['username', 'email', 'password', 'password2']
        extra_kwargs = {
               'password': {'write_only' : True}
        }
    def save(self):
        password = self.validated_data['password']
        password2 = self.validated_data['password2']
        if password != password2:
            raise serializers.ValidationError({'error': 'passwords do not match!'})
        if Account.objects.filter(email=self.validated_data['email']).exists():
            raise serializers.ValidationError({'error': 'Email already exists!'})
        account = Account(email=self.validated_data['email'], username=self.validated_data['username'])
        account.set_password(password)
        account.save()
        return account
    
    def create(self, validated_data):
        user = Account.objects.create_user(**validated_data)
        return user

    def to_representation(self, instance):
        """Overriding to remove Password Field when returning Data"""
        ret = super().to_representation(instance)
        ret.pop('password', None)
        return ret

    # def get_links(self, obj):
    #     request = self.context['request']
    #     username = obj.username

        # return {
        #           'self': reverse('user-detail',
        #           kwargs = {Account.USERNAME_FIELD: username}, request=request),
        #           }
        # return {
        #     'self': {
        #         'href': f'/api/account/{username}'
        #     },
        #     'profile': {
        #         'href': f'/api/account/{username}/profile'
        #     },
        #     'carts': {
        #         'href': f'/api/account/{username}/carts'
        #     },
        #     'orders': {
        #         'href': f'/api/account/{username}/orders'
        #     },
        #     'reviews': {
        #         'href': f'/api/account/{username}/reviews'
        #     }
        # }

class UserProfileSerializer(WritableNestedModelSerializer, serializers.ModelSerializer):
    user = serializers.StringRelatedField(read_only=True)
    class Meta:
        model = UserProfile
        # fields = "__all__"
        fields = ['user', 'profile_picture', 'adress_line_1', 'city', 'state', 'country']

class AccountSerializer(WritableNestedModelSerializer, serializers.ModelSerializer):
    userprofile = UserProfileSerializer(many=False, read_only=True)
    class Meta:
        model = Account
        # fields = "__all__"
        fields = ['id', Account.USERNAME_FIELD, 'username', 'first_name', 'last_name', 'phone_number', 'date_joined', 'last_login', 'userprofile']
        extra_kwargs = {
            'password': {'write_only': True, 'min_length': 5}
            }
    
class EmailVerificationSerializer(serializers.ModelSerializer):
    token = serializers.CharField(max_length=555)
    class Meta:
        model = Account
        fields = ['token']

class ResetPasswordRequestEmailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['email']

    def validate(self, attrs):
            email = attrs['data'].get('email', '')

            return super().validate(attrs)


# class SetNewPasswordSerializer(serializers.ModelSerializer):
#     confirm_password = serializers.CharField(min_length=8, write_only=True)
#     token = serializers.CharField(read_only=True)
#     uidb64 = serializers.CharField(read_only=True)
#     class Meta:
#         model = Account  # Replace YourUserModel with the name of your user model
#         fields = ('password', 'confirm_password', 'token', 'uidb64')
#         extra_kwargs = {
#             'password': {'write_only': True},
#         }

#     def validate(self, data, attrs):
#         """
#         Check if passwords match.
#         """
#         if data.get('password') != data.get('confirm_password'):
#             raise serializers.ValidationError("Passwords do not match.")
#         # return data
#         try:
#             password = attrs.gat('password')
#             token = attrs.get('token')
#             uidb64 = attrs.get('uidb64')
#             id = force_str(urlsafe_base64_decode(uidb64))
#             user = Account.objects.get(id=id)
#             if not PasswordResetTokenGenerator().check_token(user, token):
#                 raise AuthenticationFailed('The reset link is invalid', 401)
#             user.set_password(password)
#             user.save()
#         except Exception as identifier:
#             raise AuthenticationFailed('The reset link invalid', 401)
#         return super().validate(data)


#     def save(self):
#         """
#         Save the new password.
#         """
#         user = self.instance
#         user.set_password(self.validated_data['password'])
#         user.save()

# code amenliorer

class SetNewPasswordSerializer(serializers.ModelSerializer):
    confirm_password = serializers.CharField(min_length=8, write_only=True)
    token = serializers.CharField(write_only=True)
    uidb64 = serializers.CharField(write_only=True)

    class Meta:
        model = Account
        fields = ('password', 'confirm_password', 'token', 'uidb64')
        extra_kwargs = {
            'password': {'write_only': True},
        }

    def validate(self, data):
        """
        Check if passwords match and reset the password.
        """
        password = data.get('password')
        confirm_password = data.get('confirm_password')

        if password != confirm_password:
            raise serializers.ValidationError("Passwords do not match.")

        token = data.get('token')
        uidb64 = data.get('uidb64')

        try:
            id = force_str(urlsafe_base64_decode(uidb64))
            user = Account.objects.get(id=id)
        except (TypeError, ValueError, OverflowError, Account.DoesNotExist):
            raise AuthenticationFailed('The reset link is invalid', code=401)

        if not PasswordResetTokenGenerator().check_token(user, token):
            raise AuthenticationFailed('The reset link is invalid', code=401)

        user.set_password(password)
        user.save()
        
        return data
