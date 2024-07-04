from rest_framework.serializers import HyperlinkedModelSerializer
from drf_writable_nested import WritableNestedModelSerializer
from drf_extra_fields.fields import Base64ImageField
# from rest_framework import serializers
# from account.api.serializers import AccountSerializer
from category.models import Category
# from store.api import serializers
# from store.api.serializers import Base64ImageField

from rest_framework import serializers
from store.api import serializers

class CategorySerializer(WritableNestedModelSerializer, HyperlinkedModelSerializer):
    product = serializers.ProductSerializer(many=True, read_only=True)
    cat_image = Base64ImageField(required=False)
    # cat_image = Base64ImageField(max_length=None, use_url=True, required=False)
    # product = serializers.ProductSerializer(many=True, read_only=False)
    # user = AccountSerializer(many=True, read_only=True)
    class Meta:
        model = Category
        fields = '__all__'
