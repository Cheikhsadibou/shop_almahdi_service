from rest_framework.pagination import CursorPagination

class PaymentVSCursorPagination(CursorPagination):
    page_size = 5
    ordering = 'created_at'
    cursor_query_param = 'p'
    

class OrderVSCursorPagination(CursorPagination):
    page_size = 5
    ordering = 'created_at'
    cursor_query_param = 'p'
