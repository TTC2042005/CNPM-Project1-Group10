# Generated by Django 5.1.3 on 2025-02-09 20:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("home", "0003_koifish_image"),
    ]

    operations = [
        migrations.AddField(
            model_name="order",
            name="address",
            field=models.TextField(blank=True),
        ),
        migrations.AddField(
            model_name="order",
            name="phone_number",
            field=models.CharField(blank=True, max_length=15),
        ),
        migrations.AddField(
            model_name="order",
            name="recipient_name",
            field=models.CharField(blank=True, max_length=100),
        ),
    ]
