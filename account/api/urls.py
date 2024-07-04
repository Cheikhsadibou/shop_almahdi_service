from django.urls import path, include
from account.api.views import LoginView, AccountSerializerVS, PasswordTokenCheckAPI, RequestPasswordResetEmail, SetNewPasswordAPIView, UserRegisterDetailAPIView, UserRegisterView, VerifyEmail, RegistrationView, UserProfileVS, logout_view
# from rest_framework.authtoken.views import obtain_auth_token
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('user_profile', UserProfileVS, basename='userprofile')
router.register('account', AccountSerializerVS, basename='account')

urlpatterns = [
    path('register/', RegistrationView.as_view(), name='register-api'),
    path('email-verify/', VerifyEmail.as_view(), name='email-verify'),
    path('registers/<str:username>/', UserRegisterView.as_view(), name='user-register-api'),
    path('registers/<str:username>/edite-profile/', UserRegisterDetailAPIView.as_view(), name='edite-profile'),
    path('password-reset-confirm/<uidb64>/<token>/', PasswordTokenCheckAPI.as_view(), name='password-reset-confirm'),
    path('request-reset-password/', RequestPasswordResetEmail.as_view(), name='request-reset-password'),
    path('password-reset-complete/', SetNewPasswordAPIView.as_view(), name='password-reset-complete'),
    # path('me/', UserInfirmationTokenAPIView.as_view(), name='user_information_api_view'),
    # # path('login/', login_view, name='login'),
    path('login/', LoginView.as_view(), name='login-api'),
    path('logout/', logout_view, name='logout-api'),
    path('', include(router.urls)),
]
