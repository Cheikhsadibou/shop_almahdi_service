from orders.models import Order, OrderProduct, Payment
from store.models import Product, Variation
from store.api import serializers

from rest_framework.serializers import ModelSerializer, StringRelatedField, CharField, ValidationError, PrimaryKeyRelatedField
from drf_writable_nested import WritableNestedModelSerializer

class PaymentSerializer(WritableNestedModelSerializer, ModelSerializer):
    user = StringRelatedField(read_only=True)
    # user = serializers.AccountSerializer(many=False, read_only=True)
    class Meta:
        model = Payment
        fields = "__all__"
        read_only_fields = ('user',)

    def validate_amount_paid(self, value):
    # Ensure amount_paid is converted to a numeric type
        try:
            value = float(value)
        except ValueError:
            raise ValidationError("Amount paid must be a number.")

        if value <= 0:
            raise ValidationError("Amount paid must be greater than zero.")
        
        return value
    def create(self, validated_data):
        request = self.context.get('request', None)
        if request and 'user' not in validated_data:
            validated_data['user'] = request.user
        return super().create(validated_data)

    # def create(self, validated_data):
    #     request = self.context.get('request')
    #     validated_data['user'] = request.user
    #     return super().create(validated_data)


class OrderSerializer(WritableNestedModelSerializer, ModelSerializer):
    user = StringRelatedField(read_only=True)
    class Meta:
        model = Order
        fields = "__all__"
        read_only_fields = ('user',)
    def create(self, validated_data):
        request = self.context.get('request')
        validated_data['user'] = request.user
        return super().create(validated_data)
    
class VariationSerializer(WritableNestedModelSerializer, ModelSerializer):
    # product = PrimaryKeyRelatedField(queryset=Product.objects.all())
    
    class Meta:
        model = Variation
        fields = ['id', 'product', 'variation_category', 'variation_value']
    
class OrderProductSerializer(WritableNestedModelSerializer, ModelSerializer):
    user = StringRelatedField(read_only=True)
    variations = VariationSerializer(many=True, required=False)
    order = PrimaryKeyRelatedField(queryset=Order.objects.all())
    payment = PrimaryKeyRelatedField(queryset=Payment.objects.all())
    product = PrimaryKeyRelatedField(queryset=Product.objects.all())
    
    class Meta:
        model = OrderProduct
        fields = "__all__"

    def create(self, validated_data):
        variations_data = validated_data.pop('variations', [])
        # user = self.context['request'].user  # Get the user from the request context
        order_product = OrderProduct.objects.create(**validated_data)

        for variation_data in variations_data:
            variation_data['product'] = validated_data['product']  # Ensure the product is correctly associated
            Variation.objects.create(**variation_data)
        
        return order_product
    
    # def create(self, validated_data):
    #     request = self.context.get('request', None)
    #     if request and 'user' not in validated_data:
    #         validated_data['user'] = request.user
    #     return super().create(validated_data)

