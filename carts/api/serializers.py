from rest_framework import serializers
from carts.models import Cart, CartItem
from store.api.serializers import *

from drf_writable_nested import WritableNestedModelSerializer
from rest_framework.reverse import reverse

class VariationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Variation
        fields = ['id', 'variation_category', 'variation_value']

class CartItemSerializer(WritableNestedModelSerializer, serializers.ModelSerializer):
    user = serializers.StringRelatedField(read_only=True)
    variations = VariationSerializer(many=True, required=False)
    cart = serializers.HyperlinkedRelatedField(
        view_name='cart-detail',
        read_only=True,
        lookup_field='pk',
        lookup_url_kwarg='pk',  # ensure this matches your URL kwarg
    )

    class Meta:
        model = CartItem
        fields = '__all__'

class CartSerializer(WritableNestedModelSerializer, serializers.ModelSerializer):
    # carts = CartItemSerializer(many=True, read_only=True)
    cart_items = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='cartitem-detail',
        lookup_field='pk',
        lookup_url_kwarg='pk',
    )

    class Meta:
        model = Cart
        fields = '__all__'


