from django.db import models

class ProductCategoryMaster(models.Model):
    product_cat_id = models.AutoField(primary_key=True)
    product_type = models.CharField("Product Type",max_length=20, choices=(
        ('Consumable', 'Consumable'), ('Non-Consumable', 'Non-Consumable')))
    product_cat_name = models.CharField(max_length=250)

class ProductCompanyMaster(models.Model):
    product_com_id = models.AutoField(primary_key=True)
    product_cat = models.ForeignKey(
        ProductCategoryMaster, on_delete=models.CASCADE)
    product_com_name = models.CharField(max_length=250)

class ProductModelMaster(models.Model):
    product_mod_id = models.AutoField(primary_key=True)
    product_com = models.ForeignKey(
        ProductCompanyMaster, on_delete=models.CASCADE)
    product_mod_name = models.CharField(max_length=250)

class PurchaseDetails(models.Model):
    purchase_id = models.AutoField(primary_key=True)        
    purchase_date = models.DateField(auto_now_add=True)
    billmemono = models.CharField(max_length=50)
    purchased_by = models.CharField(max_length=50, choices=(
        ('High Court Bilashpur', 'High Court Bilashpur'), ('District Court Durg', 'District Court Durg')))
    purchased_for = models.CharField(max_length=50, choices=(
        ('District Court Durg', 'DCD'), ('District Court Durg-POCSO', 'DCD_POCSO'), ('District Court Durg-SPECIAL', 'DCD_SP')))
    purchase_remarks = models.CharField(max_length=350)    
    # billmemodoc = models.CharField(max_length=350)
    billmemodoc = models.FileField(upload_to="BillMemo/")

class ProductPuchaseDetails(models.Model):
    propur_id = models.AutoField(primary_key=True) 
    purchase = models.ForeignKey(
        PurchaseDetails, on_delete=models.CASCADE)    
    propur_remarks = models.CharField(max_length=350)
    # box_detail = models.CharField(max_length=350)
    box_detail = models.FileField(upload_to="productBoxDetails/")
    product = models.ForeignKey(
        ProductModelMaster, on_delete=models.CASCADE)
    no_of_item = models.CharField(max_length=250)

class ProductDetails(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_serialno = models.CharField(max_length=250,default='None', editable=False)
    entry_date = models.DateField(auto_now_add=True)
    initial_quantity = models.IntegerField(editable = False,default=1)
    current_quantity = models.IntegerField()
    cartridge_toner = models.CharField(max_length=250)
    remarks = models.CharField(max_length=300)
    product_new_or_open = models.CharField(max_length=7,default='NEW PRODUCT')       
    product_mod = models.ForeignKey(
        ProductModelMaster, on_delete=models.CASCADE)
    propur = models.ForeignKey(
        ProductPuchaseDetails, on_delete=models.CASCADE,default=1) 

class CourtEstablishmentMaster(models.Model):
    est_id = models.AutoField(primary_key=True)
    est_name = models.CharField(max_length=250)

class BuildingMaster(models.Model):
    building_id = models.AutoField(primary_key=True)
    est = models.ForeignKey(CourtEstablishmentMaster, on_delete=models.CASCADE)
    building_name = models.CharField(max_length=250)
    
class SectionDetails(models.Model):
    section_id = models.AutoField(primary_key=True)    
    section_type = models.CharField(max_length=10, choices=(
        ('Court', 'Court'), ('Section', 'Section')))
    section_name = models.CharField(max_length=250)
    floor = models.CharField(max_length=250,default='')
    roomno = models.CharField(max_length=250,default='')
    landmark = models.CharField(max_length=250,default='')
    building = models.ForeignKey(BuildingMaster, on_delete=models.CASCADE)
    deleted = models.BooleanField(default=False)
  
    
class UserDetails(models.Model):
    usr_id = models.AutoField(primary_key=True)    
    usr_name = models.CharField(max_length=250)
    usr_mobile = models.CharField(max_length=250)
    entry_date = models.DateField(auto_now_add=True)    
    usr_type = models.CharField(max_length=10, choices=(
        ('Judge', 'Judge'), ('Staff', 'Staff')))
    deleted = models.BooleanField(default=False)

class staffDesignationMaster(models.Model):
    staff_id = models.AutoField(primary_key=True)
    staff_des_name = models.CharField(max_length=250)
    staff_type = models.CharField(max_length=10, choices=(
        ('Court', 'Court'), ('Section', 'Section')))

class SectionDesignationMapper(models.Model):
    sdm_id = models.AutoField(primary_key=True)      
    staff =  models.ForeignKey(staffDesignationMaster, on_delete=models.CASCADE)
    section = models.ForeignKey(SectionDetails, on_delete=models.CASCADE) 
    ip_address = models.CharField(max_length=250,default='')    
  
# class ProductTransactionDetails(models.Model):
#     pro_trans_id = models.AutoField(primary_key=True)
#     sdm  = models.ForeignKey(
#         SectionDesignationMapper, on_delete=models.CASCADE)
#     product  = models.ForeignKey(
#         ProductDetails, on_delete=models.CASCADE)     
#     issue_date = models.DateField()
#     no_of_item_issue = models.IntegerField()
#     issue_remarks = models.CharField(max_length=250)      
#     return_date = models.DateField()
#     no_of_item_return = models.IntegerField(default=0)
#     return_remarks = models.CharField(max_length=250,default='')
#     trans_flag = models.CharField(max_length=2) # I - Issued , R-Return    



class Employee_Journey(models.Model):
  emp_jou_id = models.AutoField(primary_key=True)
  sdm  = models.ForeignKey(
        SectionDesignationMapper, on_delete=models.CASCADE)
  usr  = models.ForeignKey(
        UserDetails, on_delete=models.CASCADE)
  doj = models.DateField()
  dot = models.DateField(default="1900-01-01")
  current_status = models.CharField(max_length=10, choices=(
        ('Deputed', 'Deputed'), ('Transfered', 'Transfered'), ('Vacant', 'Vacant')),default='V') 
  verified = models.CharField(max_length=10, choices=(
        ('YES', 'YES'), ('NO', 'NO')),default='NO')
  pawatidoc = models.FileField(upload_to="Pawati/", default='')

# Add location id along with product and user details (ID) 
class TransactionDetails(models.Model):
    trans_id = models.AutoField(primary_key=True)          
    sdm  = models.ForeignKey(SectionDesignationMapper, on_delete=models.CASCADE)
    trans_issue_date = models.DateField()  
    issue_received_status = models.CharField(max_length=3,default='No')

    

class ProductTransactionDetails(models.Model):
    pro_trans_id = models.AutoField(primary_key=True)
    trans  = models.ForeignKey(
        TransactionDetails, on_delete=models.CASCADE)
    productid  = models.ForeignKey(
        ProductDetails, on_delete=models.CASCADE)     
    trans_flag = models.IntegerField(default=0) # 0 - Issued , 1-Return
    no_of_item_issue = models.IntegerField()
    issue_remarks = models.CharField(max_length=250)
    trans_return_date = models.DateField()  
    no_of_item_return = models.IntegerField(default=0)
    return_remarks = models.CharField(max_length=250,default='')
    return_received_status = models.CharField(max_length=3,default='No')    


class HealthStatusDetails(models.Model):    
    health_id = models.AutoField(primary_key=True)
    product  = models.ForeignKey(
        ProductDetails, on_delete=models.CASCADE)  
    product_healthy = models.CharField(max_length=10, choices=(
        ('Yes', 'Yes'), ('No', 'No')),default='Yes')
    health_remarks = models.CharField(max_length=250,default='New Product')
    product_status = models.CharField(max_length=50, choices=(
        ('Working', 'Working'), ('Not Working', 'Not Working')),default='Working')
    status_date = models.DateField(auto_now_add=True)


class UnallocatedUsers(models.Model):
    usr_id = models.AutoField(primary_key=True)    
    usr_name = models.CharField(max_length=250)
    usr_mobile = models.CharField(max_length=250)
    entry_date = models.DateField(auto_now_add=True)    
    usr_type = models.CharField(max_length=10, choices=(
        ('Judge', 'Judge'), ('Staff', 'Staff')))    
    class Meta:
        managed = False
        db_table = 'unallocatedusers'

class SecDesView(models.Model): 
  sdm_id = models.IntegerField()      
  staff_id =  models.IntegerField()
  section_id = models.IntegerField()
  staff_des_name = models.CharField(max_length=250) 
  section_type = models.CharField(max_length=250)
  section_name = models.CharField(max_length=250)
  floor = models.CharField(max_length=250,default='')
  roomno = models.CharField(max_length=250,default='')
  landmark = models.CharField(max_length=250,default='')
  class Meta:
        managed = False
        db_table = 'secdesview'


