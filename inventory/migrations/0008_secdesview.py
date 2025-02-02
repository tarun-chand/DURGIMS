# Generated by Django 4.1.5 on 2024-02-19 10:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('inventory', '0007_transactiondetails_producttransactiondetails'),
    ]

    operations = [
        migrations.CreateModel(
            name='SecDesView',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('sdm_id', models.IntegerField()),
                ('staff', models.IntegerField()),
                ('section', models.IntegerField()),
                ('staff_des_name', models.CharField(max_length=250)),
                ('section_type', models.CharField(max_length=250)),
                ('section_name', models.CharField(max_length=250)),
                ('floor', models.CharField(default='', max_length=250)),
                ('roomno', models.CharField(default='', max_length=250)),
                ('landmark', models.CharField(default='', max_length=250)),
            ],
        ),
    ]
