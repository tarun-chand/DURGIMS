# from typing_extensions import Self
from django.shortcuts import render,redirect
from django.http import HttpResponse,JsonResponse
from .models import Employee_Journey, ProductCategoryMaster,ProductDetails,UserDetails,ProductDetails,UserDetails,HealthStatusDetails,SectionDetails,TransactionDetails,ProductTransactionDetails,staffDesignationMaster,SectionDesignationMapper,UnallocatedUsers
from django.contrib import messages
from django.core import serializers
import json
from django.db.models import Count,Sum
from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from DURG_IMS.settings import MEDIA_ROOT
# Create your views here.
from django.db import connection
from django.template.defaulttags import register
from django.conf import settings

def index(request):
    
    return render(request,"regi_Login/index.html")

def user_login(request):
    if request.method == 'POST':
        uname = request.POST.get('user_id')
        pwd = request.POST.get('user_pass')
        user  = authenticate(request,username=uname, password=pwd)
        print("USER---------",user)
        if user:
            login(request,user)
            request.session['user'] = uname
            return redirect('theDashboard')
        else:
            return HttpResponse('Please enter valid Username or Password.')
    return render(request,"regi_Login/index.html")

def user_logout(request):
    try:
        del request.session['user']
    except:
        return redirect('user_login')
    return redirect('user_login')

@login_required(login_url="user_login")
def home(request):
    
    list_all_sc = SectionDetails.objects.all()
    return render(request,"home.html",{'list_all_sc':list_all_sc})

@login_required(login_url="user_login")
def theDashboard(request):
    try:
        db_name = settings.DATABASES['default']['NAME']
        if 'durg_ims_pdev' in db_name.lower():
            print("You are using the production database.")
            message = "production"
        elif 'durg_ims_test' in db_name.lower():
            print("You are using the development database.")
            message = "development"
        else:
            print("Database environment is unknown.")
            message = "unknown."
        # cursor = connection.cursor()
        # total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
        # cursor.execute('''select c.product_cat_name category,SUM(CASE WHEN product_healthy='Yes' THEN 1 ELSE 0 END) healthyYes,SUM(CASE WHEN product_healthy='No' THEN 1 ELSE 0 END) healthyNo,SUM(CASE WHEN product_status='Working' THEN 1 ELSE 0 END) product_statusWorking,SUM(CASE WHEN product_status='Not Working' THEN 1 ELSE 0 END) product_statusNotWorking from inventory_healthstatusdetails a,inventory_productdetails b,inventory_productcategorymaster c where a.product_id_id=b.product_id and b.product_cat_id_id=c.product_cat_id group by c.product_cat_name''')
        # columns = list(cursor.description)
        # result = cursor.fetchall()        
        # results = []
        # for row in result:
        #     row_dict = {}
        #     for i, col in enumerate(columns):
        #         row_dict[col.name] = row[i]
        #     results.append(row_dict)
        # print("results-------------",results)
        # return render(request,"dashboard.html",{'total_qun':total_qun,'healthyPro':results})
        list_all_sc = SectionDetails.objects.all()
        list_all_pro = ProductDetails.objects.all()
        list_all_usr = UserDetails.objects.all()
        cursor = connection.cursor()
        cursor.execute("SELECT product_cat_name,product_com_name,product_mod_name,count(product_mod_name) as total,sum(CASE WHEN current_quantity = '1' AND b.product_status='Working' THEN 1 ELSE 0 END) as inhand,sum(CASE WHEN current_quantity = '0' THEN 1 ELSE 0 END) as issued,product_type,product_mod_id,sum(CASE WHEN b.product_status='Dead Stock' THEN 1 ELSE 0 END) as Total_DeadStock,sum(CASE WHEN b.product_status='Needs To Repair' THEN 1 ELSE 0 END) as Total_repair FROM completeproductdetail a,inventory_healthstatusdetails b where a.product_id=b.product_id and product_type='Non-Consumable' GROUP BY product_cat_name,product_com_name,product_mod_name,product_type,product_mod_id ORDER BY product_com_name")   
                   
        result = cursor.fetchall()
        print("result----",result)
        return render(request,"dashboard.html",{'list_all_sc':list_all_sc,'list_all_pro':list_all_pro,'list_all_usr':list_all_usr,'flag':1,'result':result,'db_message': message})
    except Exception as e:
        print("ERROR",e)        
        # cursor = connection.cursor()

@login_required(login_url="user_login")
def dashboardOperational(request):
    source = request.GET.get("source")
    pro_mod_id = request.GET.get("pro_mod_id")
    print("I AM OPERATIONAL",source,pro_mod_id)
    cursor = connection.cursor()
    if source =='inhand':
        cursor.execute("select product_cat_name,product_com_name,product_mod_name,product_serialno  FROM completeproductdetail a,inventory_healthstatusdetails b where a.product_id=b.product_id AND current_quantity = '1' AND b.product_status='Working' AND  product_mod_id="+pro_mod_id)  
    elif source =='issued': 
        cursor.execute("select product_cat_name,product_com_name,product_mod_name,product_serialno,section_name,staff_des_name,usr_name FROM alldetails where  trans_flag=0 and current_status='D' and product_mod_id="+pro_mod_id)   
    elif source =='repair':         
        cursor.execute("SELECT product_cat_name,product_com_name,product_mod_name,product_serialno,b.health_remarks FROM completeproductdetail a,inventory_healthstatusdetails b where a.product_id=b.product_id and a.product_mod_id="+pro_mod_id+" and  b.product_status='Needs To Repair'")             
    else:
        print("I AM ELSE")
        cursor.execute("SELECT product_cat_name,product_com_name,product_mod_name,product_serialno,b.health_remarks FROM completeproductdetail a,inventory_healthstatusdetails b where a.product_id=b.product_id and a.product_mod_id="+pro_mod_id+" and  b.product_status='Dead Stock'")                
    result = cursor.fetchall()        
    return render(request,"dashboard_operational.html",{'source':source,'result':result})



@login_required(login_url="user_login")
def getCourtSectionList(request):
    sectionid=request.GET.get('sectionid')
    list_of_data = SectionDesignationMapper.objects.filter(section=sectionid)
    print("sectionid--",list_of_data)
    return render(request,"ajaxpage/productAJX.html",{'flag':'showCoSeData','list_of_data':list_of_data})



@login_required(login_url="user_login")
def getProductList(request):
    productid=request.GET.get('productid')        
    return render(request,"ajaxpage/productAJX.html",{'flag':'SectionDetailList'})


@login_required(login_url="user_login")
def issueRedirect(request):
    list_of_prod = ProductDetails.objects.all()
    list_of_loc = SectionDetails.objects.all()
    # list_of_cat = ProductDetails.objects.select_related('product_cat_id').distinct('product_cat_id')
    list_of_cat = ProductCategoryMaster.objects.all()
    print("list_of_cat---",list_of_cat.query)
    return render(request,"issue/page-issue.html",{'list_of_prod':list_of_prod,'list_of_cat':list_of_cat,'list_of_loc':list_of_loc})

@login_required(login_url="user_login")
def issueProductCategoryFilter(request):
    list_all_protype = ProductCategoryMaster.objects.filter(product_type=request.GET.get('protype'))
    print("list_all_protype----",list_all_protype)
    return render(request,"ajaxpage/productAJX.html",{'flag':'productCategoryList','list_all_protype':list_all_protype})

@login_required(login_url="user_login")
def issueProductModelFilter(request):
    print('I AM INSIDE ----------------',request.GET.get('productcat'))
    # list_all_mod = ProductDetails.objects.filter(product_mod__product_com__product_cat_id=request.GET.get('productcat'))
    cursor = connection.cursor()    
    cursor.execute("select * FROM completeproductdetail a,inventory_healthstatusdetails b WHERE a.product_id=b.product_id and a.product_cat_id="+request.GET.get('productcat')+" ORDER BY current_quantity DESC")
    list_all_mod = cursor.fetchall()     
    print("list_all_protype----",list_all_mod)
    return render(request,"ajaxpage/productAJX.html",{'flag':'ProductModelList','list_all_mod':list_all_mod})

@login_required(login_url="user_login")
def issueOtherProductDetailsFilter(request):
    prod_det = ProductDetails.objects.filter(product_id=request.GET.get('productdet'))
    list_data =[]
    for prod_det in prod_det:
        data_small={
                    "current_quantity":str(prod_det.current_quantity),                
                    "remarks":str(prod_det.remarks)}
        list_data.append(data_small)
    return JsonResponse(json.dumps(list_data),
                        content_type="application/json", safe=False)
    

@login_required(login_url="user_login")
def issueSectionDetailsFilter(request):
    list_all_sec = SectionDetails.objects.filter(section_type=request.GET.get('issueto'))
    print(list_all_sec.query)
    print("list_all_protype----",list_all_sec)
    return render(request,"ajaxpage/productAJX.html",{'flag':'SectionDetailList','list_all_sec':list_all_sec})



@login_required(login_url="user_login")
def sectionDesigDetailsFilter(request):
    print("request.GET.get('locationdetail')----",request.GET.get('locationdetail'))
    # list_all_desig = SectionDesignationMapper.objects.filter(section=request.GET.get('locationdetail')).exclude(staff__staff_des_name='NOT ASSIGNED')
    # print(list_all_desig.query)
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM userdesignationview WHERE current_status = 'D' and section_id = "+request.GET.get('locationdetail'))
    list_all_desig = cursor.fetchall()    
    print("list_all_protype----",list_all_desig)
    return render(request,"ajaxpage/productAJX.html",{'flag':'SectionDesigList','list_all_desig':list_all_desig})

@login_required(login_url="user_login")
def IssueDetailsSubmit(request):
    issue_date = request.POST.get('dateIssue')
    sdmid = request.POST.get('sdmid')
    print("sdmid",sdmid)
    no_of_item = request.POST.getlist('proQun')
    issue_remark = request.POST.getlist('proRem')    
    productid = request.POST.getlist('proId')    
    received_status = request.POST.get('receiving')    

    trn = TransactionDetails()        
    trn.trans_issue_date = issue_date
    trn.issue_received_status = received_status   
    trn.sdm = SectionDesignationMapper.objects.get(sdm_id=sdmid)
    trn.save()

    trans_id=(TransactionDetails.objects.last()).trans_id             
    for t in range(len(productid)):
        pro_trn = ProductTransactionDetails()
        product_id=ProductDetails.objects.get(product_id=productid[t]) 
        pro_trn.trans = TransactionDetails.objects.get(trans_id=trans_id)   
        pro_trn.productid = product_id
        pro_trn.trans_flag = 0  
        pro_trn.trans_return_date = '1900-01-01'    
        pro_trn.no_of_item_issue = no_of_item[t]
        pro_trn.issue_remarks = issue_remark[t]
        pro_trn.save()

        # Updating the current Quantity and Product Status
        product_id.current_quantity=str(int(product_id.current_quantity) - int(no_of_item[t]))
        product_id.product_new_or_open="OPENED"
        product_id.save()
        
    messages.success(request, 'Issue Details SAVED Successfully...!!')
    print('received_status------',received_status)
    # if received_status == 'Yes':
    #     return redirect('/issueReceiptPage')
    # else :
    return redirect('/issueRedirect')

@login_required(login_url="user_login")
def listAllIssueDetails(request):
    fromDate = request.POST.get('fromDate')
    toDate = request.POST.get('toDate')
    trn_det = TransactionDetails.objects.filter(trans_issue_date__range=(fromDate,toDate))
    print('trn_det--------------------',trn_det)
    return render(request,"issue/page-list-issue.html",{'trn_det':trn_det})

@login_required(login_url="user_login")
def listIssueDetailsByDate(request):
    trn_det=[]
    fromDate = request.POST.get('fromDate')
    toDate = request.POST.get('toDate')
    for t in TransactionDetails.objects.filter(trans_issue_date__range=(fromDate,toDate)):    
        trn_det.append(ProductTransactionDetails.objects.filter(trans_id=t.trans_id,trans_flag=0))
        print("Ttrn_det-------",trn_det)
    return render(request,"issue/page-list-issue.html",{'trn_det':trn_det})

@login_required(login_url="user_login")
def listReturnDetailsByDate(request):
    trn_det=[]
    fromDate = request.POST.get('fromDate')
    toDate = request.POST.get('toDate')
    trn_det.append(ProductTransactionDetails.objects.filter(trans_return_date__range=(fromDate,toDate),trans_flag=1))
    return render(request,"return/page-list-return.html",{'trn_det':trn_det})

@login_required(login_url="user_login")
def issueReceiptPage(request):    
    # t_det=TransactionDetails.objects.get(trans_id= 1)
    t_det=TransactionDetails.objects.get(trans_id= (TransactionDetails.objects.last()).trans_id)
    prod_trn=ProductTransactionDetails.objects.filter(trans_id=t_det.trans_id) 
    return render(request,"issue/issue_receipt.html",{'t_det':t_det,'prod_trn':prod_trn})


@login_required(login_url="user_login")
def issueReceiptPageById(request):    
    # t_det=TransactionDetails.objects.get(trans_id= 1)
    # transid = request.GET.get('tid')
    transid = 64
    t_det=TransactionDetails.objects.get(trans_id= transid)
    prod_trn=ProductTransactionDetails.objects.filter(trans_id=t_det.trans_id) 
    return render(request,"issue/issue_receipt.html",{'t_det':t_det,'prod_trn':prod_trn})    
    
@login_required(login_url="user_login")
def returnRedirect(request):
  list_all_sc = SectionDetails.objects.all()
  return render(request,"return/page-return.html",{'flag':'Redirect','user_name':'','list_all_sc':list_all_sc})

@login_required(login_url="user_login")
def returnGetIssueStuff(request):    
    trn_det_list=[]
    user_name=''    
    aa = TransactionDetails.objects.filter(sdm=request.POST.get('sectionid'))    
    cursor = connection.cursor()
    a = "SELECT a.sdm_id,pro_trans_id,b.trans_id,trans_issue_date,no_of_item_issue,product_type,product_cat_name,product_com_name,product_mod_name,product_serialno,e.staff_des_name,e.section_name,e.floor,e.roomno,e.landmark,f.usr_name,d.product_id FROM inventory_sectiondesignationmapper a,inventory_transactiondetails b,inventory_producttransactiondetails c,completeproductdetail d,sectiondesignationview e,mappeduser f where a.sdm_id = f.sdm_id and a.sdm_id=e.sdm_id and a.sdm_id=b.sdm_id and b.trans_id = c.trans_id and c.productid_id = d.product_id and trans_flag=0 and  a.sdm_id="+str(request.POST.get('desig')+" ORDER BY product_serialno DESC")
    print(a)
    cursor.execute(a)    
    trn_det_list = cursor.fetchall()  
    # for t in TransactionDetails.objects.filter(sdm=request.POST.get('sectionid')):
    #     for p in ProductTransactionDetails.objects.filter(trans_id=t,trans_flag=0):
    #         trn_det_list.append(p)    
    #         print('DATATATATATAT=-------------',p)        
    #     user_name = t.usr_id.usr_name +" ("+t.usr_id.usr_des_id.usr_des_name+")"
    # print("TETETETETETET--------- ",trn_det_list)
    return render(request,"return/page-return.html",{'trn_det_list':trn_det_list,'flag':'DATA'})

@login_required(login_url="user_login")
def returnDetailsSubmit(request):
    trn_no = request.POST.getlist('trn_no')
    pro_trn_no = request.POST.getlist('pro_trn_no')
    Rquantity = request.POST.getlist('Rquantity')
    returnRemark = request.POST.getlist('returnRemark')
    returnDate = request.POST.get('returnDate')
    received_status=request.POST.get('receiving')

    product_id = request.POST.getlist('product_id')
    productstatus = request.POST.getlist('productstatus')
    producthealth = 'NA'
    healthRemark = request.POST.getlist('healthRemark')
    print("trn_no--",trn_no)
    print("pro_trn_no--",pro_trn_no)
    print("Rquantity--",Rquantity)
    print("returnRemark--",returnRemark)
    print("returnDate--",returnDate)
    print("received_status--",received_status)
    print("product_id--",product_id)
    print("productstatus--",productstatus)
    print("producthealth--",producthealth)
    print("healthRemark--",healthRemark)
    t_det = TransactionDetails.objects.get(trans_id=trn_no[0]) # For User Details
    pdet = ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[0]) # For Return Date     
    prodetno = []
    for pt in range(len(request.POST.getlist('trn_no'))):
        prodetno.append(ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[pt]))
       # Updating ProductTransactionDetails Table
        ProductTransactionDetails.objects.filter(pro_trans_id=pro_trn_no[pt]).update(no_of_item_return=Rquantity[pt],return_remarks=returnRemark[pt],trans_return_date=returnDate,return_received_status=received_status,trans_flag=1) 
       # Updating Product health status table
        health,check = HealthStatusDetails.objects.update_or_create(product_id=product_id[pt],defaults={"product_healthy": producthealth, "health_remarks": healthRemark[pt],"product_status":productstatus[pt],"status_date":returnDate})      
       # Updating product details
        a = ProductDetails.objects.get(product_id=product_id[pt]).current_quantity
        print("current_quantity --  ",a)
        
        current_quantity=str(int(a) + int(Rquantity[pt]))
        ProductDetails.objects.filter(product_id=product_id[pt]).update(current_quantity=current_quantity)        
    if received_status == 'Yes':
        return render(request,"return/return_receipt.html",{'t_det':t_det,'pro_trn_no':prodetno,'pdet':pdet})
    else:
        return render(request,"return/page-return.html",{'flag':'Redirect','user_name':''})

@login_required(login_url="user_login")
def listAllReturnDetails(request):
    return render(request,"return/page-list-return.html")




@login_required(login_url="user_login")
def healthDetailsRedirect(request):    
    return render(request,"reports/health.html",{'list_of_hprod':''})

@login_required(login_url="user_login")
def healthDetailsSearch(request):    
    list_of_hprod = HealthStatusDetails.objects.filter(product_status=request.POST.get('productstatus'))
    return render(request,"reports/health.html",{'list_of_hprod':list_of_hprod})


@login_required(login_url="user_login")
def healthDetailsUpdateRedirect(request):    
    list_of_hprod = HealthStatusDetails.objects.filter(health_id=request.GET.get('healthid'))    
    print("list_of_hprod  -- ",list_of_hprod)
    # return render(request,"reports/health.html",{'hprod':healthid,'list_of_hprod':list_of_hprod})
    return render(request,"ajaxpage/healthAJX.html",{'flag':'healthUpdate','list_of_hprod':list_of_hprod})

@login_required(login_url="user_login")
def healthDetailsUpdate(request):
    hdet = HealthStatusDetails.objects.get(health_id = request.POST.get('healthid'))
    hdet.product_status = request.POST.get('productstatus')
    hdet.health_remarks = request.POST.get('healthRemark')
    hdet.save()     
    return redirect('/healthDetailsRedirect') 


# Transfer of Assets


@login_required(login_url="user_login")
def transferRedirect(request):
    return render(request,"transfer/page-transfer.html",{'flag':'Redirect','user_name':''})

@login_required(login_url="user_login")
def transferGetIssueStuff(request):
    trn_det_list=[]
    user_name=''
    for t in TransactionDetails.objects.filter(usr_id=request.POST.get('userdetail')):
        for p in ProductTransactionDetails.objects.filter(trans_id=t,trans_flag=0):
            trn_det_list.append(p)            
        user_name = t.usr_id.usr_name +" ("+t.usr_id.usr_des_id.usr_des_name+")"
    print("TETETETETETET--------- ",trn_det_list)
    list_of_loc = SectionDetails.objects.all()
    return render(request,"transfer/page-transfer.html",{'trn_det_list':trn_det_list,'user_name':user_name,'flag':'DATA','list_of_loc':list_of_loc})


@login_required(login_url="user_login")
def transferDetailsSubmit(request):    
    # FOR RETURN userdetail
    pro_trn_no = request.POST.getlist('pro_trn_no') 
    print("pro_trn_no---------",pro_trn_no)
    returnRemark = request.POST.getlist('returnRemark')
    # FOR ISSUE
    issueRemark = request.POST.getlist('issueRemark')
    product_id = request.POST.getlist('product_id')    
    print("product_id---------------",product_id)
    print("issueRemark---------------",issueRemark)
    no_of_item=request.POST.getlist('Iquantity')
    
    # COMMON VARIABLE
    transferDate = request.POST.get('transferDate')
    received_status=request.POST.get('receiving')
    
    # ASSET RETURNING
    prodetno_return=[]
    trn_no = request.POST.getlist('trn_no')
    t_det_return = TransactionDetails.objects.get(trans_id=trn_no[0]) # For User Details
    pdet_return = ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[0]) # For Return Date

    
    for p in range(len(request.POST.getlist('pro_trn_no'))):
        pt = ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[p])
        pt.return_remarks=returnRemark[p]
        pt.trans_return_date=transferDate
        pt.return_received_status=received_status
        pt.no_of_item_return = no_of_item[p]
        pt.trans_flag=1
        print("ASSET RETURNING-------------------------",pt)
        pt.save()
        prodetno_return.append(pt)
        
        # ProductTransactionDetails.objects.filter(pro_trans_id=pro_trn_no[p]).update(return_remarks=returnRemark[p],trans_return_date=transferDate,return_received_status=received_status,trans_flag=1)             
       
    # ASSET ISSUING    

    trn = TransactionDetails()    
    trn.usr_id = UserDetails.objects.get(usr_id=request.POST.get('transuserdetail'))
    trn.section_id = SectionDetails.objects.get(section_id=request.POST.get('locationdetail'))
    trn.trans_issue_date = transferDate
    trn.issue_received_status = received_status   
    trn.save()

    trans_id=(TransactionDetails.objects.last()).trans_id 
    print("len(pro_trn_no) ---- ",len(pro_trn_no))
    for t in range(len(pro_trn_no)):
        pro_trn = ProductTransactionDetails()
        pro_trn.trans_id = TransactionDetails.objects.get(trans_id=trans_id)   
        pro_trn.product_id = ProductDetails.objects.get(product_id=product_id[t])        
        pro_trn.issue_remarks = issueRemark[t]
        pro_trn.no_of_item_issue = no_of_item[t]
        print("no_of_item NUMBER OF -----------------",no_of_item[t])
        pro_trn.trans_flag = 0              
        pro_trn.save()

    t_det_issue=TransactionDetails.objects.get(trans_id= (TransactionDetails.objects.last()).trans_id)
    prod_trn_issue=ProductTransactionDetails.objects.filter(trans_id=t_det_issue.trans_id) 
    return render(request,"transfer/transfer_receipt.html",{'t_det_issue':t_det_issue,'prod_trn_issue':prod_trn_issue,'prodetno_return':prodetno_return,'pdet_return':pdet_return,'t_det_return':t_det_return})

    

    

# Replacement of Assets
@login_required(login_url="user_login")
def replaceRedirect(request):
    # usr_list = UserDetails.objects.all()    
    cursor = connection.cursor()
    a = "SELECT a.usr_name,a.staff_des_name,b.section_name,a.sdm_id FROM userdesignationview a,inventory_sectiondetails b where a.section_id = b.section_id"  
    cursor.execute(a)    
    usr_list = cursor.fetchall()
    return render(request,"transfer/page-replace.html",{'usr_list':usr_list})

@login_required(login_url="user_login")
def getAllIssuedStuffOfUser(request):                  
    cursor = connection.cursor()
    a = "SELECT b.product_cat_name,b.product_com_name,b.product_mod_name,b.product_serialno,b.product_cat_id,a.no_of_item_issue,a.trans_id,a.pro_trans_id FROM transactiondesignationview a,completeproductdetail b where a.productid_id = b.product_id and a.trans_flag=0 and a.sdm_id = "+ request.GET.get('userdetail') 
    cursor.execute(a)    
    trn_det_list = cursor.fetchall()
    # trn_det_list=[]
    # print("request.POST.get('userdetail')",request.GET.get('userdetail'))
    # for t in TransactionDetails.objects.filter(usr_id=request.GET.get('userdetail')):
    #     for p in ProductTransactionDetails.objects.filter(trans_id=t,trans_flag=0):
    #         print("TETETETETETETET --- ",p)
    #         trn_det_list.append(p)        
    return render(request,"ajaxpage/productAJX.html",{'flag':'UserIssuedAssestList','trn_det_list':trn_det_list})

@login_required(login_url="user_login")
def getAllReplaceListStuff(request):  
    # data = request.GET.get('issuedproduct').split(',')   
    data = request.GET.get('issuedproduct')
    # print("RRARARARRARAR - -- ",data[0])
    # print("RRARARARRARAR - -- ",data[1])
    # rep_ass_List = ProductDetails.objects.filter(product_cat_id_id=data[1])
    # print("RRARARARRARAR - -- ",rep_ass_List.count())
    cursor = connection.cursor()
    a = "SELECT b.product_cat_name,b.product_com_name,b.product_mod_name,b.product_serialno,b.product_cat_id,b.current_quantity,b.product_id,b.product_type FROM completeproductdetail b,inventory_healthstatusdetails a where a.product_id = b.product_id and a.product_status='Working' and product_cat_id ="+ data[0] +" order by current_quantity DESC"
    cursor.execute(a)    
    rep_ass_List = cursor.fetchall()
    return render(request,"ajaxpage/productAJX.html",{'flag':'ReplaceAssestList','rep_ass_List':rep_ass_List})


@login_required(login_url="user_login")
def replaceDetailsSubmit(request):  

    # COMMON VARIABLE
    transferDate = request.POST.get('transferDate')       
    
    print("transferDate - ",transferDate)
    newproducttoissue=request.POST.get('newproducttoissue').split(',')  
    print("newproducttoissue--",newproducttoissue)  
    sdmid = request.POST.get('userdetail')        
    print("sdmid--",sdmid)  
    productstatus = request.POST.get('productstatus')
    healthRemark = request.POST.get('healthRemark')
    
    # FOR ISSUE
    trn = TransactionDetails()        
    trn.trans_issue_date = transferDate
    trn.issue_received_status = 'No'   
    trn.sdm = SectionDesignationMapper.objects.get(sdm_id = sdmid)    
    trn.save()

    last_trn_id = (TransactionDetails.objects.last()).trans_id

    pro_trn = ProductTransactionDetails()
    product_id=ProductDetails.objects.get(product_id=newproducttoissue[1]) 
    print("product_id---",product_id)
    pro_trn.trans = TransactionDetails.objects.get(trans_id=last_trn_id)   
    print("Pro Trans---",TransactionDetails.objects.get(trans_id=last_trn_id)   )
    pro_trn.productid = product_id
    pro_trn.trans_flag = 0 #Issued      
    pro_trn.no_of_item_issue = "1"
    pro_trn.issue_remarks = "Issued for Replacement"
    pro_trn.trans_return_date=transferDate
    pro_trn.save()

    # Updating the current Quantity and Product Status
    product_id.current_quantity=str(int(product_id.current_quantity) - int("1"))
    product_id.product_new_or_open="OPENED"
    product_id.save()


    # FOR RETURN
    # VARIABLES FOR  RETURNING
    issuedproduct=request.POST.get('issuedproduct').split(',')
    pt = ProductTransactionDetails.objects.get(pro_trans_id=issuedproduct[1])      
    if pt.no_of_item_issue >=2:       
        tf = pt.trans_flag        
        issueno = pt.no_of_item_issue - 1
        returnno = pt.no_of_item_return + 1 
    else :
        tf=1
        issueno = 0
        returnno = pt.no_of_item_return + 1
    
    ProductTransactionDetails.objects.filter(pro_trans_id=issuedproduct[1]).update(no_of_item_issue = issueno,no_of_item_return=returnno,return_remarks=healthRemark,trans_return_date=transferDate,trans_flag=tf) 

    rproductid = pt.productid    
    if newproducttoissue[2] == 'Non-Consumable':    
        # Updating Product health status table    
        health,check = HealthStatusDetails.objects.update_or_create(product_id=rproductid.product_id ,defaults={"health_remarks": request.POST.get('healthRemark'),"product_status":productstatus})      
        # Updating product details
    if productstatus == 'Working':
        current_quantity=str(int(rproductid.current_quantity) + int("1"))
        ProductDetails.objects.filter(product_id=rproductid.product_id).update(current_quantity=current_quantity)        

    print("LAST TRAN ID ---------- ",last_trn_id)
    messages.success(request, 'Replacement SAVED Successfully...!!')
    return render(request,"transfer/page-replace.html",{'flag':'Redirect','user_name':''})


@login_required(login_url="user_login")
def IntSectionDesigMapRedirect(request):         
  return render(request,"master/mapper/intSecDesigmapper.html")

@login_required(login_url="user_login")
def getSectionNameFilter(request):  
  list_of_loc = SectionDetails.objects.filter(sectionType=request.GET.get('sectionType'))  
  return render(request,"ajaxpage/productAJX.html",{'flag':'SectionNameList','list_of_loc':list_of_loc})

@login_required(login_url="user_login")
def sectionDesigMapRedirect(request):     
    list_all_sc = SectionDetails.objects.all()    
    list_all_sdm = staffDesignationMaster.objects.all()
    return render(request,"master/mapper/secDesigmapper.html",{'list_all_sc':list_all_sc,'list_all_sdm':list_all_sdm})


@login_required(login_url="user_login")
def shiftAssetChargeRedirect(request):     
    list_all_sc = SectionDetails.objects.all()    
    list_all_sdm = staffDesignationMaster.objects.all()
    return render(request,"master/mapper/shiftassetcharge.html",{'list_all_sc':list_all_sc,'list_all_sdm':list_all_sdm})

@login_required(login_url="user_login")
def shiftAssetChargeSubmit(request): 
  section_id=request.POST.get('sectionid')
  sacfrom=request.POST.get('sacfrom')
  sacto=request.POST.get('sacto')
  print("section_id-",section_id," sacfrom-",sacfrom," sacto-",sacto)

  # COMMON VARIABLE
  issueRemark = "Due To Staff Charge Changes"
  returnRemark = "Due To Staff Charge Changes"
  transferDate = request.POST.get('transferDate')
  received_status=request.POST.get('receiving')
    
    # ASSET RETURNING
  prodetno_return=[]
  trn_no = request.POST.getlist('trn_no')
  t_det_return = TransactionDetails.objects.get(trans_id=trn_no[0]) # For User Details
  pdet_return = ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[0]) # For Return Date

    
  for p in range(len(request.POST.getlist('pro_trn_no'))):
    pt = ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[p])
    pt.return_remarks=returnRemark[p]
    pt.trans_return_date=transferDate
    pt.return_received_status=received_status
    pt.no_of_item_return = no_of_item[p]
    pt.trans_flag=1
    print("ASSET RETURNING-------------------------",pt)
    # pt.save()
    prodetno_return.append(pt)
        
        # ProductTransactionDetails.objects.filter(pro_trans_id=pro_trn_no[p]).update(return_remarks=returnRemark[p],trans_return_date=transferDate,return_received_status=received_status,trans_flag=1)             
       
    # ASSET ISSUING    

  trn = TransactionDetails()    
  trn.usr_id = UserDetails.objects.get(usr_id=request.POST.get('transuserdetail'))
  trn.section_id = SectionDetails.objects.get(section_id=request.POST.get('locationdetail'))
  trn.trans_issue_date = transferDate
  trn.issue_received_status = received_status   
#   trn.save()

  trans_id=(TransactionDetails.objects.last()).trans_id 
  print("len(pro_trn_no) ---- ",len(pro_trn_no))
  for t in range(len(pro_trn_no)):
    pro_trn = ProductTransactionDetails()
    pro_trn.trans_id = TransactionDetails.objects.get(trans_id=trans_id)   
    pro_trn.product_id = ProductDetails.objects.get(product_id=product_id[t])        
    pro_trn.issue_remarks = issueRemark[t]
    pro_trn.no_of_item_issue = no_of_item[t]
    print("no_of_item NUMBER OF -----------------",no_of_item[t])
    pro_trn.trans_flag = 0              
    # pro_trn.save()

    t_det_issue=TransactionDetails.objects.get(trans_id= (TransactionDetails.objects.last()).trans_id)
    prod_trn_issue=ProductTransactionDetails.objects.filter(trans_id=t_det_issue.trans_id)   
  return redirect('/shiftAssetChargeRedirect')  


@login_required(login_url="user_login")
def getAllDesignationOfSection(request):     
    print("I AM CALLED")
    secdes = request.GET.get('sectionid') 
    sctype= SectionDetails.objects.filter(section_id=secdes).values('section_type') 
    print("sctype---------",sctype)   
    for i in sctype:        
        sctype = i['section_type']                    
    list_of_des = staffDesignationMaster.objects.filter(staff_type=sctype) 
    print("list_of_des----------",list_of_des)
    # sec_data = serializers.serialize('json',SectionDesignationMapper.objects.filter(section_id=secdes).exclude(staff__staff_des_name='NOT ASSIGNED'))
    # des_data = serializers.serialize('json',staffDesignationMaster.objects.filter(staff_type=sctype))
    # json_data = json.dumps({'sec_data':sec_data, 'des_data':des_data})
    # return HttpResponse(json_data,content_type="application/json")
  
    return render(request,"ajaxpage/mapperAJX.html",{'flag':'sdm','list_of_des':list_of_des})

@login_required(login_url="user_login")
def showAllDesignation(request):
    secdes = request.GET.get('sectionid')      
    source = request.GET.get('source')      
    print("source---",source)    
    cursor = connection.cursor()
    a = "SELECT sdm_id,staff_des_name,ip_address,usr_name,section_name,staff_id,current_status from userdesignationview WHERE section_id ="+secdes
    cursor.execute(a)    
    list_of_secdesuser = cursor.fetchall() 
    list_of_desig = staffDesignationMaster.objects.all()                           
    list_of_sec = SectionDesignationMapper.objects.filter(section_id=secdes).exclude(staff__staff_des_name='NOT ASSIGNED')   
    print('list_of_sec--',list_of_sec)
    if source =='SDM':
      flag='showdesig'
    elif source == 'SAC':
      flag='sac'
    elif source == 'IP_ADD':
      flag='ipadd'
    return render(request,"ajaxpage/mapperAJX.html",{'flag':flag,'list_of_sec':list_of_sec,'list_of_desig':list_of_desig,'list_of_secdesuser':list_of_secdesuser})
        


@login_required(login_url="user_login")
def SDMSubmit(request):         
    sdm = SectionDesignationMapper()        
    sdm.section = SectionDetails.objects.get(section_id=request.POST.get('sectionid'))
    sdm.staff =  staffDesignationMaster.objects.get(staff_id = request.POST.get('desig'))  
    sdm.ip_address =  request.POST.get('ipaddress')
    sdm.save()
    print("NO PROBLEM")
    return redirect('/sectionDesigMapRedirect')

@login_required(login_url="user_login")
def DesigEmpMapRedirect(request):  
    list_of_sd = SectionDetails.objects.all()
    list_of_staff = UserDetails.objects.all()    
    return render(request,"master/mapper/desigEmpMapper.html",{'list_of_sd':list_of_sd,'list_of_staff':list_of_staff})

@login_required(login_url="user_login")
def editIPRedirect(request):
    list_all_sc = SectionDetails.objects.all()        
    return render(request,"master/mapper/editIPAddress.html",{'list_all_sc':list_all_sc})
  
@login_required(login_url="user_login")
def ipAddrSubmit(request):    
    sdmid =  request.POST.getlist('sdmid')
    desid =  request.POST.getlist('desid')   
    ipaddress = request.POST.getlist('ipaddress')
    list_all_sc = SectionDetails.objects.all()        
    print("sdmid--",sdmid," ipaddress-- ",ipaddress)
    for p in range(len(sdmid)):      
      sdm = SectionDesignationMapper.objects.get(sdm_id=sdmid[p])
      sdm.staff = staffDesignationMaster.objects.get(staff_id = desid[p])
      sdm.ip_address =  ipaddress[p]      
      sdm.save()
    return render(request,"master/mapper/editIPAddress.html",{'list_all_sc':list_all_sc})  


# @login_required(login_url="user_login")
# def getAllDesignationOfSection(request):     
#     print(request.GET.get('secdes'))
#     list_of_emp = Employee_Journey.objects.filter(sdm__section=request.GET.get('secdes'))
#     return render(request,"ajaxpage/mapperAJX.html",{'flag':'allMapDesignation','list_of_emp':list_of_emp})

@login_required(login_url="user_login")
def getDesignationOfSection(request):     
    secid = request.GET.get('secdes')     
    cursor = connection.cursor()
    a = "SELECT a.*,b.*,c.section_name,d.staff_des_name FROM public.inventory_sectiondesignationmapper a LEFT JOIN mappeduser b ON a.sdm_id = b.sdm_id LEFT JOIN inventory_sectiondetails c ON a.section_id = c.section_id LEFT JOIN  inventory_staffdesignationmaster d ON a.staff_id = d.staff_id where a.section_id="+secid+" and a.staff_id <>37"
    cursor.execute(a)
    columns = list(cursor.description)
    list_of_sd = cursor.fetchall() 
    print(list_of_sd)         
    list_of_staff = UnallocatedUsers.objects.all()     
    return render(request,"ajaxpage/mapperAJX.html",{'flag':'allMapDesignation','list_of_sd':list_of_sd,'list_of_staff':list_of_staff})

@login_required(login_url="user_login")
def DEMSubmit(request):
    print("DEM SUBMIT")
    action =  request.POST.getlist('action')
    sdmid =  request.POST.getlist('sdmid')
    userid =  request.POST.getlist('userid')
    empid =  request.POST.getlist('empid')    
    print("userid-----",userid)
    doj =  request.POST.getlist('doj')
    for sd in range(len(action)):
      print("action----------------------",action[sd])
      if action[sd] == 'CREATE':
        print("IF -- ",sdmid[sd],userid[sd],doj[sd])
        emp = Employee_Journey()
        emp.sdm = SectionDesignationMapper.objects.get(sdm_id=sdmid[sd])
        emp.usr = UserDetails.objects.get(usr_id=userid[sd])
        emp.doj = doj[sd]
        emp.current_status = 'D'
        emp.save() 
      elif action[sd] == 'UPDATE': 
        print("ELSE -- ",sdmid[sd],userid[sd],doj[sd])        
        empu = Employee_Journey.objects.get(emp_jou_id = empid[sd])
        empu.usr = UserDetails.objects.get(usr_id=userid[sd])        
        empu.doj = doj[sd]
        empu.save() 

      print("NO PROBLEM")
    return redirect('/DesigEmpMapRedirect')

@login_required(login_url="user_login")
def IntSectionDesigMapRedirect(request): 
  list_of_loc = SectionDetails.objects.all()       
  return render(request,"master/mapper/intSecDesigmapper.html",{'list_of_loc':list_of_loc})

@login_required(login_url="user_login")
def IntSectionDesigMapSubmit(request):
  secid=request.POST.get('sectionname')
  sectionType =  request.POST.get('sectionType') 
  cursor = connection.cursor()
  a = "SELECT * FROM inventory_transactiondetails a,inventory_producttransactiondetails b,inventory_sectiondesignationmapper c,completeproductdetail d,inventory_sectiondetails e where c.section_id = e.section_id and  a.trans_id = b.trans_id and a.sdm_id = c.sdm_id and b.productid_id = d.product_id and b.trans_flag=0 and c.section_id ="+secid
  cursor.execute(a)
  columns = list(cursor.description)
  protran = cursor.fetchall()   
  # sdm_id = ProductTransactionDetails.objects.filter(trans_flag=0).select_related('trans')
  # sdm_id = SectionDesignationMapper.objects.filter(section_id=request.POST.get('sectionname'))         
  # a = ''
  # for s in sdm_id:
  #   a = s.sdm_id
  #   print(a)
  # protran=ProductTransactionDetails.objects.filter(trans__sdm=a).order_by('productid__product_mod__product_com__product_cat__product_cat_name')   
  print("protran---",protran)
  list_of_des = staffDesignationMaster.objects.filter(staff_type = sectionType)
  print("SDM_ID - ",a," PROTRAN - ",protran)
  return render(request,"master/mapper/intSecDesigmapper.html",{'protran':protran,'list_of_des':list_of_des})

@login_required(login_url="user_login")
def assignSectionDesigMap(request):          
  pro_trn_no = request.POST.getlist('transid')
  sdmid = request.POST.getlist('sdmid')
  staffdesid = request.POST.getlist('staffdesid')

  for i in range(len(pro_trn_no)):
    print("ff ProTrans - ",pro_trn_no[i],"ff section - ",sdmid[i]," ff section - ",staffdesid[i])
    sdm = SectionDesignationMapper()
    sdm.section = SectionDetails.objects.get(section_id=sdmid[i]) 
    sdm.staff = staffDesignationMaster.objects.get(staff_id=staffdesid[i])
    sdm.save()
    print("NEW SECTION STORE")
    last_sdm_id=(SectionDesignationMapper.objects.last()).sdm_id
    ProductTransactionDetails.objects.filter(pro_trans_id=pro_trn_no[i]).update(sdm_id=last_sdm_id)    
    print("PRODUCT TRANSACTION STORE")
    SectionDesignationMapper.objects.filter(sdm_id =sdmid[i],staff=37).delete()    
    print("-----DATA DELETE SUCCESS----")

  return render(request,"master/mapper/intSecDesigmapper.html")


@login_required(login_url="user_login")
def ReDesigEmpMapRedirect(request):  
    list_of_sd = SectionDetails.objects.all()
    # list_of_staff = UserDetails.objects.all()  
    cursor = connection.cursor()
    a = "SELECT * FROM unallocatedusers"
    cursor.execute(a)    
    list_of_staff = cursor.fetchall()    
    return render(request,"master/mapper/redesigEmpMapper.html",{'list_of_sd':list_of_sd,'list_of_staff':list_of_staff})

@login_required(login_url="user_login")
def getAllDesignationRemap(request):  
    secdes = request.GET.get('secdes')       
    cursor = connection.cursor()
    a = "SELECT * FROM userdesignationview where current_status='D' and section_id ="+secdes
    cursor.execute(a)    
    list_of_des = cursor.fetchall()  
    print("list_of_des --",list_of_des) 
    # sctype= SectionDetails.objects.filter(section_id=secdes).values('section_type')    
    # for i in sctype:        
    #     sctype = i['section_type']                
    # list_of_des = staffDesignationMaster.objects.filter(staff_type=sctype)      
    return render(request,"ajaxpage/mapperAJX.html",{'flag':'RemapDes','list_of_des':list_of_des})


@login_required(login_url="user_login")
def getCourtWiseUSer(request): 
    secdes = request.GET.get('secdes')   
    courtiden = request.GET.get('courtiden')
    print("secdes-----",secdes,"courtiden-----",courtiden) 
    cursor = connection.cursor()
    if courtiden == 'diffcourt':
        a = "SELECT * FROM unallocatedusers"
        cursor.execute(a)    
        list_of_staff = cursor.fetchall()
    elif courtiden == 'samecourt':     
        a = "SELECT usr_id,usr_name,usr_mobile,entry_date,current_status FROM userdesignationview WHERE current_status ='D' and section_id ="+secdes
        cursor.execute(a)    
        list_of_staff = cursor.fetchall()
    print("DATA GET -----------",list_of_staff)
    return render(request,"ajaxpage/mapperAJX.html",{'flag':'courtiden','list_of_staff':list_of_staff})


@login_required(login_url="user_login")
def getSelectedSectionDesignationRemap(request): 
    sdmid = SectionDesignationMapper.objects.filter(section_id = request.GET.get('secdes'),staff_id = request.GET.get('desig'))     
    print("sdmid-----",sdmid)        
    if sdmid.count() !=0:
        for i in sdmid:    
            sdmid = i.sdm_id                      
        list_of_ed = Employee_Journey.objects.filter(sdm_id =sdmid,current_status='D')                            
        list_of_staff = UserDetails.objects.all()  
    else:
        list_of_ed = sdmid
        list_of_staff=''
    return render(request,"ajaxpage/mapperAJX.html",{'flag':'RemapSelDes','list_of_ed':list_of_ed,'list_of_staff':list_of_staff})

@login_required(login_url="user_login")
def ReDEMSubmit(request):
    print("ReDEMSubmit SUBMIT")
    seuid =  request.POST.get('seuid').split(',')
    sdmid = seuid[0]
    empid = seuid[1]
    cusrid = seuid[2]
    newuserid = request.POST.get('userid')
    doj =  request.POST.get('doj')
    print("seuid ----- ",seuid)
    print("newuserid ----- ",newuserid)
    
    # empid =  request.POST.get('empid')
    # sdmid =  request.POST.get('sdmid')
    # # desig =  request.POST.get('desig')
    
    # Updating The user data who has transfered. 
    empu = Employee_Journey.objects.get(emp_jou_id=empid)
    print("Employee_Journey.objects.get(emp_jou_id=empid)--",Employee_Journey.objects.get(emp_jou_id=empid))
    empu.dot = doj
    empu.current_status='T'    
    empu.save()  

    # Inserting the new user data.
    emp = Employee_Journey()
    emp.doj = doj
    emp.dot = '1900-01-01'
    emp.current_status = 'D'
    emp.sdm = SectionDesignationMapper.objects.get(sdm_id=sdmid)    
    emp.usr = UserDetails.objects.get(usr_id=newuserid)    
    emp.save()           
     
    print("NO PROBLEM")
    return redirect('/ReDesigEmpMapRedirect')


@login_required(login_url="user_login")
def uploadPawatiRedirect(request):   
    cursor = connection.cursor()
    a = "SELECT usr_id,usr_name,staff_des_name FROM userdesignationview WHERE current_status = 'D'"  
    cursor.execute(a) 
    usr_list = cursor.fetchall()    
    return render(request,"master/users/uploadpawati.html",{'usr_list':usr_list})





@login_required(login_url="user_login")
def getAllUserDesList(request):    
    usrid = request.GET.get('uname') 
    print("Hii i am Here--",usrid)
    cursor = connection.cursor()
    a = "SELECT product_cat_name,product_com_name,product_mod_name,product_serialno,no_of_item_issue,trans_issue_date,issue_remarks,section_name,staff_des_name,usr_name,ip_address,doj,emp_jou_id FROM alldetails WHERE current_status='D' and usr_id="+ usrid
    cursor.execute(a)         
    usr_list = cursor.fetchall()
    csname=usr_list[0][7]
    des_name=usr_list[0][8]
    usrname=usr_list[0][9]
    ipaddr=usr_list[0][10]
    doj=usr_list[0][11]
    empid=usr_list[0][12]        
    return render(request,"ajaxpage/pawatiAJX.html",{'flag':'pawatidetails','usr_list':usr_list,'csname':csname,'des_name':des_name,'usrname':usrname,'ipaddr':ipaddr,'doj':doj,'empid':empid})

@login_required(login_url="user_login")
def uploadPawatiSubmit(request): 
    pawati=request.FILES['uploadpawati']  
    pdffilename = request.POST.get('pdffilename')+'.pdf'
    print('pdffilename',pdffilename)
    final = MEDIA_ROOT+"/Pawati/"+pdffilename
    with open(final, "wb+") as destination:
        for chunk in pawati.chunks():
            destination.write(chunk)  
            
    emp = Employee_Journey.objects.get(emp_jou_id=request.POST.get('emp_id'))            
    emp.pawatidoc = pdffilename
    emp.verified = 'YES'
    emp.save()
    messages.success(request, 'Pawati Uploaded Successfully...!!')
    # return render(request,"master/users/uploadpawati.html")
    return redirect('/uploadPawatiRedirect')


    # pro_trn_no = request.POST.getlist('pro_trn_no')
    # returnRemark = request.POST.getlist('returnRemark')
    # product_id = request.POST.getlist('product_id')
    # transferDate = request.POST.get('transferDate')    
    # received_status=request.POST.get('receiving')
    # t_det = TransactionDetails.objects.get(trans_id=trn_no[0]) # For User Details
    # pdet = ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[0]) # For Return Date    
    # prodetno = []
    
    # for pt in range(len(request.POST.getlist('trn_no'))):
    #     prodetno.append(ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[pt]))
    #    # Updating ProductTransactionDetails Table
    #     ProductTransactionDetails.objects.filter(pro_trans_id=pro_trn_no[pt]).update(no_of_item_return=1,return_remarks=returnRemark[pt],trans_return_date=transferDate,return_received_status=received_status,trans_flag=1) 
    #    # Updating Product health status table
    #     health,check = HealthStatusDetails.objects.update_or_create(product_id=ProductDetails.objects.get(product_id=product_id[pt]),defaults={"product_healthy": "Yes", "health_remarks": "Working and Transfer","product_status":"Working"})      
    # return render(request,"transfer/page-transfer.html")