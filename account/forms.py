from django import forms
from .models import Account, UserProfile
from django_filters.rest_framework import BooleanFilter, FilterSet 

class RegistrationForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'placeholder':'Enter Password'
    }))

    confirm_password = forms.CharField(widget=forms.PasswordInput(attrs={
        'placeholder':'Confirm Password'
    }))

    class Meta:
        model = Account
        fields = ['first_name', 'last_name', 'phone_number', 'email', 'password']

    def clean(self):
        cleaned_data = super(RegistrationForm, self).clean()
        password = cleaned_data.get('password')
        confirm_password = cleaned_data.get('confirm_password')

        if password != confirm_password:
            raise forms.ValidationError(
                "Password does not match !"
                )

    def __init__(self, *args, **kwargs):
        super(RegistrationForm, self).__init__( *args, **kwargs)
        self.fields['first_name'].widget.attrs['placeholder'] = 'Enter First_name'
        self.fields['last_name'].widget.attrs['placeholder'] = 'Enter last_name'
        self.fields['phone_number'].widget.attrs['placeholder'] = 'Enter Phone_number'
        self.fields['email'].widget.attrs['placeholder'] = 'Enter Email Address '
        
        for field in self.fields:
            self.fields[field].widget.attrs['class'] = 'form-control'

class UserForm(forms.ModelForm):
    class Meta:
        model = Account
        fields = ('first_name', 'last_name', 'phone_number')

    def __init__(self, *args, **kwargs):
        super(UserForm, self).__init__( *args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs['class'] = 'form-control'



class UserProfileForm(forms.ModelForm):
    profile_picture = forms.ImageField(required=False, error_messages = {'invalid':("Image files only")}, widget=forms.FileInput)
    class Meta:
        model = UserProfile
        fields = ('adress_line_1', 'adress_line_2', 'city', 'state', 'country', 'profile_picture')

    def __init__(self, *args, **kwargs):
        super(UserProfileForm, self).__init__( *args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs['class'] = 'form-control'

class NullFilter(BooleanFilter):
     """ Filter on a field set as null or not."""
     def filter(self, qs, value):
         if value is not None:
             return qs.filter(**{'%s__isnull' % self.name: value})
         return qs

class AccountFilter(FilterSet):
     class Meta:
         model = Account
         fields = ('username', 'first_name', 'last_name', 'email', 'phone_number')