from django.shortcuts import render, redirect
from django.http import HttpResponse, JsonResponse
from .models import CourtEstablishmentMaster, ProductCategoryMaster, ProductDetails, SectionDetails, ProductModelMaster, HealthStatusDetails, ProductTransactionDetails, UserDetails, SectionDesignationMapper,Employee_Journey
from django.contrib import messages
from django.db.models import Count, Sum
from collections import defaultdict
from django.contrib.auth.decorators import login_required
from django.db import connection
import json
import subprocess
import time
import threading

point = []
op_data = []
my_data = {}


@login_required(login_url="user_login")
def AllWiseRedirect(request):   
  list_of_cat = ProductCategoryMaster.objects.all()
  return render(request, "reports/productwisesummary.html",{'list_of_cat':list_of_cat,'procatname':''})

@login_required(login_url="user_login")
def productWiseReportSubmit(request):   
  pcatid = request.POST.get('productcat')
  cursor = connection.cursor()
  a = "SELECT product_com_name,product_mod_name,count(product_mod_name) as cmod_count,product_type FROM completeproductdetail where product_cat_id="+pcatid+" GROUP BY product_com_name,product_mod_name,product_type ORDER BY product_com_name ;"
  cursor.execute(a)  
  prosum = cursor.fetchall()
  print(a)
  print("ASDFGHKHGHJ",prosum[0][3])

  if prosum[0][3] == 'Consumable':
    b= "SELECT product_com_name,count(product_mod_name) as total,sum(current_quantity) as inhand,count(product_mod_name)-sum(current_quantity) as issued FROM completeproductdetail where product_cat_id="+pcatid+" GROUP BY product_com_name ORDER BY product_com_name"  
  else:
    b = "SELECT product_com_name,count(product_mod_name) as total,sum(current_quantity) as inhand,count(product_mod_name)-sum(current_quantity) as issued FROM completeproductdetail where product_cat_id="+pcatid+" GROUP BY product_com_name ORDER BY product_com_name"
  print("SQL--",b)
  cursor.execute(b)  
  gsum = cursor.fetchall()
  grandtotal = 0
  total_stock = 0
  total_issue=0
  for g in gsum:
    grandtotal=grandtotal+g[1]  
    total_stock = total_stock+g[2]
    total_issue = total_issue+g[3]
  list_of_cat = ProductCategoryMaster.objects.all() 
  return render(request, "reports/productwisesummary.html",{'prosum':prosum,'gsum':gsum,'procatname':request.POST.get('procatname'),'grandtotal':grandtotal,'total_stock':total_stock,'total_issue':total_issue,'list_of_cat':list_of_cat,'protype':prosum[0][3]})

@login_required(login_url="user_login")
def reportFilter(request):
    repoType = request.GET.get('reportype')
    print(repoType)
    if repoType == 'estRepo':
        result = CourtEstablishmentMaster.objects.all()
    elif repoType == 'courtRepo':
        result = SectionDetails.objects.filter(section_type='Court').values()
    elif repoType == 'secRepo':
        result = SectionDetails.objects.filter(section_type='Section').values()
    elif repoType == 'usrRepo':
        result = UserDetails.objects.all()
    print(result)
    return render(request, "reports/reportAJX.html", {'result': result, 'repFlag': repoType})


@login_required(login_url="user_login")
def AllWiseReport(request):
    cursor = connection.cursor()
    category = ProductCategoryMaster.objects.all()
    repFlag = request.POST.get('reportype')
    subreportype = request.POST.get('subreportype')
    print('subreportype---', subreportype)
    if subreportype == 'ALL':
        display = ''
        condition = ''
        if repFlag == 'estRepo':
            display = "g.est_name as \"Establishment Name\","
            condition = "group by g.est_name"
        elif repFlag == 'courtRepo':
            display = "e.section_name as \"Court Name\","
            condition = "and e.section_type='Court' group by e.section_name"
        elif repFlag == 'secRepo':
            display = "e.section_name as \"Section Name\","
            condition = "and e.section_type='Section' group by e.section_name"
        elif repFlag == 'usrRepo':
            display = "h.usr_name as \"User Name\","
            condition = " group by h.usr_name"

        qs = "select "+display
        qe = " from  store_productdetails a,store_productcategorymaster b,store_producttransactiondetails c,store_transactiondetails d,store_sectiondetails e,store_buildingmaster f,store_courtestablishmentmaster g,store_userdetails h where c.trans_flag=0 and d.trans_id=c.trans_id_id and d.section_id_id =e.section_id and e.building_name_id=f.building_id and f.est_id_id = g.est_id and c.product_id_id = a.product_id and a.product_cat_id_id = b.product_cat_id and d.usr_id_id = h.usr_id "+condition
        str = ''
        for c in category:
            str = str+"SUM(case when (product_cat_name='"+c.product_cat_name + \
                "') then 1 else 0 end) as \""+c.product_cat_name+"\","
        str = str[:len(str)-1]
        final_query = qs+str+qe
        cursor.execute(final_query)
        pc = list(cursor.description)
        result = cursor.fetchall()
        columns = []
        for c in pc:
            columns.append(c.name)

        return render(request, "reports/allreports.html", {'columns': columns, 'result': result, 'repFlag': repFlag, 'subFlag': subreportype})
    else:
        display = ''
        condition = ''
        gby = ''
        if repFlag == 'estRepo':
            display = CourtEstablishmentMaster.objects.filter(
                est_id=subreportype).values_list('est_name')
            condition = "g.est_name"
            gby = "and g.est_id="+subreportype+"group by g.est_name"
        elif repFlag == 'courtRepo':
            display = SectionDetails.objects.filter(
                section_id=subreportype, section_type='Court').values_list('section_name')
            condition = "e.section_name"
            gby = "and e.section_id="+subreportype + \
                " and  e.section_type='Court' group by e.section_name"
        elif repFlag == 'secRepo':
            display = SectionDetails.objects.filter(
                section_id=subreportype, section_type='Section').values_list('section_name')
            condition = "e.section_name"
            gby = "and e.section_id="+subreportype + \
                " and  e.section_type='Section' group by e.section_name"
        elif repFlag == 'usrRepo':
            display = UserDetails.objects.filter(
                usr_id=subreportype).values_list('usr_name')
            condition = "h.usr_name"
            gby = "and h.usr_id="+subreportype+"group by h.usr_name"
        print("display---", display)
        quy = "select "+condition+",product_cat_name category,count(*) as c from  store_productdetails a,store_productcategorymaster b,store_producttransactiondetails c,store_transactiondetails d,store_sectiondetails e,store_buildingmaster f,store_courtestablishmentmaster g,store_userdetails h where c.trans_flag=0 and d.trans_id=c.trans_id_id and d.section_id_id =e.section_id and e.building_name_id=f.building_id and f.est_id_id = g.est_id and c.product_id_id = a.product_id and a.product_cat_id_id = b.product_cat_id and d.usr_id_id = h.usr_id "+gby+",product_cat_name"
        cursor.execute(quy)
        result = cursor.fetchall()
        print("RESULT--", result)
        return render(request, "reports/allreports.html", {'result': result, 'display': display, 'repFlag': repFlag, 'subFlag': subreportype})


@login_required(login_url="user_login")
def byFilterRedirect(request):
    list_all_protype = ProductCategoryMaster.objects.filter(
        product_type=request.GET.get('protype'))
    return render(request, "reports/byfilter.html", {'list_all_protype': list_all_protype})


@login_required(login_url="user_login")
def productWiseReportRedirect(request):
    # pro_cat_count = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
    point.clear()
    op_data.clear()
    try:
        operation = request.GET.get('op')
        op_name = request.GET.get('op_name')
        print("operation sdfsdf  -----", op_name)
        page = ''
        if operation == 'Category':
            cursor = connection.cursor()
            # total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
            cursor.execute('''select d.product_cat_name,cat.current_quantity from store_productcategorymaster d,(select c.product_cat_id_id, COALESCE(SUM(c.current_quantity),0) current_quantity from store_productdetails c GROUP BY c.product_cat_id_id) cat where d.product_cat_id = cat.product_cat_id_id order by d.product_cat_name''')
            columns = list(cursor.description)
            inhand_result = cursor.fetchall()

            cursor.execute('''select c.product_cat_name,c.product_cat_name as no_of_item_inhand,cat.no_of_item_issue,c.product_cat_id from store_productcategorymaster c,(select b.product_cat_id_id,COALESCE(sum(a.no_of_item_issue),0) no_of_item_issue from store_producttransactiondetails a RIGHT JOIN store_productdetails b ON a.product_id_id=b.product_id group by b.product_cat_id_id order by b.product_cat_id_id) cat where c.product_cat_id = cat.product_cat_id_id order by c.product_cat_name''')
            columns = list(cursor.description)
            issue_result = cursor.fetchall()
            final_result = []

            for i in range(0, len(inhand_result)):
                a = (inhand_result[i][0], int(inhand_result[i][1]), int(
                    issue_result[i][2]), int(issue_result[i][3]))
                final_result.append(a)

            results = []
            for row in final_result:
                row_dict = {}
                for i, col in enumerate(columns):
                    row_dict[col.name] = row[i]
                results.append(row_dict)
            print("results--------------------------", results)
            page = 'Category'
            point.append('Category')
            my_data = {'op_type': 'Category', 'op_id': 0}
            op_data.append(my_data)
            # return render(request,"reports/productSummary.html",{'pro_cat_count':results,'point':point})
        elif operation == 'Model':
            cursor = connection.cursor()
            id = request.GET.get('catid')
            # total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
            if request.GET.get('status') == 'issue':
                print("I AM MODEL HERE")
                cursor.execute('''select c.product_mod_name,cat.no_of_item_issue,c.product_mod_id,cat.product_type from store_productmodelmaster c,(select b.product_model_id,b.product_cat_id_id,COALESCE(sum(a.no_of_item_issue),0) no_of_item_issue,s.product_type from store_producttransactiondetails a RIGHT JOIN store_productdetails b ON a.product_id_id=b.product_id JOIN store_productcategorymaster s ON  s.product_cat_id = b.product_cat_id_id group by b.product_model_id,b.product_cat_id_id,s.product_type) cat where cat.product_cat_id_id='''+id+'''  and c.product_mod_id = cat.product_model_id order by c.product_mod_name''')
            else:
                cursor.execute('''select d.product_mod_name,cat.current_quantity,d.product_mod_id,cat.product_type from store_productmodelmaster d,(select c.product_model_id, COALESCE(SUM(c.current_quantity),0) current_quantity,s.product_type from store_productdetails c,store_productcategorymaster s where s.product_cat_id = c.product_cat_id_id and c.product_cat_id_id=''' +
                               id+''' GROUP BY c.product_model_id,s.product_type) cat where d.product_mod_id = cat.product_model_id order by d.product_mod_name''')

            columns = list(cursor.description)
            inhand_result = cursor.fetchall()
            final_result = []
            for i in range(0, len(inhand_result)):
                a = (inhand_result[i][0], int(inhand_result[i][1]), int(
                    inhand_result[i][2]), inhand_result[i][3])
                final_result.append(a)

            results = []
            for row in final_result:
                row_dict = {}
                for i, col in enumerate(columns):
                    row_dict[col.name] = row[i]
                results.append(row_dict)
            print("request.GET.get('status')-------------",
                  request.GET.get('status'))
            print("results----------------", results)
            page = 'Model'
            point.append('Category')
            point.append('Model')
            my_data = {'op_type': 'Category', 'op_id': 0}
            op_data.append(my_data)
            my_data = {'op_type': 'Model', 'op_id': id}
            op_data.append(my_data)

        elif operation == 'Product':
            cursor = connection.cursor()
            id = request.GET.get('modid')
            print("modid--------------------------", id)
            print("request.GET.get('status')-----------",
                  request.GET.get('status'))
            # total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
            if request.GET.get('status') == 'issue':
                if request.GET.get('cattype') == 'Consumable':
                    print("I AM CONSUMABLE")
                    cursor.execute('''select d.product_com_name,cat.product_mod_name,product_serialno,cat.issued_quantity,cat.product_id from store_productcompanymaster d,(select c.product_id,c.product_serialno,f.product_mod_name,COALESCE(SUM(c.current_quantity),0) issued_quantity,c.product_model_id,c.product_name_id  from store_productdetails c,store_productmodelmaster f where f.product_mod_id = c.product_model_id and c.current_quantity>0 and product_model_id=''' +
                                   id+''' GROUP BY c.product_id,c.product_serialno,f.product_mod_name) cat where d.product_com_id  = cat.product_name_id order by d.product_com_name''')
                else:
                    print("I AM NON----CONSUMABLE")
                    cursor.execute('''select d.product_com_name,cat.product_mod_name,product_serialno,cat.issued_quantity,cat.product_id from store_productcompanymaster d,(select c.product_id,c.product_serialno,f.product_mod_name,COALESCE(SUM(c.current_quantity),0) issued_quantity,c.product_model_id,c.product_name_id  from store_productdetails c,store_productmodelmaster f where f.product_mod_id = c.product_model_id and c.current_quantity=0 and product_model_id=''' +
                                   id+''' GROUP BY c.product_id,c.product_serialno,f.product_mod_name) cat where d.product_com_id  = cat.product_name_id order by d.product_com_name''')
            else:
                cursor.execute('''select d.product_com_name,cat.product_mod_name,product_serialno,cat.current_quantity,cat.product_id from store_productcompanymaster d,(select c.product_id,c.product_serialno,f.product_mod_name,COALESCE(SUM(c.current_quantity),0) current_quantity,c.product_model_id,c.product_name_id from store_productdetails c,store_productmodelmaster f where f.product_mod_id = c.product_model_id and c.current_quantity != 0  and product_model_id=''' +
                               id+''' GROUP BY c.product_id,c.product_serialno,f.product_mod_name) cat where d.product_com_id  = cat.product_name_id order by d.product_com_name''')

            columns = list(cursor.description)
            inhand_result = cursor.fetchall()

            final_result = []
            for i in range(0, len(inhand_result)):
                a = (inhand_result[i][0], inhand_result[i][1],
                     inhand_result[i][2], int(inhand_result[i][3]))
                final_result.append(a)
            results = []
            print("row--------------------")
            for row in inhand_result:
                row_dict = {}
                for i, col in enumerate(columns):
                    row_dict[col.name] = row[i]
                results.append(row_dict)
            page = 'Product'
            point.append('Category')
            point.append('Model')
            point.append('Product')
            my_data = {'op_type': 'Category', 'op_id': 0}
            op_data.append(my_data)
            my_data = {'op_type': 'Model', 'op_id': id}
            op_data.append(my_data)
            my_data = {'op_type': 'Product', 'op_id': id}
            op_data.append(my_data)
        print("op_data--------", op_data)

        return render(request, "reports/productSummary.html", {'pro_cat_count': results, 'point': point, 'page': page, 'op_name': op_name, 'status': request.GET.get('status')})
    except Exception as e:
        print("ERROR", e)


@login_required(login_url="user_login")
def getProductModels(request, id, op):
    try:

        cursor = connection.cursor()
        # total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
        cursor.execute('''select d.product_mod_name,cat.current_quantity from store_productmodelmaster d,(select c.product_model_id, COALESCE(SUM(c.current_quantity),0) current_quantity from store_productdetails c where product_cat_id_id=''' +
                       id+''' GROUP BY c.product_model_id) cat where d.product_mod_id = cat.product_model_id order by d.product_mod_name''')
        columns = list(cursor.description)
        inhand_result = cursor.fetchall()

        print("inhand_result-----", inhand_result)

        cursor.execute('''select c.product_mod_name,c.product_mod_name as no_of_item_inhand,cat.no_of_item_issue,c.product_mod_id from store_productmodelmaster c,(select b.product_model_id,b.product_cat_id_id,COALESCE(sum(a.no_of_item_issue),0) no_of_item_issue from store_producttransactiondetails a  RIGHT JOIN store_productdetails b ON a.product_id_id=b.product_id  group by b.product_model_id,b.product_cat_id_id order by b.product_model_id) cat where  cat.product_cat_id_id='''+id+'''  and c.product_mod_id = cat.product_model_id order by c.product_mod_name''')
        columns = list(cursor.description)
        issue_result = cursor.fetchall()
        final_result = []
        for i in range(0, len(inhand_result)):
            a = (inhand_result[i][0], int(inhand_result[i][1]), int(
                issue_result[i][2]), int(issue_result[i][3]))
            final_result.append(a)

        results = []
        for row in final_result:
            row_dict = {}
            for i, col in enumerate(columns):
                row_dict[col.name] = row[i]
            results.append(row_dict)
        print("results-------------", results)
        point.append('product_model_summary')
        return render(request, "reports/productSummary.html", {'pro_cat_count': results, 'point': point})
    except Exception as e:
        print("ERROR", e)
        cursor = connection.cursor()
    # return render(request,"reports/productWise.html")


@login_required(login_url="user_login")
def getProductModelsIssued(request, id):
    print("ASASSSAS--------", id)
    return render(request, "reports/productWise.html")


@login_required(login_url="user_login")
def getCourtSectionWiseData(request):
    sd = SectionDesignationMapper.objects.filter(
        section=request.GET.get('sectionid')).exclude(staff=37)
    emp_name=[]
    for s in sd:
      print(s.sdm_id)
      ej = Employee_Journey.objects.filter(sdm=s.sdm_id,current_status='D')   
      for e in ej:
        emp_name.append(e.usr.usr_name)
    print("emp_name -- ",emp_name)
    tabdata = ''
    for i, s in enumerate(sd):
        if i == 0:
            tabdata = tabdata+"<thead><tr class='ligth'><th colspan='5'><h5>Court/Section Name : <span style='color: brown;''>"+s.section.section_name + \
                "</span></h5></th></tr><tr class='ligth'><th style='color: blueviolet;'>S.No</th><th style='color: blueviolet;'>Assigned To</th><th style='color: blueviolet;'>Current Staff</th><th style='color: blueviolet;'>IP Address</th><th style='color: blueviolet;'>Issued Itmes</th></tr></thead><tbody>"
        tabdata = tabdata+"<tr><th style='vertical-align: top;'>"+str(i+1)+".</th><th style='vertical-align: top;'>"+s.staff.staff_des_name+"</th><th style='vertical-align: top;'>"+str(emp_name[i])+"</th><th style='vertical-align: top;'>"+s.ip_address + \
            "</th><td><table class='table-borderless' style='width: 100%;'><thead><tr class='table-primary'><th>S.no</th><th>Product Category</th><th>Product Make Model</th><th>Serial No</th><th>Issue Date</th><th>Issue Remarks</th></tr></thead><tbody>"
        cursor = connection.cursor()
        cursor.execute("select product_cat_name,product_com_name,product_mod_name,product_serialno,cartridge_toner,trans_issue_date,issue_remarks,product_type from inventory_transactiondetails a,inventory_producttransactiondetails b,completeproductdetail c where a.trans_id=b.trans_id and b.productid_id=c.product_id and b.trans_flag=0 and a.sdm_id="+str(s.sdm_id)+" ORDER BY product_serialno DESC")
        result = cursor.fetchall()
        for j, r in enumerate(result):          
          # tabdata = tabdata+"<tr><td>" + \
          #       str(j+1)+"</td><td></td><td></td><td></td></tr>"
          tabdata = tabdata+"<tr><td>"+str(j+1)+".</td><td>"+r[0]+"</td><td>"+r[1]+"<br>"+r[2]+"</td><td>"+r[3]+"</td><td>"+str(r[5].strftime('%d-%m-%Y'))+"</td><td>"+r[6]+"</td></tr>"
        tabdata = tabdata+"</tbody></table><td></tr>"         
        # tabdata = "<table><thead><tr><th>Roll No</th><th>Name</th></tr></thead><tbody><tr><td>911</td><td>Tarun</td></tr></tbody></table>"      
    return JsonResponse({'tabdata': tabdata}, content_type="application/json")




@login_required(login_url="user_login")
def getUsersWiseData(request):
  userid=request.GET.get('userid')
  data_list = Employee_Journey.objects.filter(usr=userid,current_status='D')
  for u in data_list:  
    print("u.sdm--------",u.sdm.sdm_id )
    cursor = connection.cursor()
    cursor.execute("select product_type,product_cat_name,product_com_name,product_mod_name,product_serialno,cartridge_toner,trans_issue_date,issue_remarks from  inventory_transactiondetails a, inventory_producttransactiondetails b, completeproductdetail c, inventory_sectiondesignationmapper d where d.sdm_id = a.sdm_id and a.trans_id=b.trans_id and b.productid_id=c.product_id and b.trans_flag=0 and d.sdm_id="+ str(u.sdm.sdm_id) +"ORDER BY product_serialno DESC")
    result = cursor.fetchall()
    print(result)
    tbhead = "<thead><tr><th colspan=9>Employee Name : "+u.usr.usr_name+"</th></tr><tr><th colspan=9>Section/Court Name : "+u.sdm.section.section_name+"</th></tr><tr><th>S.no</th><th>Product Type</th><th>Category</th><th>Company</th><th>Model</th><th>Serial No</th><th>Issue Date</th><th>Issue Remark</th></tr></thead><tbody>"
    tabdata=''
    for i,r in enumerate(result):
      tabdata = tabdata+"<tr><td>"+ str(i+1) +"</td><td>"+ r[0] +"</td><td>"+ r[1] +"</td><td>"+ r[2] +"</td><td>"+ r[3] +"</td><td>"+ r[4] +"</td><td>"+ r[5] +"</td><td>"+ str(r[6].strftime('%d-%m-%Y')) +"</td><td>"+ r[7] +"</td></tr>"  
    tabdata = tbhead+tabdata+"</tbody>"
  return JsonResponse({'tabdata': tabdata}, content_type="application/json")  


@login_required(login_url="user_login")
def getProductList(request):
  productid=request.GET.get('productid')
  cursor = connection.cursor()
  cursor.execute("select e.section_name,f.staff_des_name,f.staff_type,h.usr_name,product_type,product_cat_name,product_com_name,product_mod_name,product_serialno,cartridge_toner,trans_issue_date,issue_remarks from  inventory_transactiondetails a, inventory_producttransactiondetails b, completeproductdetail c, inventory_sectiondesignationmapper d,inventory_sectiondetails e,inventory_staffdesignationmaster f,inventory_employee_journey g,inventory_userdetails h where a.trans_id=b.trans_id and b.productid_id=c.product_id and a.sdm_id = d.sdm_id and d.section_id = e.section_id and d.staff_id = f.staff_id and a.sdm_id = g.sdm_id and d.sdm_id = g.sdm_id and g.usr_id = h.usr_id and b.productid_id=" +productid+ " and b.trans_flag=0 ORDER BY product_serialno DESC")
  result = cursor.fetchall()
  tbhead = "<thead><tr><th>Court/Section Name</th><th>Assigned To</th><th>Current Employee</th><th>Product Type</th><th>Category</th><th>Company</th><th>Model</th><th>Serial No</th><th>Issue Date</th><th>Issue Remark</th></tr></thead><tbody>"
  tabdata = ''
  for r in result:
    tabdata = tabdata+"<tr><td>"+r[0]+"</td><td>"+r[1]+"</td><td>"+r[3]+"</td><td>"+r[4]+"</td><td>"+r[5]+"</td><td>"+r[6]+"</td><td>"+r[7]+"</td><td>"+r[8]+"</td><td>"+str(r[10].strftime('%d-%m-%Y'))+"</td><td>"+r[11]+"</td></tr>"  
  tabdata = tbhead+tabdata+"</tbody>"
  return JsonResponse({'tabdata': tabdata}, content_type="application/json")  


@login_required(login_url="user_login")
def checkIPRedirect(request):
  return render(request, "other/listip.html")   

@login_required(login_url="user_login")
def checkIP(request):
  ip = []
  ip.append(('172.17.136.110','District Court Durg','Establishment','Durg','Durg','Durg'))
  ip.append(('10.132.212.110','District Court Durg','Establishment','Durg','Durg','Durg'))
  ip.append(('172.20.92.130','Civil Court Bhilai-3','Establishment','Bhilai-3','Bhilai-3','Bhilai-3'))
  ip.append(('172.17.137.130','Civil Court Patan','Establishment','Patan','Patan','Patan'))
  ip.append(('172.20.212.69','Civil Court Dhamdha','Establishment','Dhamdha','Dhamdha','Dhamdha'))
  
  tabdata = ''
  tbhead = "<thead class='bg-white text-uppercase'><tr class='ligth ligth-data'><th>S.No</th><th>IP Address</th><th>Establishment</th><th>Section/Court</th><th>Assign To</th><th>Current User</th><th>Status</th></tr></thead><tbody>"
  for i,r in enumerate(ip):    
    response = subprocess.run(['ping', '-c', '1', r[0]], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)    
    if response.returncode == 0:
      tabdata = tabdata+"<tr><td>"+ str(i+1) +"</td><td>"+ r[0] +"</td><td>"+ r[1] +"</td><td>"+ r[2] +"</td><td>"+ r[3] +"</td><td>"+ r[4] +"</td><td><span style='height: 25px;width: 25px;background-color: green;border-radius: 50%;display: inline-block;'></span></td></tr>"
    else:       
      tabdata = tabdata+"<tr><td>"+ str(i+1) +"</td><td>"+ r[0] +"</td><td>"+ r[1] +"</td><td>"+ r[2] +"</td><td>"+ r[3] +"</td><td>"+ r[4] +"</td><td><span style='height: 25px;width: 25px;background-color: red;border-radius: 50%;display: inline-block;'></span></td></tr>"
  tabdata = tbhead+ tabdata +"</tbody>" 
  print("IP------------ DONNNNEEEE")
  return JsonResponse({'tabdata': tabdata}, content_type="application/json")
  
     

