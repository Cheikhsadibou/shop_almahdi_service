from django.urls import path, include
# from carts.api.views import CartDetail, CartList, CartItemVS
from carts.api.views import AddToCartView, AddToCartViewDetail, CartDetailView, CartItemDetail, CartItemList, CartListView, test_csrf, test_csrf_session


urlpatterns = [
    path('carts/test-csrf/', test_csrf, name='test-csrf'),
    path('carts/test-csrf-session/', test_csrf_session, name='test-csrf-session'),

    path('carts/<str:username>/', CartListView.as_view(), name='cart-list'),
    path('carts/<str:username>/<int:pk>/', CartDetailView.as_view(), name='cart-detail'),

    path('carts/add-to-cart/', AddToCartView.as_view(), name='add-to-cart-list'),
    path('cart-item/<int:pk>/', AddToCartViewDetail.as_view(), name='cart-item-detail'),

    path('cart-items/<str:username>/', CartItemList.as_view(), name='cart-item-list'),
    path('cart-item-detail/<str:username>/<int:pk>/', CartItemDetail.as_view(), name='cart-item-detail'),
]
