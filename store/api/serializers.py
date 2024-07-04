from account.api.serializers import AccountSerializer
from category.models import Category
from store.models import Product, Variation, ReviewRating, ProductGallery

from drf_writable_nested import WritableNestedModelSerializer
from drf_extra_fields.fields import Base64ImageField
from rest_framework.serializers import HyperlinkedModelSerializer
from rest_framework import serializers

class VariationSerializer(WritableNestedModelSerializer, serializers.ModelSerializer):
    # product = ProductSerializer(many=True, read_only=False)
    class Meta:
        model = Variation
        fields = '__all__'

 
class ReviewRatingSerializer(WritableNestedModelSerializer, serializers.ModelSerializer):
    # reviewratings = ProductSerializer(read_only=False, many=True)
    # user = AccountSerializer(many=True, read_only=True)
    user = serializers.StringRelatedField(read_only=True)
    class Meta:
        exclude = ('ip', 'product')
        model = ReviewRating
        # fields = '__all__'
        # fields = ['id', 'user', 'subject', 'review', 'rating', 'created_at']

    def validate_rating(self, value):
        if value < 0 or value > 5:
            raise serializers.ValidationError("Rating must be between 0 and 5.")
        return value

class ProductGallerySerializer(WritableNestedModelSerializer, HyperlinkedModelSerializer):
    # product_gallery = ProductSerializer(read_only=False, many=True)
    image = Base64ImageField(required=False)
    class Meta:
        exclude = ('url',)
        model = ProductGallery
        # fields = '__all__'

class ProductSerializer(WritableNestedModelSerializer, HyperlinkedModelSerializer):
    # variation_set = VariationSerializer(many=True, read_only=True)
    variation_set = serializers.SerializerMethodField()
    images = Base64ImageField(required=False)
    productgallerys = ProductGallerySerializer(many=True, read_only=True)
    reviewsratings = ReviewRatingSerializer(many=True, read_only=True)
    # category = serializers.HyperlinkedRelatedField(
    #     queryset=Category.objects.all(),
    #     view_name='category-detail',
    #     lookup_field='pk'
    # )
    class Meta:
        model = Product
        # exclude = ('product_name', 'slug', 'description', 'price', 'images', 'category', 'stock', 'is_available', 'created_date', 'modified_date')
        exclude = ('created_date', 'modified_date')
        # fields = '__all__'
        # fields = ['id', 'product_name', 'slug', 'description', 'price', 'stock', 'is_available', 'created_date', 'modified_date']
    
    def get_variation_set(self, obj):
        colors = list(obj.variation_set.colors().values_list('variation_value', flat=True))
        sizes = list(obj.variation_set.sizes().values_list('variation_value', flat=True))
        return {'colors': colors, 'sizes': sizes}
    