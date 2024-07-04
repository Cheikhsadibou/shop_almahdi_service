from account.models import Account
from store.models import Product, Variation
from carts.api.permissions import IsOwnerCartItem, IsOwnerCartUser
from carts.api.serializers import CartItemSerializer, CartSerializer
from carts.models import Cart, CartItem
from django.db.models import Q
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt


# from rest_framework.decorators import permission_classes
from rest_framework.exceptions import NotFound
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from rest_framework import generics, viewsets, status
from rest_framework import permissions
from rest_framework.exceptions import PermissionDenied

import logging

logger = logging.getLogger(__name__)

@csrf_exempt
def test_csrf(request):
    if request.method == 'POST':
        return JsonResponse({'status': 'CSRF token accepted'})
    return JsonResponse({'status': 'GET request'})

@csrf_exempt
def test_csrf_session(request):
    if request.method == 'POST':
        csrf_token = request.META.get('HTTP_X_CSRFTOKEN')
        session_key = request.session.session_key
        return JsonResponse({
            'status': 'POST request received',
            'csrf_token': csrf_token,
            'session_key': session_key,
        })
    return JsonResponse({'status': 'GET request'})

@method_decorator(csrf_exempt, name='dispatch')
class AddToCartView(generics.ListCreateAPIView):
    serializer_class = CartItemSerializer

    def get_queryset(self):
        logger.debug("User: %s", self.request.user)
        if self.request.user.is_authenticated:
            return CartItem.objects.filter(user=self.request.user)
        else:
            session_key = self.request.session.session_key
            logger.debug("Session Key: %s", session_key)
            if not session_key:
                self.request.session.create()
                session_key = self.request.session.session_key
                logger.debug("New Session Key: %s", session_key)
            return CartItem.objects.filter(cart__cart_id=session_key)

    def post(self, request, *args, **kwargs):
        logger.debug("POST request data: %s", request.data)
        logger.debug("User: %s", request.user)
        logger.debug("Session key: %s", request.session.session_key)
        logger.debug("CSRF token from header: %s", request.META.get('HTTP_X_CSRFTOKEN'))
        logger.debug("CSRF token from cookie: %s", request.COOKIES.get('csrftoken'))
        logger.debug("CSRF token: %s", request.META.get('CSRF_COOKIE'))

        user = request.user if request.user.is_authenticated else None
        product_id = request.data.get('product_id')
        quantity = request.data.get('quantity', 1)
        color_ids = request.data.get('color', [])
        size_ids = request.data.get('size', [])

        # Get or create the cart for the session key
        session_key = request.session.session_key
        if not session_key:
            request.session.create()
            session_key = request.session.session_key
        
        logger.debug("Session Key in POST: %s", session_key)
        cart, created = Cart.objects.get_or_create(cart_id=session_key)
        logger.debug("Cart ID: %s, Created: %s", cart.id, created)

        try:
            product = Product.objects.get(id=product_id)

            cart_item, created = CartItem.objects.get_or_create(
                user=user,
                product=product,
                cart=cart,
                defaults={'quantity': quantity, 'is_active': True}
            )

            if not created:
                cart_item.quantity += int(quantity)
                cart_item.save()

            # Process color and size variations
            color_variations = Variation.objects.filter(id__in=color_ids, variation_category='color')
            size_variations = Variation.objects.filter(id__in=size_ids, variation_category='size')

            # Log the variations found for debugging
            print(f"Found color variations: {list(color_variations.values('id', 'variation_value'))}")
            print(f"Found size variations: {list(size_variations.values('id', 'variation_value'))}")

            if color_variations.exists() and size_variations.exists():
                cart_item.variations.set(list(color_variations) + list(size_variations))
            else:
                return Response({
                    "error": "Both color and size variations must be provided",
                    "details": {
                        "provided_color_ids": color_ids,
                        "provided_size_ids": size_ids,
                        "color_variations": list(color_variations.values('id', 'variation_value')),
                        "size_variations": list(size_variations.values('id', 'variation_value')),
                    }
                }, status=status.HTTP_400_BAD_REQUEST)

            serializer = self.get_serializer(cart_item)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except Product.DoesNotExist:
            return Response({"error": "Product not found"}, status=status.HTTP_404_NOT_FOUND)
        except Variation.DoesNotExist:
            return Response({"error": "One or more variations not found"}, status=status.HTTP_404_NOT_FOUND)
        
class AddToCartViewDetail(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = CartItemSerializer
    permission_classes = [permissions.IsAuthenticated]
    lookup_field = 'pk'

    def get_queryset(self):
        return CartItem.objects.filter(user=self.request.user)

class CartListView(generics.ListAPIView):
    serializer_class = CartSerializer
    # permission_classes = [permissions.IsAuthenticated]
    permission_classes = [IsOwnerCartUser, permissions.IsAuthenticated]

    def get_queryset(self):
        username = self.kwargs.get('username')
        user = get_object_or_404(Account, username=username)
        cart_items = CartItem.objects.filter(user=user)

        if not cart_items.exists():
            raise NotFound("No cart items for this user")

        cart_ids = cart_items.values_list('cart_id', flat=True)
        carts = Cart.objects.filter(id__in=cart_ids).distinct()

        if not carts.exists():
            raise NotFound("No carts found for this user")

        return carts
class CartDetailView(generics.RetrieveAPIView):
    queryset = Cart.objects.all() 
    serializer_class = CartSerializer
    permission_classes = [permissions.IsAuthenticated]
    lookup_field = 'pk'  # or any other field you are using
    lookup_url_kwarg = 'pk'

class CartItemList(generics.ListCreateAPIView):
    serializer_class = CartItemSerializer
    permission_classes = [IsOwnerCartItem, permissions.IsAuthenticated]  # Ensure user is authenticated

    def get_queryset(self):
        username = self.kwargs.get('username')
        # user = self.request.user
        user = get_object_or_404(Account, username=username)

        logger.info(f"Fetching cart items for user {username} by request user {user.username}")
        logger.debug(f"Request user details: {user} (username: {user.username})")

        if username is not None:
            logger.debug(f"Username provided in URL: {username}")
            # Ensure the username is treated as a string literal
            queryset = CartItem.objects.filter(user__username=username)
            logger.debug(f"Queryset (raw): {queryset.query}")  # Log raw query for debugging
            logger.debug(f"Queryset result: {list(queryset)}")  # Log queryset result            # Ensure the authenticated user is the owner
            
            if not queryset.exists() or (queryset.first().user != user and not user.is_staff):
                logger.warning(f"Unauthorized to access cart item attempt by user {user.username}")
                raise PermissionDenied("You do not have permission to access these Cart Items.")
            return queryset
        else:
            return CartItem.objects.none()  # Return an empty queryset if neither pk nor username is provided

class CartItemDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = CartItem.objects.all()
    serializer_class = CartItemSerializer
    permission_classes = [IsOwnerCartItem, permissions.IsAuthenticated]  # Ensure user is authenticated
    lookup_field = 'pk'
    lookup_url_kwarg = 'pk'
