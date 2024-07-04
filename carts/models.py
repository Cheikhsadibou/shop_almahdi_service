from django.db import models
from account.models import Account
from store.models import Product, Variation

# Create your models here.

class Cart(models.Model):
  cart_id = models.CharField(max_length=100, blank=True)
  date_added = models.DateField(auto_now_add=True)
  
  class Meta:
    db_table = 'Cart' 
    ordering = ['date_added']
    
  def __str__(self):
    return self.cart_id
    
class CartItem(models.Model):
  user = models.ForeignKey(Account, on_delete=models.Case, null=True)
  product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='products')
  variations = models.ManyToManyField(Variation, blank=True, related_name='variations')
  cart = models.ForeignKey(Cart, on_delete=models.CASCADE, null=True, related_name='carts')
  quantity = models.IntegerField()
  is_active = models.BooleanField(default=True)
  
  def sub_total(self):
    return self.product.price * self.quantity
  
  def __unicode__(self):
    return self.product
  