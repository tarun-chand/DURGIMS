from django.db import models

class PurchaseDetails(models.Model):
    purchase_id = models.AutoField(primary_key=True)        
    purchase_date = models.DateField(auto_now_add=True)
    billmemono = models.CharField(max_length=50)
    purchased_by = models.CharField(max_length=50, choices=(
        ('High Court Bilashpur', 'High Court Bilashpur'), ('District Court Durg', 'District Court Durg')))
    purchased_for = models.CharField(max_length=50, choices=(
        ('District Court Durg', 'DCD'), ('District Court Durg-POCSO', 'DCD_POCSO'), ('District Court Durg-SPECIAL', 'DCD_SP')))
    purchase_remarks = models.CharField(max_length=350)    
    billmemodoc = models.CharField(max_length=350)

class ProductPuchaseDetails(models.Model):
    propurid = models.AutoField(primary_key=True) 
    purchase_id = models.ForeignKey(
        PurchaseDetails, on_delete=models.CASCADE)    
    propur_remarks = models.CharField(max_length=350)
    box_detail = models.CharField(max_length=350)

class ProductCategoryMaster(models.Model):
    product_cat_id = models.AutoField(primary_key=True)
    product_type = models.CharField("Product Type",max_length=20, choices=(
        ('Consumable', 'Consumable'), ('Non-Consumable', 'Non-Consumable')))
    product_cat_name = models.CharField("Product Category Name :",max_length=250)

    def __str__(self):
        return self.product_cat_name

class ProductCompanyMaster(models.Model):
    product_com_id = models.AutoField(primary_key=True)
    product_cat_id = models.ForeignKey(
        ProductCategoryMaster, on_delete=models.CASCADE)
    product_com_name = models.CharField("Product Company Name :",max_length=250)

    def __str__(self):
        return self.product_com_name

class ProductModelMaster(models.Model):
    product_mod_id = models.AutoField(primary_key=True)
    product_com_id = models.ForeignKey(
        ProductCompanyMaster, on_delete=models.CASCADE)
    product_mod_name = models.CharField("Product Model Name :",max_length=250)
    def __str__(self):
        return self.product_mod_name

class ProductDetails(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_serialno = models.CharField(max_length=250,default='None', editable=False)
    entry_date = models.DateField(auto_now_add=True)
    initial_quantity = models.IntegerField(editable = False,default=1)
    current_quantity = models.IntegerField()
    cartridge_toner = models.CharField(max_length=250)
    remarks = models.CharField(max_length=300)
    product_new_or_open = models.CharField(max_length=7,default='NEW')       
    product_model = models.ForeignKey(
        ProductModelMaster, on_delete=models.CASCADE)
    propurid = models.ForeignKey(
        ProductPuchaseDetails, on_delete=models.CASCADE,default=1) 

class CourtEstablishmentMaster(models.Model):
    est_id = models.AutoField(primary_key=True)
    est_name = models.CharField(max_length=250)

class BuildingMaster(models.Model):
    building_id = models.AutoField(primary_key=True)
    est_id = models.ForeignKey(CourtEstablishmentMaster, on_delete=models.CASCADE)
    building_name = models.CharField(max_length=250)
    
    def __str__(self):
        return self.building_name


class SectionDetails(models.Model):
    section_id = models.AutoField(primary_key=True)    
    section_type = models.CharField(max_length=10, choices=(
        ('Court', 'Court'), ('Section', 'Section')))
    section_name = models.CharField(max_length=250)
    floor = models.CharField(max_length=250,default='')
    roomno = models.CharField(max_length=250,default='')
    landmark = models.CharField(max_length=250,default='')
    deleted = models.BooleanField(default=False)
    building_name = models.ForeignKey(BuildingMaster, on_delete=models.CASCADE)
  
    
class UserDetails(models.Model):
    usr_id = models.AutoField(primary_key=True)    
    usr_name = models.CharField(max_length=250)
    usr_mobile = models.CharField(max_length=250)
    entry_date = models.DateField(auto_now_add=True)    
    usr_type = models.CharField(max_length=10, choices=(
        ('Judge', 'Judge'), ('Staff', 'Staff')))
    deleted = models.BooleanField(default=False)

class staffDesignationMaster(models.Model):
    sd_id = models.AutoField(primary_key=True)
    staff_des_name = models.CharField(max_length=250)
    staff_type = models.CharField(max_length=10, choices=(
        ('Court', 'Court'), ('Section', 'Section')))


class SectionDesignationMapper(models.Model):
    sdm_id = models.AutoField(primary_key=True)      
    sd_id =  models.ForeignKey(staffDesignationMaster, on_delete=models.CASCADE)
    section_id = models.ForeignKey(SectionDetails, on_delete=models.CASCADE)     
    
# Add location id along with product and user details (ID) 
class TransactionDetails(models.Model):
    trans_id = models.AutoField(primary_key=True)      
    usr_id =  models.ForeignKey(UserDetails, on_delete=models.CASCADE)
    section_id = models.ForeignKey(SectionDetails, on_delete=models.CASCADE)
    trans_issue_date = models.DateField()  
    issue_received_status = models.CharField(max_length=3,default='No')

    

class ProductTransactionDetails(models.Model):
    pro_trans_id = models.AutoField(primary_key=True)
    sdm_id  = models.ForeignKey(
        SectionDesignationMapper, on_delete=models.CASCADE)
    product_id  = models.ForeignKey(
        ProductDetails, on_delete=models.CASCADE)     
    issue_date = models.DateField()
    return_date = models.DateField()
    trans_flag = models.IntegerField(default=0) # 0 - Issued , 1-Return
    no_of_item_issue = models.IntegerField()
    issue_remarks = models.CharField(max_length=250)      
    no_of_item_return = models.IntegerField(default=0)
    return_remarks = models.CharField(max_length=250,default='')
    return_received_status = models.CharField(max_length=3,default='No')
    


class HealthStatusDetails(models.Model):
    health_id = models.AutoField(primary_key=True)
    product_id  = models.ForeignKey(
        ProductDetails, on_delete=models.CASCADE)  
    product_healthy = models.CharField(max_length=10, choices=(
        ('Yes', 'Yes'), ('No', 'No')),default='Yes')
    health_remarks = models.CharField(max_length=250,default='New Product')
    product_status = models.CharField(max_length=50, choices=(
        ('Working', 'Working'), ('Not Working', 'Not Working')),default='Working')
    status_date = models.DateField(auto_now_add=True)


