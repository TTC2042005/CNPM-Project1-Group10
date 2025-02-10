from django.contrib import admin
from .models import  Order, KoiFish



class OrderAdmin(admin.ModelAdmin):
    list_display = ('user', 'order_date', 'total_amount', 'status')
    list_filter = ('status', 'order_date')
    search_fields = ('user__username',)

admin.site.register(Order, OrderAdmin)


class KoiFishAdmin(admin.ModelAdmin):
    list_display = ('name', 'price', 'created_at', 'updated_at')
    list_filter = ('created_at', 'updated_at')
    search_fields = ('name',)

admin.site.register(KoiFish, KoiFishAdmin)