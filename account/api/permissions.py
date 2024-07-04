from rest_framework import permissions

class AdminOrReadOnly(permissions.IsAdminUser):
    def has_permission(self, request, view):
        # admin_permission = super().has_permission(request, view) # True if user is admin
        admin_permission = bool(request.user and request.user.is_staff)
        # return request.method == "GET" or admin_permission
        if request.method in permissions.SAFE_METHODS:
            return True
        else:
        # return request.user.is_staff
            return admin_permission

class AccountUserOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        else:
            return obj.user == request.user or request.user.is_staff

class IsOwnerOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        else:
            return obj.user == request.user
        