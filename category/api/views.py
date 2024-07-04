from category.api.serializers import CategorySerializer
from category.models import Category

from rest_framework import viewsets, generics
from rest_framework.permissions import IsAdminUser, IsAuthenticatedOrReadOnly

from category.api.permissions import IsAdminOrReadOnly

# class CategoryVS(viewsets.ModelViewSet):
# 	"""API endpoint for listing Category."""
# 	queryset =  Category.objects.all()
# 	serializer_class = CategorySerializer
# 	permission_classes = [IsAdminOrReadOnly]

class CategoryVS(generics.ListCreateAPIView):
	"""API endpoint for listing Category."""
	queryset =  Category.objects.all()
	serializer_class = CategorySerializer
	permission_classes = [IsAdminOrReadOnly, IsAuthenticatedOrReadOnly]

class CategoryAPIView(generics.ListAPIView):
	"""API endpoint for listing Category."""
	serializer_class = CategorySerializer
	permission_classes = [IsAdminOrReadOnly, IsAuthenticatedOrReadOnly]

	def get_queryset(self):
		pk = self.request.query_params.get('pk', None)
		if pk is not None:
			return Category.objects.filter(category_name=pk)
		return Category.objects.all()
	