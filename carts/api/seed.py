from account.models import Account
from carts.models import CartItem, Product

def run():
    user = Account.objects.get(username='Sadibou')
    product = Product.objects.first()  # Or any logic to get a product
    CartItem.objects.create(user=user, product=product, cart_id=1, quantity=2, is_active=True)
