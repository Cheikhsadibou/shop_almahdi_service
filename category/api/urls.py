from django.urls import path, include
from rest_framework import routers
from category.api.views import CategoryAPIView, CategoryVS

# router = routers.DefaultRouter()
# router.register('category', CategoryVS, basename='category')

urlpatterns = [
    # path('', include(router.urls)),
    path('category/', CategoryVS.as_view(), name='category-list)'),
    path('result-category-poduct/', CategoryAPIView.as_view(), name='result-category-poduct'),
]
