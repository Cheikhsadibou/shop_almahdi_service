from rest_framework.throttling import UserRateThrottle, AnonRateThrottle

class ProductDetailViewSetThrottle(AnonRateThrottle):
    scope = 'result-created-date'
    
class ReviewRatingDetailThrottle(AnonRateThrottle):
    scope = 'updat-review'
