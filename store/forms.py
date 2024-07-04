from django import forms
from .models import ReviewRating
from django_filters.rest_framework import FilterSet, BooleanFilter, NumberFilter, CharFilter, DateFilter

class ReviewForm(forms.ModelForm):
    class Meta:
        model = ReviewRating
        fields =['subject', 'review', 'rating']

class NullFilter(BooleanFilter):
     """ Filter on a field set as null or not."""
     def filter(self, qs, value):
         if value is not None:
             return qs.filter(**{'%s__isnull' % self.name: value})
         return qs
     
class ReviewRatingFilter(FilterSet):
    # subject = CharFilter(field_name='subject', lookup_expr='icontains')
    # review = CharFilter(field_name='review', lookup_expr='icontains')
    # rating = NumberFilter(field_name='rating')
    # created_at = DateFilter(field_name='created_at')
    # updated_at = DateFilter(field_name='updated_at')
    # status = BooleanFilter(field_name='status')
    class Meta:
        model = ReviewRating
        fields = ['subject', 'review', 'rating', 'created_at', 'updated_at', 'status']

# class ProductFilter(FilterSet):
#     min_price = NumberFilter(field_name="price", lookup_expr='gte')
#     max_price = NumberFilter(field_name="price", lookup_expr='lte')
#     name = CharFilter(field_name='product_name', lookup_expr='icontains')
#     category = CharFilter(field_name='category__category_name', lookup_expr='icontains')
#     description = CharFilter(field_name='description', lookup_expr='icontains')
#     is_available = BooleanFilter(field_name='is_available')
#     created_date = DateFilter(field_name='created_date')
#     modified_date = DateFilter(field_name='modified_date')
#     in_stock = NullFilter(field_name='stock')
#     class Meta:
#         model = Product
#         fields = ['min_price', 'max_price', 'name', 'category', 'description', 'is_available', 'created_date', 'modified_date', 'in_stock']
