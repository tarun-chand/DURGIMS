from django.shortcuts import render,redirect
from django.http import HttpResponse,JsonResponse
from .models import ProductCategoryMaster,ProductDetails,UserDetails,ProductDetails,UserDetails,TransactionDetails,HealthStatusDetails,SectionDetails,ProductTransactionDetails
from django.contrib import messages
from django.core.serializers import serialize
import json
from django.db.models import Count,Sum
from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
# Create your views here.
from django.db import connection
from django.template.defaulttags import register

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
    return render(request,"home.html")

@login_required(login_url="user_login")
def theDashboard(request):
    try:
        cursor = connection.cursor()
        total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
        cursor.execute('''select c.product_cat_name category,SUM(CASE WHEN product_healthy='Yes' THEN 1 ELSE 0 END) healthyYes,SUM(CASE WHEN product_healthy='No' THEN 1 ELSE 0 END) healthyNo,SUM(CASE WHEN product_status='Working' THEN 1 ELSE 0 END) product_statusWorking,SUM(CASE WHEN product_status='Not Working' THEN 1 ELSE 0 END) product_statusNotWorking from inventory_healthstatusdetails a,inventory_productdetails b,inventory_productcategorymaster c where a.product_id_id=b.product_id and b.product_cat_id_id=c.product_cat_id group by c.product_cat_name''')
        columns = list(cursor.description)
        result = cursor.fetchall()        
        results = []
        for row in result:
            row_dict = {}
            for i, col in enumerate(columns):
                row_dict[col.name] = row[i]
            results.append(row_dict)
        print("results-------------",results)
        return render(request,"dashboard.html",{'total_qun':total_qun,'healthyPro':results})
    except Exception as e:
        print("ERROR",e)        
        cursor = connection.cursor()
        

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
    list_all_mod = ProductDetails.objects.filter(product_cat_id=request.GET.get('productcat'))
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
def issueUserDetailsFilter(request):
    list_all_usr = UserDetails.objects.select_related('usr_des_id').filter(usr_des_id_id__usr_des_type=request.GET.get('issueto'))
    print(list_all_usr.query)
    print("list_all_protype----",list_all_usr)
    return render(request,"ajaxpage/productAJX.html",{'flag':'UserDetailList','list_all_usr':list_all_usr})

@login_required(login_url="user_login")
def IssueDetailsSubmit(request):
    received_status=request.POST.get('receiving')

    trn = TransactionDetails()    
    trn.usr_id = UserDetails.objects.get(usr_id=request.POST.get('receiverName'))
    trn.section_id = SectionDetails.objects.get(section_id=request.POST.get('postedAt'))
    trn.trans_issue_date = request.POST.get('dateIssue')
    trn.issue_received_status = received_status   
    trn.save()

    total_item = len(request.POST.getlist('proId'))
    proId = request.POST.getlist('proId')
    remarks = request.POST.getlist('proRem')
    no_of_item=request.POST.getlist('proQun')
    trans_id=(TransactionDetails.objects.last()).trans_id          
   
    for t in range(total_item):
        pro_trn = ProductTransactionDetails()
        product_id=ProductDetails.objects.get(product_id=proId[t]) 
        pro_trn.trans_id = TransactionDetails.objects.get(trans_id=trans_id)   
        pro_trn.product_id = product_id
        pro_trn.trans_flag = 0      
        pro_trn.no_of_item_issue = no_of_item[t]
        pro_trn.issue_remarks = remarks[t]
        pro_trn.save()

        # Updating the current Quantity and Product Status
        product_id.current_quantity=str(int(product_id.current_quantity) - int(no_of_item[t]))
        product_id.product_new_or_open="OPENED"
        product_id.save()
        
    messages.success(request, 'Issue Details SAVED Successfully...!!')
    print('received_status------',received_status)
    if received_status == 'Yes':
        return redirect('/issueReceiptPage')
    else :
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
    return render(request,"return/page-return.html",{'flag':'Redirect','user_name':''})

@login_required(login_url="user_login")
def returnGetIssueStuff(request):
    trn_det_list=[]
    user_name=''
    for t in TransactionDetails.objects.filter(usr_id=request.POST.get('userdetail')):
        for p in ProductTransactionDetails.objects.filter(trans_id=t,trans_flag=0):
            trn_det_list.append(p)            
        user_name = t.usr_id.usr_name +" ("+t.usr_id.usr_des_id.usr_des_name+")"
    print("TETETETETETET--------- ",trn_det_list)
    return render(request,"return/page-return.html",{'trn_det_list':trn_det_list,'user_name':user_name,'flag':'DATA'})

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
    producthealth = request.POST.getlist('producthealth')
    healthRemark = request.POST.getlist('healthRemark')
    t_det = TransactionDetails.objects.get(trans_id=trn_no[0]) # For User Details
    pdet = ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[0]) # For Return Date     
    prodetno = []
    for pt in range(len(request.POST.getlist('trn_no'))):
        prodetno.append(ProductTransactionDetails.objects.get(pro_trans_id=pro_trn_no[pt]))
       # Updating ProductTransactionDetails Table
        ProductTransactionDetails.objects.filter(pro_trans_id=pro_trn_no[pt]).update(no_of_item_return=Rquantity[pt],return_remarks=returnRemark[pt],trans_return_date=returnDate,return_received_status=received_status,trans_flag=1) 
       # Updating Product health status table
        health,check = HealthStatusDetails.objects.update_or_create(product_id=ProductDetails.objects.get(product_id=product_id[pt]),defaults={"product_healthy": producthealth[pt], "health_remarks": healthRemark[pt],"product_status":productstatus[pt]})      
       # Updating product details
        current_quantity=str(int(ProductDetails.objects.get(product_id=product_id[pt]).current_quantity) + int(Rquantity[pt]))
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
    list_of_hprod = HealthStatusDetails.objects.all()
    return render(request,"reports/health.html",{'list_of_hprod':list_of_hprod})


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
    return render(request,"transfer/page-replace.html",{'flag':'Redirect','user_name':''})

@login_required(login_url="user_login")
def getAllIssuedStuffOfUser(request):
    trn_det_list=[]
    print("request.POST.get('userdetail')",request.GET.get('userdetail'))
    for t in TransactionDetails.objects.filter(usr_id=request.GET.get('userdetail')):
        for p in ProductTransactionDetails.objects.filter(trans_id=t,trans_flag=0):
            print("TETETETETETETET --- ",p)
            trn_det_list.append(p)        
    return render(request,"ajaxpage/productAJX.html",{'flag':'UserIssuedAssestList','trn_det_list':trn_det_list})

@login_required(login_url="user_login")
def getAllReplaceListStuff(request):  
    data = request.GET.get('issuedproduct').split(',')   
    # print("RRARARARRARAR - -- ",data[0])
    # print("RRARARARRARAR - -- ",data[1])
    rep_ass_List = ProductDetails.objects.filter(product_cat_id_id=data[1])
    # print("RRARARARRARAR - -- ",rep_ass_List.count())
    return render(request,"ajaxpage/productAJX.html",{'flag':'ReplaceAssestList','rep_ass_List':rep_ass_List})


@login_required(login_url="user_login")
def replaceDetailsSubmit(request):  

    # COMMON VARIABLE
    transferDate = request.POST.get('transferDate')
    received_status=request.POST.get('receiving')
    # VARIABLES FOR  RETURNING
    issuedproduct=request.POST.get('issuedproduct').split(',')
    t = TransactionDetails.objects.get(trans_id = issuedproduct[2])    
    section_id = t.section_id.section_id
    # VARIABLES FOR ISSUE
    newproducttoissue=request.POST.get('newproducttoissue')
    print('newproducttoissue   -   ',newproducttoissue) 

    # FOR ISSUE
    trn = TransactionDetails()    
    trn.usr_id = UserDetails.objects.get(usr_id=request.POST.get('userdetail'))
    trn.section_id = SectionDetails.objects.get(section_id=section_id)
    trn.trans_issue_date = transferDate
    trn.issue_received_status = received_status   
    trn.save()

    last_trn_id = (TransactionDetails.objects.last()).trans_id

    pro_trn = ProductTransactionDetails()
    product_id=ProductDetails.objects.get(product_id=newproducttoissue) 
    pro_trn.trans_id = TransactionDetails.objects.get(trans_id=last_trn_id)   
    pro_trn.product_id = product_id
    pro_trn.trans_flag = 0 #Issued      
    pro_trn.no_of_item_issue = "1"
    pro_trn.issue_remarks = "Issued for Replacement"
    pro_trn.save()

    # Updating the current Quantity and Product Status
    product_id.current_quantity=str(int(product_id.current_quantity) - int("1"))
    product_id.product_new_or_open="OPENED"
    product_id.save()


    # FOR RETURN
    print("issuedproduct[0]-------------------------- ",issuedproduct[0])
    pt = ProductTransactionDetails.objects.get(pro_trans_id=issuedproduct[0])
    return_product_id = pt.product_id 
    pt.return_remarks="Replacement@"+str(t.trans_id)
    pt.trans_return_date=transferDate
    pt.return_received_status=received_status
    pt.no_of_item_return = "1"
    pt.trans_flag = 1 #Return
    pt.trans_id = TransactionDetails.objects.get(trans_id=last_trn_id)
    print("ASSET RETURNING-------------------------",pt)
    print("ASSET return_product_id-------------------------",return_product_id.product_id)
    pt.save()    

    # Updating Product health status table
    health,check = HealthStatusDetails.objects.update_or_create(product_id=return_product_id.product_id,defaults={"product_healthy": request.POST.get('producthealth'), "health_remarks": request.POST.get('healthRemark'),"product_status":request.POST.get('productstatus')})      
    # Updating product details
    current_quantity=str(int(ProductDetails.objects.get(product_id=return_product_id.product_id).current_quantity) + int("1"))
    ProductDetails.objects.filter(product_id=return_product_id.product_id).update(current_quantity=current_quantity)        

    print("LAST TRAN ID ---------- ",last_trn_id)
    messages.success(request, 'Replacement SAVED Successfully...!!')
    return render(request,"transfer/page-replace.html",{'flag':'Redirect','user_name':''})

@login_required(login_url="user_login")
def sectionDesigMapRedirect(request):     
    return render(request,"master/mapper/secDesigmapper.html")


@login_required(login_url="user_login")
def DesigEmpMapRedirect(request):     
    return render(request,"master/mapper/desigEmpMapper.html")


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