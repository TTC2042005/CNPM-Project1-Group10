from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    pass

class Order(models.Model):
    product = models.CharField(max_length=100)
    quantity = models.IntegerField()
    address = models.CharField(max_length=200)
    status = models.CharField(max_length=50, default='Pending')

class Contact(models.Model):
    name = models.CharField(max_length=150)
    email = models.EmailField()
    message = models.TextField()