from django.db import models
from django.contrib.auth.models import User
# Create your models here.


class KoiFish(models.Model):
    owner = models.ForeignKey(User, on_delete=models.CASCADE, related_name='koi_fish')
    name = models.CharField(max_length=100)
    color = models.CharField(max_length=50)
    size = models.DecimalField(max_digits=5, decimal_places=2)  
    age = models.PositiveIntegerField() 
    category = models.CharField(max_length=50, default="Thường")
    price = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    image = models.CharField(max_length=100, default="https://askoi.vn/wp-content/uploads/2019/09/koi-nhat-shiro-utsuri.jpg")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='orders')
    recipient_name = models.CharField(max_length=100, blank=True) 
    phone_number = models.CharField(max_length=15,  blank=True)  # Số điện thoại
    address = models.TextField(blank=True)  
    order_date = models.DateTimeField(auto_now_add=True)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    koi_fish = models.ManyToManyField(KoiFish, related_name='orders')
    status = models.CharField(
        max_length=20,
        choices=[
            ('pending', 'Pending'),
            ('completed', 'Completed'),
            ('canceled', 'Canceled'),
        ],
        default='pending'
    )

    def __str__(self):
        return f'Order {self.id} by {self.user.username}'