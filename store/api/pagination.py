from rest_framework.pagination import PageNumberPagination, CursorPagination

class ListAVCursorPagination(CursorPagination):
    page_size = 15
    ordering = 'created_date'
    cursor_query_param = 'p'
    

class ReviewRatingListCursorPagination(CursorPagination):
    page_size = 10
    ordering = 'created_at'
    cursor_query_param = 'p'
