from rest_framework import status
from django.urls import reverse
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.test import APITestCase, APIClient
from rest_framework.authtoken.models import Token

from account.models import Account
from carts.models import Cart, CartItem
from category.models import Category
from store.models import Product, Variation

# Create your tests here.

class CartTestCase(APITestCase):
    def setUp(self):
        self.client = APIClient()
        self.user1 = Account.objects.create_user(
            first_name = 'Sadibou',
            last_name = 'Diop',
            username='testcase1',
            email='chopalmahdiservice@gmail.com',
            password='password123',
        )
        self.token1, created = Token.objects.get_or_create(user=self.user1)
        # self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)

        # Ensure the user is an admin
        self.user1.is_active = True
        self.user1.save()

        # Create a category instance
        self.category = Category.objects.create(category_name="Super cent", slug="super-cent")

        # Create a cart instancefor user 1
        self.cart1 = Cart.objects.create(cart_id = "1296354")

        # Create a product instance for updating
        self.product1 = Product.objects.create(
            product_name="product_name_ON",
            slug="product_name_on",
            description="description",
            price=12000,
            stock=100,
            category=self.category
        )

        # Create color variation instance
        self.color_variation1 = Variation.objects.create(
            product=self.product1,
            variation_category="color",
            variation_value="Green",
            is_active=True
        )

        # Create size variation instance
        self.size_variation1 = Variation.objects.create(
            product=self.product1,
            variation_category="size",
            variation_value="L",
            is_active=True
        )

        # Create a cartitem instancefor user 1
        self.cartitem1 = CartItem.objects.create(
            user = self.user1,
            product = self.product1,
            cart = self.cart1,
            quantity = 13,
            is_active = True
        )
        self.cartitem1.variations.set([self.color_variation1, self.size_variation1])

        # Define the URL for the order list view
        self.cart_list1 = reverse('cart-list', kwargs={'username': self.user1.username})
        self.cart_detail1 = reverse('cart-detail', kwargs={'username': self.user1.username, 'pk': self.cart1.pk})
        
        self.add_to_cart1 = reverse('add-to-cart-list')


    # def setUp(self):
        self.client = APIClient()
        self.user2 = Account.objects.create_user(
            first_name = 'Cheikh',
            last_name = 'Diop',
            username='testcase2',
            email='senxibaar220@gmail.com',
            password='password123',
        )
        self.token2, created = Token.objects.get_or_create(user=self.user2)
        # self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token2.key)

        # Ensure the user is an admin
        self.user2.is_active = True
        self.user2.save()

        # Create a category instance
        # self.category = Category.objects.create(category_name="Super cent", slug="super-cent")


        # Create a cart instancefor user 2
        self.cart2 = Cart.objects.create(cart_id = "1286354")

        # Create a product instance for updating
        self.product2 = Product.objects.create(
            product_name="product_name_two",
            slug="product_name_two",
            description="description",
            price=13000,
            stock=100,
            category=self.category
        )

        # Create color variation instance
        self.color_variation2 = Variation.objects.create(
            product=self.product2,
            variation_category="color",
            variation_value="Green",
            is_active=True
        )

        # Create size variation instance
        self.size_variation2 = Variation.objects.create(
            product=self.product2,
            variation_category="size",
            variation_value="L",
            is_active=True
        )

        # Create a cartitem instancefor user 2
        self.cartitem2 = CartItem.objects.create(
            user = self.user2,
            product = self.product2,
            cart = self.cart2,
            quantity = 12,
            is_active = True
        )
        self.cartitem2.variations.set([self.color_variation2, self.size_variation2])

        # Define the URL for the order list view
        self.cart_list2 = reverse('cart-list', kwargs={'username': self.user2.username})
        self.cart_detail2 = reverse('cart-detail', kwargs={'username': self.user2.username, 'pk': self.cart2.pk})

        self.add_to_cart2 = reverse('add-to-cart-list')

    # def setUp(self):
        self.client = APIClient()
        self.user3 = Account.objects.create_user(
            first_name = 'Cheikh',
            last_name = 'Diop',
            username='testcase',
            email='cheikhdiouf035@gmail.com',
            password='password123',
        )
        self.token3, created = Token.objects.get_or_create(user=self.user3)
        # self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token2.key)

        # Ensure the user is an admin
        self.user3.is_active = True
        self.user3.is_staff = True
        self.user3.save()

        # Create a category instance
        # self.category = Category.objects.create(category_name="Super cent", slug="super-cent")

        # Create a cart instancefor user 1
        self.cart3 = Cart.objects.create(cart_id = "1296354")

        # Create a product instance for updating
        self.product3 = Product.objects.create(
            product_name="product_name_tree",
            slug="product_name_tree",
            description="description",
            price=11000,
            stock=100,
            category=self.category
        )


        # Create color variation instance
        self.color_variation3 = Variation.objects.create(
            product=self.product3,
            variation_category="color",
            variation_value="Green",
            is_active=True
        )

        # Create size variation instance
        self.size_variation3 = Variation.objects.create(
            product=self.product3,
            variation_category="size",
            variation_value="L",
            is_active=True
        )

        # Create a cartitem instancefor user 1
        self.cartitem3 = CartItem.objects.create(
            user = self.user3,
            product = self.product3,
            cart = self.cart3,
            quantity = 13,
            is_active = True
        )
        self.cartitem3.variations.set([self.color_variation3, self.size_variation3])

        # Define the URL for the order list view
        self.cart_list3 = reverse('cart-list', kwargs={'username': self.user3.username})
        self.cart_detail3 = reverse('cart-detail', kwargs={'username': self.user3.username, 'pk': self.cart3.pk})

        self.add_to_cart3 = reverse('add-to-cart-list')

    def test_cart_list(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        response = self.client.get(self.cart_list1)
        # if response.status_code != status.HTTP_204_NO_CONTENT:
        #     print(response.content)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        response_data = response.json()
        self.assertEqual(response_data[0]['cart_id'], '1296354')
        self.assertIn('id', response_data[0])
        self.assertIn('date_added', response_data[0])
    
    # def test_cart_item_associations(self):
    #     self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
    #     # Verify the associations
    #     cart_items = CartItem.objects.filter(user=self.user1)
    #     self.assertTrue(cart_items.exists(), "Cart items should exist for this user")
    #     for item in cart_items:
    #         self.assertIsNotNone(item.cart, f"CartItem ID: {item.id} should have an associated Cart")
    #         print(f"CartItem ID: {item.id}, Cart ID: {item.cart.id}")

    #     # Make a request to the CartListView
    #     response = self.client.get(self.cart_list1, format='json')
    #     if response.status_code != status.HTTP_200_OK:
    #         print(response.content)
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)
    #     print(response.data)

    @csrf_exempt
    def test_add_to_cart(self):
        # self.client.credentials(HTTP_AUTHORIZATION='Token '+ self.token1.key)
        self.client.credentials()  # Ensure no credentials are set
        response = self.client.post(self.add_to_cart1, {
            "product_id": self.product1.id,
            "quantity": 5,
            "color": [self.color_variation1.id],
            "size": [self.size_variation1.id],
            # "cart": self.cart1.id
        })
        if response.status_code!= status.HTTP_201_CREATED:
            print(response.content)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        response_data = response.json()
        self.assertEqual(response_data['cart_id'], '1296354')
        self.assertIn('id', response_data)
        self.assertIn('quantity', response_data)
        return JsonResponse({"message": "CSRF exempt test successful!"})
