from account.models import Account
from orders.api.pagination import PaymentVSCursorPagination
from orders.api.permissions import IsOwnerOnlyOrAdmin, IsAdminOrReadOnly, IsOwnerOrderProductDetailOrAdmin, IsOwnerOrderProductOrAdmin, IsOwnerPaymentsOnlyOrAdmin
from orders.models import OrderProduct, Payment, Order
from orders.api.serializers import OrderSerializer, OrderProductSerializer, PaymentSerializer

from rest_framework.throttling import UserRateThrottle
from rest_framework.exceptions import APIException
from rest_framework.permissions import IsAdminUser
from rest_framework.exceptions import PermissionDenied
from rest_framework import viewsets, permissions, generics

import logging

logger = logging.getLogger(__name__)


# class PaymentVS(viewsets.ReadOnlyModelViewSet):
#     queryset = Payment.objects.all()
#     pagination_class = PaymentVSCursorPagination 
#     serializer_class = PaymentSerializer
#     permission_classes = [IsOwnerOnly, permissions.IsAuthenticated]

# Payments Of User

class PaymentsListView(generics.ListCreateAPIView):
    queryset = Payment.objects.all()
    pagination_class = PaymentVSCursorPagination 
    serializer_class = PaymentSerializer
    permission_classes = [IsOwnerPaymentsOnlyOrAdmin, permissions.IsAuthenticated]
    throttle_classes = [UserRateThrottle]

    def get_queryset(self):
        username = self.kwargs.get('username')
        user = self.request.user
        
        if username is not None:
            queryset = Payment.objects.filter(user__username=username)
            # Ensure the authenticated user is the owner
            if not queryset.exists() or (queryset.first().user != user and not user.is_staff):
                raise PermissionDenied("You do not have permission to access these payments.")
            return queryset
        else:
            return Payment.objects.none()  # Return an empty queryset if neither pk nor username is provided
        
    def get_serializer_context(self):
        context = super().get_serializer_context()
        context['request'] = self.request
        return context

    # def perform_create(self, serializer):
    #     # Ensure that the payment is created for the authenticated user only
    #     serializer.save(user=self.request.user)


    def perform_create(self, serializer):
        try:
            username = self.kwargs.get('username')
            user = self.request.user
            queryset = Payment.objects.filter(user__username=username)
            
            if not queryset.exists() or (queryset.first().user != user and not user.is_staff):
                logger.warning(f"Unauthorized payment creation attempt by user {user.username}")
                raise PermissionDenied("You do not have permission to create a payment for another user.")
            
            serializer.save(user=self.request.user)
            logger.info(f"Payment successfully created by user {user.username}")
        except Exception as e:
            logger.error(f"Error while creating payment: {str(e)}")
            raise APIException("An error occurred while creating the payment.") from e

class PaymentDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Payment.objects.all()
    pagination_class = PaymentVSCursorPagination 
    serializer_class = PaymentSerializer
    permission_classes = [IsAdminOrReadOnly, permissions.IsAuthenticated]


# Order Of User

class OrderListView(generics.ListCreateAPIView):
    serializer_class = OrderSerializer
    permission_classes = [IsOwnerOnlyOrAdmin, permissions.IsAuthenticated]

    def get_queryset(self):
        username = self.kwargs.get('username')
        user = self.request.user

        if username is not None:
            queryset = Order.objects.filter(user__username=username)
            # Ensure the authenticated user is the owner
            if not queryset.exists() or (queryset.first().user != user and not user.is_staff):
                raise PermissionDenied("You do not have permission to access these orders.")
            return queryset
        else:
            return Order.objects.none()
    
    def perform_create(self, serializer):
        # Set the user to the authenticated user, ignoring any user data from the request
        serializer.save(user=self.request.user)

    # def perform_create(self, serializer):
    #     # Check if the authenticated user is trying to create an order for another user
    #     if serializer.validated_data.get('user') and serializer.validated_data['user'] != self.request.user:
    #         raise PermissionDenied("You cannot create an order for another user.")
    #     serializer.save(user=self.request.user)

    # def perform_create(self, serializer):
    #     if serializer.validated_data.get('user') != self.request.user:
    #         raise PermissionDenied("You do not have permission to create an order for another user.")
    #     serializer.save(user=self.request.user)
    
class OrderDetailVS(generics.RetrieveUpdateDestroyAPIView):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    # permission_classes = [IsOwnerOrderUser, permissions.IsAuthenticated]
    permission_classes = [IsAdminOrReadOnly, permissions.IsAuthenticated]

    def get_object(self):
        username = self.kwargs.get('username')
        user = self.request.user
        pk = self.kwargs.get('pk')

        # queryset = Order.objects.filter(user__username=username, pk=pk)
        # if not queryset.exists() or (queryset.first().user != user and not user.is_staff):
        #     raise PermissionDenied("You do not have permission to access this order.")
        # return queryset.first()

        try:
            order = Order.objects.get(user__username=username, pk=pk)
        except Order.DoesNotExist:
            raise PermissionDenied("You do not have permission to access this order.")

        # Debug statement
        print(f"Fetched order for user: {order.user}, Requested by: {user}, Order status: {order.status}")

        if order.user != user and not user.is_staff:
            raise PermissionDenied("You do not have permission to access this order.")

        return order

# Order Products Of User

class OrderProductListView(generics.ListCreateAPIView):
    # queryset = OrderProduct.objects.all() 
    serializer_class = OrderProductSerializer
    permission_classes = [IsOwnerOrderProductOrAdmin, permissions.IsAuthenticated]
    
    def get_queryset(self):
        username = self.kwargs.get('username')
        user = self.request.user

        if username is not None:
            queryset = OrderProduct.objects.filter(user__username=username)
            # Ensure the authenticated user is the owner
            # if not queryset.exists() or queryset.first().user != self.request.user:
            if not queryset.exists() or (queryset.first().user != user and not user.is_staff):
                raise PermissionDenied("You do not have permission to access these Order Products.")
            return queryset
        else:
            return OrderProduct.objects.none()  # Return an empty queryset if neither pk nor username is provided

    def get_serializer_context(self):
        context = super().get_serializer_context()
        context['request'] = self.request
        return context

    # def perform_create(self, serializer):
    #     # Ensure that the payment is created for the authenticated user only
    #     serializer.save(user=self.request.user)


    def perform_create(self, serializer):
        try:
            username = self.kwargs.get('username')
            user = self.request.user
            queryset = OrderProduct.objects.filter(user__username=username)
            
            if not queryset.exists() or (queryset.first().user != user and not user.is_staff):
                logger.warning(f"Unauthorized Order Product creation attempt by user {user.username}")
                raise PermissionDenied("You do not have permission to create a order product for another user.")
            
            serializer.save(user=self.request.user)
            logger.info(f"Orders Product successfully created by user {user.username}")
        except Exception as e:
            logger.error(f"Error while creating order product: {str(e)}")
            raise APIException("An error occurred while creating the order product.") from e


class OrderProductDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = OrderProduct.objects.all()
    serializer_class = OrderProductSerializer
    permission_classes = [IsOwnerOrderProductDetailOrAdmin, permissions.IsAuthenticated]

    def get_queryset(self):
            username = self.kwargs.get('username')
            user = self.request.user

            if username is not None:
                queryset = OrderProduct.objects.filter(user__username=username)
                if not queryset.exists() or (queryset.first().user != user and not user.is_staff):
                    raise PermissionDenied("You do not have permission to access this Order Product.")
                return queryset
            else:
                return OrderProduct.objects.none()  # Return an empty queryset if neither pk nor username is provided
    # def get_object(self):
    #     obj = super().get_object()
    #     user = self.request.user

    #     # Ensure the authenticated user is the owner or an admin
    #     if obj.user != user and not user.is_staff:
    #         raise PermissionDenied("You do not have permission to access this Order Product.")
        
    #     return obj