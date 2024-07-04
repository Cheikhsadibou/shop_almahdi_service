from django.urls import path
from category.api.views import CategoryAPIView, CategoryVS
from store.api.views import ProductDetailViewSet, CategoryDetail, ProductDetail, ProductGalleryDeatilView, ProductGalleryLCV, ReviewRatingDetail, ReviewRatingList, ReviewRatingCreate, VariationDetailView, VariationListCreateView, ProductDetailAV, ProductListAV


urlpatterns = [

    path('product-gallery/', ProductGalleryLCV.as_view(), name='productgallery-list-create'),
    path('product-gallery/<int:pk>/', ProductGalleryDeatilView.as_view(), name='productgallery-detail'),

    path('variation/', VariationListCreateView.as_view(), name='variation-list-create'),
    path('variation/<int:pk>/', VariationDetailView.as_view(), name='variation-detail'),

    path('product-detail/<int:pk>/review/', ReviewRatingList.as_view(), name='review-list'),
    path('product-detail/<int:pk>/review-create/', ReviewRatingCreate.as_view(), name='review-create'),
    path('product-detail/review/<str:username>/', ReviewRatingList.as_view(), name='user-review-detail'),
    path('product-list/product-detail/review/<int:pk>/', ReviewRatingDetail.as_view(), name='review-detail'),
    
    path('product-list/', ProductListAV.as_view(), name='product-list-create'),
    path('category/', CategoryVS.as_view(), name='category-list)'),
    path('categories/<int:pk>/', CategoryAPIView.as_view(), name='category-detail'),  # Adjust the view if necessary
    
    path('product-detail/<int:pk>/', ProductDetailAV.as_view(), name='product-detail'),
    path('product-list/result-product-detail/', ProductDetail.as_view(), name='result-product-list'),
    path('product-list/result-product-detail/result-created-date/', ProductDetailViewSet.as_view({'get': 'list', 'post': 'create'}), name='result-created-date'),
    path('product-list/result-product-detail/result-created-date/<int:pk>', ProductDetailViewSet.as_view({'get': 'retrieve', 'put': 'update', 'patch': 'partial_update', 'delete': 'destroy'}), name='result-created-date'),
    path('product-list/result-category/', CategoryDetail.as_view(), name='result-category'),
]
