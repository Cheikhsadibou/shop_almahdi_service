from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings
from ecom import views

urlpatterns = [
    path('admin/', include('admin_honeypot.urls', namespace='admin_honeypot')),
    path('panelcontrol/', admin.site.urls),
    path('', views.home, name='home'),
    path('store/', include('store.urls')),
    path('stores/', include('store.api.urls')),
    path('cart/', include('carts.urls')),
    path('category/', include('category.api.urls')),
    path('carts/', include('carts.api.urls')),
    path('account/', include('account.urls')),
    path('account-api/', include('account.api.urls')),
    path('orders/', include('orders.urls')),
    path('orders-api/', include('orders.api.urls')),
    # path('api-auth/', include('rest_framework.urls', namespace="rest_framework")),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
 