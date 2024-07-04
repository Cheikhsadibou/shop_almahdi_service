from django import forms
from .models import Order
from django_filters.rest_framework import FilterSet, BooleanFilter


class OrderForm(forms.ModelForm):
    class Meta:
        model = Order
        fields =('first_name', 'last_name','phone', 'email', 'address_line_1', 'address_line_2','country','state', 'city', 'order_note')

class NullFilter(BooleanFilter):
     """ Filter on a field set as null or not."""
     def filter(self, qs, value):
         if value is not None:
             return qs.filter(**{'%s__isnull' % self.name: value})
         return qs
     
class OrderFilter(FilterSet):
     class Meta:
         model = Order
         fields = ('first_name', 'last_name','phone', 'email', 'address_line_1', 'address_line_2','country','state', 'city', 'order_note')