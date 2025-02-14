from django.db import models
from account.models import Account
from store.models import Product, Variation

# Create your models here.

class Payment(models.Model):
    user = models.ForeignKey(Account, on_delete=models.CASCADE)
    payment_id = models.CharField(max_length=100)
    payment_method = models.CharField(max_length=100)
    amount_paid = models.CharField(max_length=100)
    status = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        # return self.payment_id
        return f"Payment {self.payment_id} by {self.user}"
    
class Order(models.Model):
    STATUS = (
        ('New', 'New'),
        ('Accepted', 'Accepted'),
        ('Completed', 'Completed'),
        ('Cancelled', 'Cancelled'),
    )

    user = models.ForeignKey(Account, on_delete=models.SET_NULL, null=True)
    payment = models.ForeignKey(Payment, on_delete=models.SET_NULL, blank=True, null=True, related_name="payment")
    order_number = models.IntegerField(blank=True, null=True)
    first_name = models.CharField(max_length=70)
    last_name = models.CharField(max_length=70, blank=True, null=True)
    phone = models.CharField(max_length=15)
    email = models.EmailField(max_length=70)
    address_line_1 = models.CharField(max_length=70)
    address_line_2 = models.CharField(max_length=70, blank=True)
    country = models.CharField(max_length=70)
    state = models.CharField(max_length=70)
    city = models.CharField(max_length=70)
    order_note = models.CharField(max_length=200, blank=True)
    order_total = models.FloatField()
    tax = models.FloatField()
    status = models.CharField(max_length=20, choices=STATUS, default='New')
    ip = models.CharField(blank=True, max_length=30)
    is_ordered = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def full_name(self):
        return f'{self.first_name} {self.last_name}'

    def full_address(self):
        return f'{self.address_line_1}, {self.address_line_2}'

    def __str__(self):
        return self.first_name
    

class OrderProduct(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name="product_orders")
    payment = models.ForeignKey(Payment, on_delete=models.SET_NULL, blank=True, null=True, related_name="Product_payment")
    user = models.ForeignKey(Account, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="product")
    variations = models.ManyToManyField(Variation, blank=True)
    quantity = models.IntegerField()
    product_price = models.FloatField()
    ordered = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.product.product_name
