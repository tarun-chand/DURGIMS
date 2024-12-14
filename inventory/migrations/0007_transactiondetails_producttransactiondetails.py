# Generated by Django 4.1.5 on 2024-02-13 07:46

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('inventory', '0006_unallocatedusers'),
    ]

    operations = [
        migrations.CreateModel(
            name='TransactionDetails',
            fields=[
                ('trans_id', models.AutoField(primary_key=True, serialize=False)),
                ('trans_issue_date', models.DateField()),
                ('issue_received_status', models.CharField(default='No', max_length=3)),
                ('sdm', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='inventory.sectiondesignationmapper')),
            ],
        ),
        migrations.CreateModel(
            name='ProductTransactionDetails',
            fields=[
                ('pro_trans_id', models.AutoField(primary_key=True, serialize=False)),
                ('trans_flag', models.IntegerField(default=0)),
                ('no_of_item_issue', models.IntegerField()),
                ('issue_remarks', models.CharField(max_length=250)),
                ('trans_return_date', models.DateField()),
                ('no_of_item_return', models.IntegerField(default=0)),
                ('return_remarks', models.CharField(default='', max_length=250)),
                ('return_received_status', models.CharField(default='No', max_length=3)),
                ('productid', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='inventory.productdetails')),
                ('trans', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='inventory.transactiondetails')),
            ],
        ),
    ]