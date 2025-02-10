from django.contrib import admin
from django.urls import path
from . import views
from django.contrib.auth import logout

urlpatterns = [
    path('', views.home, name='home'),
    path('about', views.about, name='about'),
    path('faq', views.faq_page, name='faq'),
    path('new', views.news_page, name='news'),
    path('products', views.product_page, name='products'),
    path('detail-product/<int:koi_fish_id>/', views.detail_product, name='detail-product'),
    ## auth
    path('login', views.login, name='login'),
    path('register', views.register, name='register'),
    path('logout', views.logout, name='logout'),
    path('order/<int:koi_fish_id>/', views.order, name='order'),
    path('order-history', views.order_history, name='order-history'),
]
