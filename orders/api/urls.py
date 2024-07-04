from django.urls import path
from orders.api.views import OrderProductListView, OrderProductDetailView, OrderDetailVS, PaymentsListView, OrderListView, PaymentDetailView

# router = routers.DefaultRouter()
# router.register('payment', PaymentVS, basename='payment')
# router.register('order', OrderVS, basename='order')
# router.register('order-product', OrderProductVS, basename='order_product')

urlpatterns = [
    # Path of Payments User
    path('payment-user/<str:username>/', PaymentsListView.as_view(), name='payment-list'), 
    path('payment-user/<str:username>/<int:pk>/', PaymentDetailView.as_view(), name='payment-detail'), 

    # Path of orders user
    # path('', include(router.urls)),
    path('orders/<str:username>/', OrderListView.as_view(), name='order-list'),
    path('orders/<str:username>/<int:pk>/', OrderDetailVS.as_view(), name='order-detail'),

    # Path of Orders Products user
    path('order-product/<str:username>/', OrderProductListView.as_view(), name='order-product'),
    path('order-product/<str:username>/<int:pk>/', OrderProductDetailView.as_view(), name='order-product-detail')
]
