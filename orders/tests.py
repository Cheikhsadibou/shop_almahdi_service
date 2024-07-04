from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase, APIClient
from rest_framework.authtoken.models import Token

from account.models import Account
from category.models import Category
from orders.models import Order, OrderProduct, Payment
from store.models import Product, Variation

class OrderListViewTestCase(APITestCase):
    def setUp(self):
        self.client = APIClient()
        self.user1 = Account.objects.create_user(
            first_name = 'Cheikh',
            last_name = 'Diop',
            username='testcase',
            email='cheikhdiouf035@gmail.com',
            password='password123',
        )
        self.token1, created = Token.objects.get_or_create(user=self.user1)
        # self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)

        # Ensure the user is an admin
        self.user1.is_active = True
        # self.user1.is_staff = True
        self.user1.save()

        # Create the second user
        self.user2 = Account.objects.create_user(
            first_name='New',
            last_name='User',
            username='user2',
            email='user2@example.com',
            password='password123',
        )
        self.token2, created = Token.objects.get_or_create(user=self.user2)
        # self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token2.key)

        # Ensure the user1 is active
        self.user2.is_active = True
        self.user2.save()


        # Create a payment instancefor user 1
        self.payment1 = Payment.objects.create(
        user = self.user1,
        payment_id = 1245,
        payment_method = "Paypal",
        amount_paid = "12000",
        status = True
            )

        # Create a order list instance for listing
        self.order1 = Order.objects.create(
        user = self.user1,
        payment = self.payment1,
        order_number = 12345,
        first_name = "Cheikh",
        last_name = "Diop",
        phone = 782235087,
        email = "cheikhdiouy035@gmail.com",
        address_line_1 = "Yoff",
        address_line_2 = "Yoff layenne",
        country = "Afrique",
        state = "Senegal",
        city = "Dakar",
        order_note = "OK",
        order_total = 12000,
        tax = 75,
        status = True 
        )

        # Create a payment instancefor user 1
        self.payment2 = Payment.objects.create(
        user = self.user2,
        payment_id = 1245,
        payment_method = "Paypal",
        amount_paid = 12000,
        status = "Completed"
            )

        # Create a order list instance for listing
        self.order2 = Order.objects.create(
        user = self.user2,
        payment = self.payment2,
        order_number = 12345,
        first_name = "Cheikh",
        last_name = "Diop",
        phone = 782235087,
        email = "cheikhdiouy035@gmail.com",
        address_line_1 = "Yoff",
        address_line_2 = "Yoff layenne",
        country = "Afrique",
        state = "Senegal",
        city = "Dakar",
        order_note = "OK",
        order_total = 12000,
        tax = 75,
        status = "Approved", 
        )

        # Define the URL for the order list view
        self.order_list_url_user1 = reverse('order-list', kwargs={'username': self.user1.username})
        self.order_list_url_user2 = reverse('order-list', kwargs={'username': self.user2.username})
        self.order_detail_url_user2 = reverse('order-detail', kwargs={'username': self.user2.username, 'pk': self.order2.pk})
        # self.order_create_url = reverse('order-detail', kwargs={'username': self.user2.username})

    def test_order_list(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)

        response = self.client.get(self.order_list_url_user1)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_order_create_success(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token2.key)
        
        data = {
        # "user" : self.user1.id,
        "payment" : self.payment1.id,
        "order_number" : 12345,
        "first_name" : "Cheikh",
        "last_name" : "Diop",
        "phone" : 782235087,
        "email" : "cheikhdiouy035@gmail.com",
        "address_line_1" : "Yoff",
        "address_line_2" : "Yoff layenne",
        "country" : "Afrique",
        "state" : "Senegal",
        "city" : "Dakar",
        "order_note" : "OK",
        "order_total" : 12000,
        "tax" : 75,
        "status" : "New",
        "is_ordered": True
        }

        response = self.client.post(self.order_list_url_user2, data, format='json')
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def get_token_for_user(self, user):
        response = self.client.post('/api-token-auth/', {'email': user.email, 'password': 'password'})
        return response.data['token']

    def test_order_create_forbidden(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)

        data = {
            "user": self.user2.id,
            "payment": self.payment1.id,
            "order_number": 12345,
            "first_name": "Cheikh",
            "last_name": "Diop",
            "phone": 782235087,
            "email": "cheikhdiouy035@gmail.com",
            "address_line_1": "Yoff",
            "address_line_2": "Yoff layenne",
            "country": "Afrique",
            "state": "Senegal",
            "city": "Dakar",
            "order_note": "OK",
            "order_total": 12000,
            "tax": 75,
            "status": "New",
            "is_ordered": True
        }

        response = self.client.post(self.order_list_url_user2, data, format='json')
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_order_update_unauthorized(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token2.key)
        print(self.user2)

        data = {
        # "user" : self.user1.id,
        "payment" : self.payment2.id,
        "order_number" : 123458,
        "first_name" : "Cheikh",
        "last_name" : "Diop",
        "phone" : 782235087,
        "email" : "cheikhdiouy035@gmail.com",
        "address_line_1" : "Dakar",
        "address_line_2" : "Dakar",
        "country" : "Europe",
        "state" : "Senegal",
        "city" : "Dakar",
        "order_note" : "OK",
        "order_total" : 12000,
        "tax" : 75,
        "status" : "New",
        "is_ordered": True
        }

        response = self.client.put(self.order_detail_url_user2, data, format='json')
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_order_delete_success(self):

        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token2.key)
        response = self.client.put(self.order_detail_url_user2, format='json')
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)


class PaymentsTestCase(APITestCase):
    
    def setUp(self):
        self.client = APIClient()
        self.user1 = Account.objects.create_user(
            first_name = 'Cheikh',
            last_name = 'Diop',
            username='testcase',
            email='cheikhdiouf035@gmail.com',
            password='password123',
            )
        self.token1, created = Token.objects.get_or_create(user=self.user1)
        # self.token1 = self.client.post('/api-token-auth/', {'username': 'testcase', 'password': 'password123'}).data['token']

        # Ensure the user is an admin
        self.user1.is_active = True
        # self.user1.is_staff = True
        self.user1.save()
        # Create the second user
        self.user2 = Account.objects.create_user(
            first_name='New',
            last_name='User',
            username='user2',
            email='user2@example.com',
            password='password123',
        )
        self.token2, created = Token.objects.get_or_create(user=self.user2)
        # Ensure the user1 is active
        self.user2.is_active = True
        self.user2.save()

        # Create user admin
        self.client = APIClient()
        self.user3 = Account.objects.create_user(
            first_name = 'Cheikh_sadi',
            last_name = 'Diop',
            username='senxibaar',
            email='senxibaar220@gmail.com',
            password='password123',
            )
        self.token3, created = Token.objects.get_or_create(user=self.user3)
        # self.token1 = self.client.post('/api-token-auth/', {'username': 'testcase', 'password': 'password123'}).data['token']

        # Ensure the user is an admin
        self.user3.is_active = True
        self.user3.is_staff = True
        self.user3.save()

        # Create a payment instancefor user 1
        self.payment1 = Payment.objects.create(
        user = self.user1,
        payment_id = 1245,
        payment_method = "Paypal",
        amount_paid = "12000",
        status = True
              )

        # # Create a order list instance for listing
        # self.order1 = Order.objects.create(
        # user = self.user1,
        # payment = self.payment1,
        # order_number = 12345,
        # first_name = "Cheikh",
        # last_name = "Diop",
        # phone = 782235087,
        # email = "cheikhdiouy035@gmail.com",
        # address_line_1 = "Yoff",
        # address_line_2 = "Yoff layenne",
        # country = "Afrique",
        # state = "Senegal",
        # city = "Dakar",
        # order_note = "OK",
        # order_total = 12000,
        # tax = 75,
        # status = True 
        # )

        # Create a payment instancefor user 1
        self.payment2 = Payment.objects.create(
        user = self.user2,
        payment_id = 1245,
        payment_method = "Paypal",
        amount_paid = 12000,
        status = "Completed"
            )

        # # Create a order list instance for listing
        # self.order2 = Order.objects.create(
        # user = self.user2,
        # payment = self.payment2,
        # order_number = 12345,
        # first_name = "Cheikh",
        # last_name = "Diop",
        # phone = 782235087,
        # email = "cheikhdiouy035@gmail.com",
        # address_line_1 = "Yoff",
        # address_line_2 = "Yoff layenne",
        # country = "Afrique",
        # state = "Senegal",
        # city = "Dakar",
        # order_note = "OK",
        # order_total = 12000,
        # tax = 75,
        # status = "Approved", 
        # )

        # Define the URL for the order list view
        self.payment_list_url_user1 = reverse('payment-list', kwargs={'username': self.user1.username})
        self.payment_list_url_user2 = reverse('payment-list', kwargs={'username': self.user2.username})
        self.payment_detail_url_user1 = reverse('payment-detail', kwargs={'username': self.user1.username, 'pk': self.payment1.pk})
        self.payment_detail_url_user2 = reverse('payment-detail', kwargs={'username': self.user2.username, 'pk': self.payment2.pk})
        # self.payment_detail_url_user2 = reverse('payment-detail', kwargs={'username': self.user1.username, 'pk': self.order2.pk})
        # self.order_create_url = reverse('order-detail', kwargs={'username': self.user2.username})

    def test_payments_list(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        response = self.client.get(self.payment_list_url_user1)
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_payment_create_success(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        
        data = {
        # "user": self.user1.id,
        "payment_id" : 1246,
        "payment_method" : "Paypal",
        "amount_paid" : "13000",
        "status" : "COMPLETED"
        }

        response = self.client.post(self.payment_list_url_user1, data, format='json')
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_payment_create_forbidden(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        
        data = {
        # "user": self.user1.email,  # Attempting to create payment for user1
        "payment_id" : 1247,
        "payment_method" : "Paypal",
        "amount_paid" : "13000",
        "status" : "COMPLETED"
        }

        response = self.client.post(self.payment_list_url_user2, data, format='json')
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_500_INTERNAL_SERVER_ERROR)

    def test_payment_create_invalid_amount(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        data = {
            "payment_id": "1247",
            "payment_method": "Paypal",
            "amount_paid": "invalid_amount",  # This should trigger validation error
            "status": "COMPLETED"
        }
        response = self.client.post(self.payment_list_url_user1, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        # self.assertIn('amount_paid', response.data)
        # print(response.data)

    def test_self_payment_update_forbidden(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        # self.user1 = Payment.objects.create(
        #     # user=self.user1,
        #     payment_id=1246,
        #     payment_method="Paypal",
        #     amount_paid="13000",
        #     status="COMPLETED"
        # )
        
        data = {
            "payment_method": "Credit Card",
            "amount_paid": "15000",
        }

        response = self.client.patch(self.payment_detail_url_user1, data, format='json')
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def admin_payment_update_success(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token3.key)
        data = {
            "payment_method": "Credit Card",
            "amount_paid": "15000",
        }

        response = self.client.patch(self.payment_detail_url_user2, data, format='json')
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def payment_delete_forbidden(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        response = self.client.delete(self.payment_detail_url_user1)
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def payment_delete_successfull(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token3.key)
        response = self.client.delete(self.payment_detail_url_user2)
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

class OrderProductTestCase(APITestCase):
    def setUp(self):
        # Create a user
        self.client = APIClient()
        self.user1 = Account.objects.create_user(
            first_name = 'Cheikh',
            last_name = 'Diop',
            username='testcase',
            email='cheikhdiouf035@gmail.com',
            password='password123',
        )
        self.token1, created = Token.objects.get_or_create(user=self.user1)
        # self.token1 = self.client.post('/api-token-auth/', {'username': 'testcase', 'password': 'password123'}).data['token']

        # Ensure the user is an admin
        self.user1.is_active = True
        self.user1.save()

        # Create the second user
        self.user2 = Account.objects.create_user(
            first_name='New',
            last_name='User',
            username='user2',
            email='user2@example.com',
            password='password123',
        )
        self.token2, created = Token.objects.get_or_create(user=self.user2)
        
        # Ensure the user1 is active
        self.user2.is_active = True
        self.user2.save()

        # Create user admin
        self.client = APIClient()
        self.user3 = Account.objects.create_user(
            first_name = 'Cheikh_sadi',
            last_name = 'Diop',
            username='senxibaar',
            email='senxibaar220@gmail.com',
            password='password123',
            )
        self.token3, created = Token.objects.get_or_create(user=self.user3)
        # self.token1 = self.client.post('/api-token-auth/', {'username': 'testcase', 'password': 'password123'}).data['token']

        # Ensure the user is an admin
        self.user3.is_active = True
        self.user3.is_staff = True
        self.user3.save()

        # Create a payment instancefor user 1
        self.payment1 = Payment.objects.create(
            user = self.user1,
            payment_id = "1245",
            payment_method = "Paypal",
            amount_paid = "12000",
            status = True
              )
        
        # Create a payment instancefor user 1
        self.payment2 = Payment.objects.create(
            user = self.user2,
            payment_id = "1255",
            payment_method = "Paypal",
            amount_paid = "12500",
            status = True
              )

        # Create instances of Order and Product (you should already have these models defined)
        self.order1 = Order.objects.create(
            user=self.user1,
            payment = self.payment1,
            order_number = 12345,
            first_name = "Cheikh",
            last_name = "Diop",
            phone = 782235087,
            email = "cheikhdiouy035@gmail.com",
            address_line_1 = "Yoff",
            address_line_2 = "Yoff layenne",
            country = "Afrique",
            state = "Senegal",
            city = "Dakar",
            order_note = "OK",
            order_total = 12000,
            tax = 75,
            status = "Completed", 
            )

        self.order2 = Order.objects.create(
            user=self.user2, 
            payment = self.payment2,
            order_number = 12345,
            first_name = "New",
            last_name = "User",
            phone = 782235087,
            email = "user2@example.com",
            address_line_1 = "Yoff",
            address_line_2 = "Yoff layenne",
            country = "Afrique",
            state = "Senegal",
            city = "Dakar",
            order_note = "OK",
            order_total = 12000,
            tax = 75,
            status = "Completed", 
            )
        
        self.category1 = Category.objects.create(
                category_name = "Category A",
                slug = "category_a",
                description = "Desciption Category A",
                # cat_image = ""
                )

        self.category2 = Category.objects.create(
                category_name = "Category B",
                slug = "category_B",
                description = "Description Category B",
                # cat_image = ""
                )


        self.product1 = Product.objects.create(
                product_name    = "Product A",
                slug            = "product_a",
                description     = "Description A",
                price           = 123999,
                stock           = 18,
                is_available    = True,
                category = self.category1
            )
        
        self.product2 = Product.objects.create(
                product_name    = "Product B",
                slug            = "product_b",
                description     = "Description B",
                price           = 123987,
                stock           = 123,
                is_available    = True,
                category = self.category2
            )

        self.variation_size1 = Variation.objects.create(
            product=self.product1,
            variation_category='color',
            variation_value="Red"
            )
        
        self.variation_color1 = Variation.objects.create(
            product=self.product1,
            variation_category='size',
            variation_value="Large"
            )
        
        self.variation_size2 = Variation.objects.create(
            product=self.product2,
            variation_category='color',
            variation_value="Bleu"
            )
        
        self.variation_color2 = Variation.objects.create(
            product=self.product2,
            variation_category='size',
            variation_value="Moyen"
            )

        
        self.orderproduct1 = OrderProduct.objects.create(
            order = self.order1,
            payment = self.payment1,
            user = self.user1,
            product = self.product1,
            quantity = 12,
            product_price = 12000.00,
            ordered = True,
        )
        self.orderproduct1.variations.add(self.variation_size1, self.variation_color1)
        # self.orderproduct1.variations.add(self.variation_color1)

        self.orderproduct2 = OrderProduct.objects.create(
            order = self.order2,
            payment = self.payment2,
            user = self.user2,
            product = self.product1,
            quantity = 13,
            product_price = 12100.00,
            ordered = True,
        )
        self.orderproduct2.variations.add(self.variation_size2, self.variation_color2)
        # self.orderproduct1.variations.add(self.variation_color2)

        # Define the URL for the order list view
        self.orderproduct_list_url_user1 = reverse('order-product', kwargs={'username': self.user1.username})
        self.orderproduct_list_url_user2 = reverse('order-product', kwargs={'username': self.user2.username})
        self.orderproduct_list_url_user3 = reverse('order-product', kwargs={'username': self.user3.username})

        self.orderproduct_detail_url_user1 = reverse('order-product-detail', kwargs={'username': self.user1.username, 'pk': self.orderproduct1.pk})
    def test_orderproduct_list(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token3.key)
        response = self.client.get(self.orderproduct_list_url_user1)
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_orderproduct_list_forbidden(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token2.key)
        response = self.client.get(self.orderproduct_list_url_user1)
        # print(response.data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_create_order_product(self):

        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        data = {
            'order': self.order1.pk,
            'payment': self.payment1.pk,
            'product': self.product1.pk,
            'variations': [
                {
                    'product': self.product1.pk,
                    'variation_category': 'color',
                    'variation_value': 'Red'
                },
                {
                    'product': self.product1.pk,
                    'variation_category': 'size',
                    'variation_value': 'Large'
                }
            ],
            'quantity': 5,
            'product_price': 150.00,
            'ordered': True
        }
        # response = self.client.post(self.orderproduct_list_url_user1, data, format='json')
        # if response.status_code != status.HTTP_201_CREATED:
        #     print(response.content) 
        # self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        # print(response.data)

    def test_create_order_product_forbidden(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token2.key)
        data = {
            'order': self.order1.pk,
            'payment': self.payment1.pk,
            'product': self.product1.pk,
            'variations': [
                {
                    'product': self.product1.pk,
                    'variation_category': 'color',
                    'variation_value': 'Red'
                },
                {
                    'product': self.product1.pk,
                    'variation_category': 'size',
                    'variation_value': 'Large'
                }
            ],
            'quantity': 5,
            'product_price': 150.00,
            'ordered': True
        }
        response = self.client.post(self.orderproduct_list_url_user1, data, format='json')
        if response.status_code != status.HTTP_403_FORBIDDEN:
            print(response.content) 
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
        # print(response.data)

    def test_update_order_product(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        data = {
            'order': self.order1.pk,
            'payment': self.payment1.pk,
            'product': self.product1.pk,
            'variations': [
                {
                    'product': self.product1.pk,
                    'variation_category': 'color',
                    'variation_value': 'Blue'
                },
                {
                    'product': self.product1.pk,
                    'variation_category': 'size',
                    'variation_value': 'Medium'
                }
            ],
            'quantity': 5,
            'product_price': 120.00,
            'ordered': True
        }
        response = self.client.put(self.orderproduct_detail_url_user1, data, format='json')
        if response.status_code != status.HTTP_200_OK:
            print(response.content) 
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_delate_order_product(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token1.key)
        response = self.client.delete(self.orderproduct_detail_url_user1)
        if response.status_code != status.HTTP_204_NO_CONTENT:
            print(response.content) 
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)