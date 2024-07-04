from rest_framework import permissions
import logging

from orders.models import Order

logger = logging.getLogger(__name__)

class IsOwnerOnly(permissions.BasePermission):
    """
    Permission allowing access only to the owner of an object.
    """
    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True  # Allow safe methods for any user
        return request.user.is_authenticated and obj.user == request.user
    

class IsOwnerOnlyOrAdmin(permissions.BasePermission):
    def has_permission(self, request, view):
        # Global permission check can be left as is or refined if necessary
        return request.user and request.user.is_authenticated
    
    def has_permission(self, request, view):
        # Ensure that users can only create orders for themselves
        if request.method == 'POST':
            user_id = request.data.get('user')
            return user_id is None or user_id == request.user.id
        return super().has_permission(request, view)
    
    def has_object_permission(self, request, view, obj):
        return obj.user == request.user or request.user.is_staff

    def has_object_permission(self, request, view, obj):
        # Check if the user is the owner or an admin
        is_owner_or_admin = obj.user == request.user or request.user.is_staff
        
        # Prevent modification if the order is already approved
        if request.method in permissions.SAFE_METHODS:
            return is_owner_or_admin
        return is_owner_or_admin and obj.status != "COMPLETED"

class IsAdminOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):

        admin_permission = bool(request.user and request.user.is_staff)
        # return request.method == "GET" or admin_permission
        if request.method in permissions.SAFE_METHODS:
            return True
        else:
        # return request.user.is_staff
            return admin_permission

class IsOwnerPaymentsOnlyOrAdmin(permissions.BasePermission):
    
    def has_permission(self, request, view):
        # Allow access for authenticated users
        if request.method in ['POST', 'PUT', 'PATCH', 'DELETE']:
            # For unsafe methods, ensure the user is the owner or an admin
            user_email = request.data.get('user')
            return request.user.is_authenticated and (user_email is None or user_email == request.user.email)
        return request.user.is_authenticated
    
    def has_object_permission(self, request, view, obj):
        # Allow access if the user is the owner or an admin
        return obj.user == request.user or request.user.is_staff

# class IsOwnerOrderProductOrAdmin(permissions.BasePermission):
    
#     def has_permission(self, request, view):
#         if request.method in ['POST', 'PUT', 'PATCH', 'DELETE']:
#             user_id = request.data.get('user')
#             if user_id is not None and request.user.is_authenticated:
#                 if str(user_id) == str(request.user.id) or request.user.is_staff:
#                     return True
#                 else:
#                     logger.debug(f"Permission denied: user_id={user_id}, request.user.id={request.user.id}, request.user.is_staff={request.user.is_staff}")
#                     return False
#             return request.user.is_authenticated
#         return request.user.is_authenticated
    
#     def has_object_permission(self, request, view, obj):
#         # Allow access if the user is the owner or an admin
#         return obj.user == request.user or request.user.is_staff
    
# class IsOwnOrderProductOnlyOrAdmin(permissions.BasePermission):
#     def has_permission(self, request, view):
#         if request.method in ['POST', 'PUT', 'PATCH', 'DELETE']:
#             order_id = request.data.get('order')
#             if order_id is not None and request.user.is_authenticated:
#                 try:
#                     order = Order.objects.get(id=order_id)
#                     if order.user == request.user or request.user.is_staff:
#                         return True
#                     else:
#                         logger.debug(f"Permission denied: order.user_id={order.user.username}, request.user.id={request.user.id}, request.user.is_staff={request.user.is_staff}")
#                         return False
#                 except Order.DoesNotExist:
#                     return False  # Deny if the order does not exist
#             return False  # Explicitly deny if order_id is not provided
#         return request.user.is_authenticated
    

    # def has_permission(self, request, view):
    #     # Allow authenticated users
    #     if request.method in permissions.SAFE_METHODS:
    #         return request.user and request.user.is_authenticated

    #     # For POST, PUT, PATCH, DELETE methods, ensure the user is authenticated
    #     # and is the owner of the object or an admin
    #     if request.method in ['POST', 'PUT', 'PATCH', 'DELETE']:
    #         user_email = request.data.get('user')
    #         return request.user.is_authenticated and (user_email is None or user_email == request.user.email)

    #     return request.user and request.user.is_authenticated

    # def has_object_permission(self, request, view, obj):
    #     # Allow access if the user is the owner or an admin
    #     return obj.user == request.user or request.user.is_staff

    # def has_permission(self, request, view):
    #     if request.method == 'POST':
    #         user_email = request.data.get('user')
    #         return request.user.is_authenticated and (user_email is None or user_email == request.user.email)
    #     return request.user and request.user.is_authenticated

    # def has_object_permission(self, request, view, obj):
    #     # Allow access if the user is the owner or an admin
    #     return obj.user == request.user or request.user.is_staff
    
    # def has_permission(self, request, view):
    # # Allow access if the user is the owner or an admin
    #     return request.user and request.user.is_authenticated
    
    # def has_object_permission(self, request, view, obj):
    #     # Allow access if the user is the owner or an admin
    #     return obj.user == request.user or request.user.is_staff

    # def has_permission(self, request, view):
    #     # Ensure authenticated users only
    #     if not request.user or not request.user.is_authenticated:
    #         return False
        
    #     # Ensure users can only create payments for themselves
    #     if request.method == 'POST':
    #         user = request.user
    #         return user.is_authenticated
        
    #     return True
    
    # def has_object_permission(self, request, view, obj):
    #     # Allow access if the user is the owner or an admin
    #     return obj.user == request.user or request.user.is_staff
    
    # def has_permission(self, request, view):
    #     # Ensure authenticated users only
    #     if not request.user or not request.user.is_authenticated:
    #         return False
        
    #     # Ensure users can only create payments for themselves
    #     if request.method == 'POST':
    #         user_email = request.data.get('user')
    #         return user_email is None or user_email == request.user.email
        
    #     return True

    #  # Ensure users can only create payments for themselves
    #     if request.method == 'POST':
    #         user_email = request.data.get('user')
    #         if user_email and user_email != request.user.email:
    #             return False
        
    #     return True
    
    # def has_object_permission(self, request, view, obj):
    #     # Allow access if the user is the owner or an admin
    #     return obj.user == request.user or request.user.is_staff

class IsOwnerOrderProductOrAdmin(permissions.BasePermission):
    
    def has_permission(self, request, view):
        if request.method in ['POST', 'PUT', 'PATCH', 'DELETE']:
            # Check permission based on the associated order
            order_id = request.data.get('order')
            if order_id is not None and request.user.is_authenticated:
                try:
                    order = Order.objects.get(id=order_id)
                    if order.user == request.user or request.user.is_staff:
                        return True
                    else:
                        logger.debug(f"Permission denied: order.user_id={order.user.id}, request.user.id={request.user.id}, request.user.is_staff={request.user.is_staff}")
                        return False
                except Order.DoesNotExist:
                    logger.debug("Permission denied: Order does not exist.")
                    return False  # Deny if the order does not exist
            logger.debug("Permission denied: Order ID not provided or user not authenticated.")
            return False  # Explicitly deny if order_id is not provided
        return request.user.is_authenticated

    def has_object_permission(self, request, view, obj):
        # Allow access if the user is the owner or an admin
        return obj.user == request.user or request.user.is_staff

class IsOwnerOrderProductDetailOrAdmin(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.method in ['POST', 'PUT', 'PATCH']:
            # Check permission based on the associated order
            order_id = request.data.get('order')
            if order_id is not None and request.user.is_authenticated:
                try:
                    order = Order.objects.get(id=order_id)
                    if order.user == request.user or request.user.is_staff:
                        return True
                    else:
                        logger.debug(f"Permission denied: order.user_id={order.user.id}, request.user.id={request.user.id}, request.user.is_staff={request.user.is_staff}")
                        return False
                except Order.DoesNotExist:
                    logger.debug("Permission denied: Order does not exist.")
                    return False  # Deny if the order does not exist
            logger.debug("Permission denied: Order ID not provided or user not authenticated.")
            return False  # Explicitly deny if order_id is not provided
        return request.user.is_authenticated
    
    def has_object_permission(self, request, view, obj):
        # Allow access if the user is the owner or an admin
        return obj.user == request.user or request.user.is_staff
    