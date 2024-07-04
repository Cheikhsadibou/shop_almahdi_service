from category.api.serializers import CategorySerializer
from category.models import Category
from store.api.pagination import ListAVCursorPagination, ReviewRatingListCursorPagination
from store.api.permissions import IsAdminOrReadOnly, IsReviewUserOrReadOnly
from store.api.serializers import ReviewRatingSerializer, ProductGallerySerializer, ProductSerializer, VariationSerializer
from store.forms import ReviewRatingFilter
from store.models import ReviewRating, ProductGallery, Product, Variation
from url_filter.integrations.drf import DjangoFilterBackend
from django.db.models import Avg
from django_filters import rest_framework as filters
from django_filters import FilterSet, DateTimeFilter
import django_filters.rest_framework

from rest_framework.permissions import IsAdminUser, IsAuthenticatedOrReadOnly
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework import permissions
from rest_framework.response import Response
from rest_framework import status
from rest_framework import viewsets, generics, filters
from rest_framework.exceptions import ValidationError
from django_filters.rest_framework import DjangoFilterBackend

# class ReviewRatingCreate(generics.CreateAPIView):
#     permission_classes = [IsAuthenticatedOrReadOnly]
#     serializer_class = ReviewRatingSerializer
#     def get_queryset(self):
#         return ReviewRating.objects.all()
#     def perform_create(self, serializer):
#         pk = self.kwargs.get('pk')
#         product = Product.objects.get(pk=pk)
#         review_queryset = ReviewRating.objects.filter(product=product, user=self.request.user)
#         if review_queryset.exists():
#             raise ValidationError("You have already reviewed this product")
#         # if ReviewRating.rating == 0 :
#         #     ReviewRating.rating = serializer.validated_data['rating']
#         # else:
#         #     ReviewRating.rating = (serializer.validated_data['rating'])/2
#         # ReviewRating.rating = ReviewRating.rating + 1
#         # # ReviewRating.rating = round(ReviewRating.rating, 1)
#         # ReviewRating.rating.save()
#         serializer.save(product=product, user=self.request.user)

class ReviewRatingCreate(generics.CreateAPIView):
    permission_classes = [IsAuthenticatedOrReadOnly]
    serializer_class = ReviewRatingSerializer

    def get_queryset(self):
        return ReviewRating.objects.all()

    def perform_create(self, serializer):
        pk = self.kwargs.get('pk')
        product = Product.objects.get(pk=pk)
        user = self.request.user

        # Check if the user has already reviewed the product
        review_queryset = ReviewRating.objects.filter(product=product, user=user)
        if review_queryset.exists():
            raise ValidationError("You have already reviewed this product")

        # Save the new review
        serializer.save(product=product, user=user)

        # Update the product's average rating
        product_reviews = ReviewRating.objects.filter(product=product)
        average_rating = product_reviews.aggregate(Avg('rating'))['rating__avg']
        product.average_rating = average_rating
        product.save()


# class ReviewRatingList(generics.ListAPIView):
#     # queryset = ReviewRating.objects.all()
#     permission_classes = [IsAuthenticatedOrReadOnly]
#     serializer_class = ReviewRatingSerializer
    
#     def get_queryset(self):
#         pk = self.kwargs['pk']
#         return ReviewRating.objects.filter(product=pk)
    
#     def get_queryset(self):
#         username = self.kwargs['username']
#         return ReviewRating.objects.filter(user__username=username)

class ReviewRatingList(generics.ListAPIView):
    permission_classes = [IsAuthenticatedOrReadOnly]
    pagination_class = ReviewRatingListCursorPagination
    serializer_class = ReviewRatingSerializer
    
    def get_queryset(self):
        pk = self.kwargs.get('pk')
        username = self.kwargs.get('username')
        
        if pk is not None:
            return ReviewRating.objects.filter(product=pk)
        elif username is not None:
            return ReviewRating.objects.filter(user__username=username)
        else:
            return ReviewRating.objects.none()  # Return an empty queryset if neither pk nor username is provided

class ReviewRatingDetail(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsReviewUserOrReadOnly ,permissions.IsAuthenticatedOrReadOnly]
    queryset = ReviewRating.objects.all()
    serializer_class = ReviewRatingSerializer
    
# class ProductGalleryVS(viewsets.ModelViewSet):
#     queryset = ProductGallery.objects.all()
#     serializer_class = ProductGallerySerializer
#     permission_classes = [IsAdminOrReadOnly]

class ProductGalleryLCV(generics.ListCreateAPIView):
    queryset = ProductGallery.objects.all()
    serializer_class = ProductGallerySerializer
    permission_classes = [IsAdminOrReadOnly]

class ProductGalleryDeatilView(generics.RetrieveUpdateDestroyAPIView):
    queryset = ProductGallery.objects.all()
    serializer_class = ProductGallerySerializer
    permission_classes = [IsAdminOrReadOnly]

class ProductDetailViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = [IsAdminOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filter_fields = ['=created_date', 'modified_date']

# class ProductListAV(APIView):
#     # pagination_class = ProductListAVPagination
#     permission_classes = [IsAdminOrReadOnly]
#     def get(self, request):
#         products = Product.objects.all()
#         serializer = ProductSerializer(products, many=True, context={'request': request})
#         return Response(serializer.data)

#     def post(self, request):
#         serializer = ProductSerializer(data=request.data, context={'request': request})
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         else:
#             return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ProductListAV(generics.ListCreateAPIView):
    pagination_class = ListAVCursorPagination
    permission_classes = [IsAdminOrReadOnly]
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

import logging

logger = logging.getLogger(__name__)

class ProductFilter(FilterSet):
    # created_date = filters.DateFilter(field_name='created_date', lookup_expr='exact')
    created_date = DateTimeFilter(field_name='created_date', lookup_expr='exact')

    class Meta:
        model = Product
        fields = ['created_date', 'stock', 'is_available', 'product_name', 'price']

class ProductDetail(generics.ListAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    filter_backends = [django_filters.rest_framework.DjangoFilterBackend, filters.OrderingFilter]
    filterset_class = ProductFilter
    ordering_fields = ['stock', 'price', 'created_date']
    def get_queryset(self):
        queryset = super().get_queryset()
        logger.debug(queryset.query)
        return queryset
    
# class ProductDetail(generics.ListAPIView):
#     queryset = Product.objects.all()
#     serializer_class = ProductSerializer
#     filter_backends = [filters.SearchFilter, filters.OrderingFilter]
#     search_fields = ['=stock', 'is_available', '=product_name', '=price']
#     ordering_fields  = ['stock', 'price', 'created_date']

class CategoryDetail(generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ['category_name']

# class CategoryList(generics.ListAPIView):
#     queryset = Category.objects.all()
#     serializer_class = CategorySerializer
 
#     def get_queryset(self):
#         """
#         This view should return a list of all the purchases
#         for the currently authenticated user.
#         """
#         pk = self.kwargs['pk']
#         return Category.objects.filter(category_name=pk)
        

# class ProductDetailAV(APIView):
#     permission_classes = [IsAdminOrReadOnly]
#     def get(self, request, pk):
#         try:
#             product = Product.objects.get(pk=pk)
#         except Product.DoesNotExist:
#             return Response(status=status.HTTP_404_NOT_FOUND)
#         serializer = ProductSerializer(product, context={'request': request})
#         return Response(serializer.data)
    
#     def put(self, request, pk):
#         product = Product.objects.get(pk=pk)
#         serializer = ProductSerializer(product, data=request.data, context={'request': request})
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         else:
#             return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#     def delete(self, request, pk):
#         product = Product.objects.get(pk=pk)
#         product.delete()
#         return Response(status=status.HTTP_204_NO_CONTENT)


class ProductDetailAV(APIView):
    permission_classes = [IsAdminOrReadOnly]

    def get(self, request, pk):
        try:
            product = Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            return Response({'error': 'Product not found.'}, status=status.HTTP_404_NOT_FOUND)
        serializer = ProductSerializer(product, context={'request': request})
        return Response(serializer.data)

    def put(self, request, pk):
        try:
            product = Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            return Response({'error': 'Product not found.'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = ProductSerializer(product, data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk):
        try:
            product = Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            return Response({'error': 'Product not found.'}, status=status.HTTP_404_NOT_FOUND)

        product.delete()
        return Response({'message': f'Product {Product.product_name} has been deleted successfully.'}, status=status.HTTP_204_NO_CONTENT)

# class ProductDetailAV(generics.RetrieveUpdateDestroyAPIView):
#     queryset = Product.objects.all()
#     serializer_class = ProductSerializer
#     # permission_classes = [IsAdminUser]

# class VariationVS(viewsets.ModelViewSet):
#     queryset = Variation.objects.all()
#     serializer_class  = VariationSerializer
#     permission_classes = [IsAdminOrReadOnly]


class VariationListCreateView(generics.ListCreateAPIView):
    queryset = Variation.objects.all()
    serializer_class = VariationSerializer
    permission_classes = [IsAdminOrReadOnly]

class VariationDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Variation.objects.all()
    serializer_class = VariationSerializer
    permission_classes = [IsAdminOrReadOnly]
    