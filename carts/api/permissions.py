from rest_framework import permissions

from carts.models import Cart, CartItem
import logging

logger = logging.getLogger(__name__)

class IsOwnerCartUser(permissions.BasePermission):
    
    def has_permission(self, request, view):
        if request.method in ['POST', 'PUT', 'PATCH', 'DELETE']:
            cart_id = request.data.get('cart')
            if cart_id is not None and request.user.is_authenticated:
                try:
                    cart = Cart.objects.get(id=cart_id)
                    if cart.user == request.user or request.user.is_staff:
                        return True
                    else:
                        return False
                except Cart.DoesNotExist:
                    return False
            return False
        return request.user.is_authenticated

    def has_object_permission(self, request, view, obj):
        return obj.user == request.user or request.user.is_staff


class IsOwnerCartItem(permissions.BasePermission):

    def has_permission(self, request, view):
        if request.method in ['POST', 'PUT', 'PATCH', 'DELETE']:
            cartitem_id = request.data.get('cartitem')
            if cartitem_id is not None and request.user.is_authenticated:
                try:
                    cartitem = CartItem.objects.get(id=cartitem_id)
                    if cartitem.user == request.user or request.user.is_staff:
                        return True
                    else:
                        logger.warning(f"Permission denied for user {request.user.username} on cart item {cartitem_id}.")
                        return False
                except CartItem.DoesNotExist:
                    logger.warning(f"CartItem with id {cartitem_id} does not exist.")
                    return False
            logger.warning(f"No cart item ID provided in request data.")
            return False
        return request.user.is_authenticated

    def has_object_permission(self, request, view, obj):
        if obj.user == request.user or request.user.is_staff:
            return True
        else:
            logger.warning(f"Permission denied for user {request.user.username} on cart item {obj.id}.")
            return False
