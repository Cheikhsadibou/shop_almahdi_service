from rest_framework.throttling import UserRateThrottle, AnonRateThrottle

class RegistrationViewThrottle(AnonRateThrottle):
    scope = 'register-api'

class LoginViewThrottle(UserRateThrottle):
    scope = 'login-api'

class LogoutViewThrottle(UserRateThrottle):
    scope = 'logout-api'