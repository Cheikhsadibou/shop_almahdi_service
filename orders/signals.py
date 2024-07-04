import logging
from django.db.models.signals import post_save
from django.dispatch import receiver
from orders.models import Payment

logger = logging.getLogger(__name__)

@receiver(post_save, sender=Payment)
def payment_created(sender, instance, created, **kwargs):
    if created:
        logger.info(f"New payment created: {instance}")
        # Add code to send notifications if necessary
