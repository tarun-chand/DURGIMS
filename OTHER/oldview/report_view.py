from django.shortcuts import render,redirect
from django.http import HttpResponse
from .models import CourtEstablishmentMaster,ProductCategoryMaster,ProductDetails,SectionDetails,ProductModelMaster,HealthStatusDetails,ProductTransactionDetails,UserDetails
from django.contrib import messages
from django.db.models import Count,Sum
from collections import defaultdict
from django.contrib.auth.decorators import login_required
from django.db import connection

point = []
op_data=[]
my_data={}
@login_required(login_url="user_login")
def AllWiseRedirect(request): 
    return render(request,"reports/allreports.html")

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
    return render(request,"reports/reportAJX.html",{'result':result,'repFlag':repoType})

@login_required(login_url="user_login")
def AllWiseReport(request): 
    cursor = connection.cursor()   
    category = ProductCategoryMaster.objects.all()
    repFlag = request.POST.get('reportype')
    subreportype= request.POST.get('subreportype')
    print('subreportype---',subreportype)
    if subreportype == 'ALL':
        display =''
        condition = ''
        if repFlag == 'estRepo':
            display = "g.est_name as \"Establishment Name\","
            condition ="group by g.est_name"        
        elif repFlag == 'courtRepo':
            display = "e.section_name as \"Court Name\","
            condition ="and e.section_type='Court' group by e.section_name"
        elif repFlag == 'secRepo':
            display = "e.section_name as \"Section Name\","
            condition ="and e.section_type='Section' group by e.section_name"
        elif repFlag == 'usrRepo':
            display = "h.usr_name as \"User Name\","
            condition =" group by h.usr_name"
        
        qs="select "+display
        qe=" from  store_productdetails a,store_productcategorymaster b,store_producttransactiondetails c,store_transactiondetails d,store_sectiondetails e,store_buildingmaster f,store_courtestablishmentmaster g,store_userdetails h where c.trans_flag=0 and d.trans_id=c.trans_id_id and d.section_id_id =e.section_id and e.building_name_id=f.building_id and f.est_id_id = g.est_id and c.product_id_id = a.product_id and a.product_cat_id_id = b.product_cat_id and d.usr_id_id = h.usr_id "+condition
        str =''
        for c in category:        
            str=str+"SUM(case when (product_cat_name='"+c.product_cat_name+"') then 1 else 0 end) as \""+c.product_cat_name+"\","    
        str = str[:len(str)-1]
        final_query = qs+str+qe
        cursor.execute(final_query)
        pc = list(cursor.description)
        result = cursor.fetchall()
        columns = []
        for c in pc:
            columns.append(c.name)
        
        return render(request,"reports/allreports.html",{'columns':columns,'result':result,'repFlag':repFlag,'subFlag':subreportype})
    else:
        display =''
        condition=''
        gby = ''
        if repFlag == 'estRepo':
            display = CourtEstablishmentMaster.objects.filter(est_id=subreportype).values_list('est_name')
            condition = "g.est_name"
            gby ="and g.est_id="+subreportype+"group by g.est_name"                    
        elif repFlag == 'courtRepo':
            display = SectionDetails.objects.filter(section_id=subreportype,section_type='Court').values_list('section_name')
            condition = "e.section_name"
            gby ="and e.section_id="+subreportype+" and  e.section_type='Court' group by e.section_name"
        elif repFlag == 'secRepo':
            display = SectionDetails.objects.filter(section_id=subreportype,section_type='Section').values_list('section_name')
            condition = "e.section_name"
            gby ="and e.section_id="+subreportype+" and  e.section_type='Section' group by e.section_name"
        elif repFlag == 'usrRepo':
            display = UserDetails.objects.filter(usr_id=subreportype).values_list('usr_name')
            condition ="h.usr_name"
            gby="and h.usr_id="+subreportype+"group by h.usr_name"
        print("display---",display)
        quy = "select "+condition+",product_cat_name category,count(*) as c from  store_productdetails a,store_productcategorymaster b,store_producttransactiondetails c,store_transactiondetails d,store_sectiondetails e,store_buildingmaster f,store_courtestablishmentmaster g,store_userdetails h where c.trans_flag=0 and d.trans_id=c.trans_id_id and d.section_id_id =e.section_id and e.building_name_id=f.building_id and f.est_id_id = g.est_id and c.product_id_id = a.product_id and a.product_cat_id_id = b.product_cat_id and d.usr_id_id = h.usr_id "+gby+",product_cat_name"
        cursor.execute(quy)
        result = cursor.fetchall()
        print("RESULT--",result)
        return render(request,"reports/allreports.html",{'result':result,'display':display,'repFlag':repFlag,'subFlag':subreportype})




@login_required(login_url="user_login")
def byFilterRedirect(request):
    list_all_protype = ProductCategoryMaster.objects.filter(product_type=request.GET.get('protype'))
    return render(request,"reports/byfilter.html",{'list_all_protype':list_all_protype})

@login_required(login_url="user_login")
def productWiseReportRedirect(request):       
    # pro_cat_count = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
    point.clear() 
    op_data.clear()    
    try:
        operation = request.GET.get('op')         
        op_name = request.GET.get('op_name')         
        print("operation sdfsdf  -----",op_name)
        page=''        
        if operation == 'Category':
            cursor = connection.cursor()
            # total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
            cursor.execute('''select d.product_cat_name,cat.current_quantity from store_productcategorymaster d,(select c.product_cat_id_id, COALESCE(SUM(c.current_quantity),0) current_quantity from store_productdetails c GROUP BY c.product_cat_id_id) cat where d.product_cat_id = cat.product_cat_id_id order by d.product_cat_name''')
            columns = list(cursor.description)
            inhand_result = cursor.fetchall()         

            cursor.execute('''select c.product_cat_name,c.product_cat_name as no_of_item_inhand,cat.no_of_item_issue,c.product_cat_id from store_productcategorymaster c,(select b.product_cat_id_id,COALESCE(sum(a.no_of_item_issue),0) no_of_item_issue from store_producttransactiondetails a RIGHT JOIN store_productdetails b ON a.product_id_id=b.product_id group by b.product_cat_id_id order by b.product_cat_id_id) cat where c.product_cat_id = cat.product_cat_id_id order by c.product_cat_name''')
            columns = list(cursor.description)    
            issue_result = cursor.fetchall()        
            final_result=[]

            for i in range(0,len(inhand_result)):
                a = (inhand_result[i][0],int(inhand_result[i][1]),int(issue_result[i][2]),int(issue_result[i][3]))
                final_result.append(a)

            results = []
            for row in final_result:
                row_dict = {}
                for i, col in enumerate(columns):
                    row_dict[col.name] = row[i]
                results.append(row_dict)
            print("results--------------------------",results)
            page='Category'       
            point.append('Category')                            
            my_data={'op_type': 'Category', 'op_id': 0}
            op_data.append(my_data)
            # return render(request,"reports/productSummary.html",{'pro_cat_count':results,'point':point})
        elif operation == 'Model':
            cursor = connection.cursor()
            id = request.GET.get('catid')                  
            # total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
            if request.GET.get('status') == 'issue' :
                print("I AM MODEL HERE")
                cursor.execute('''select c.product_mod_name,cat.no_of_item_issue,c.product_mod_id,cat.product_type from store_productmodelmaster c,(select b.product_model_id,b.product_cat_id_id,COALESCE(sum(a.no_of_item_issue),0) no_of_item_issue,s.product_type from store_producttransactiondetails a RIGHT JOIN store_productdetails b ON a.product_id_id=b.product_id JOIN store_productcategorymaster s ON  s.product_cat_id = b.product_cat_id_id group by b.product_model_id,b.product_cat_id_id,s.product_type) cat where cat.product_cat_id_id='''+id+'''  and c.product_mod_id = cat.product_model_id order by c.product_mod_name''')
            else:
                cursor.execute('''select d.product_mod_name,cat.current_quantity,d.product_mod_id,cat.product_type from store_productmodelmaster d,(select c.product_model_id, COALESCE(SUM(c.current_quantity),0) current_quantity,s.product_type from store_productdetails c,store_productcategorymaster s where s.product_cat_id = c.product_cat_id_id and c.product_cat_id_id='''+id+''' GROUP BY c.product_model_id,s.product_type) cat where d.product_mod_id = cat.product_model_id order by d.product_mod_name''')               

            columns = list(cursor.description)    
            inhand_result = cursor.fetchall()  
            final_result=[]
            for i in range(0,len(inhand_result)):
                a = (inhand_result[i][0],int(inhand_result[i][1]),int(inhand_result[i][2]),inhand_result[i][3])
                final_result.append(a)

            results = []
            for row in final_result:
                row_dict = {}
                for i, col in enumerate(columns):
                    row_dict[col.name] = row[i]
                results.append(row_dict)
            print("request.GET.get('status')-------------",request.GET.get('status'))
            print("results----------------",results)                  
            page='Model'
            point.append('Category')            
            point.append('Model')            
            my_data={'op_type': 'Category', 'op_id': 0}
            op_data.append(my_data)
            my_data={'op_type': 'Model', 'op_id': id}
            op_data.append(my_data)

        elif operation == 'Product':
            cursor = connection.cursor()
            id = request.GET.get('modid')                        
            print("modid--------------------------",id)
            print("request.GET.get('status')-----------",request.GET.get('status'))
            # total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
            if request.GET.get('status') == 'issue' : 
                if  request.GET.get('cattype') == 'Consumable':
                    print("I AM CONSUMABLE")
                    cursor.execute('''select d.product_com_name,cat.product_mod_name,product_serialno,cat.issued_quantity,cat.product_id from store_productcompanymaster d,(select c.product_id,c.product_serialno,f.product_mod_name,COALESCE(SUM(c.current_quantity),0) issued_quantity,c.product_model_id,c.product_name_id  from store_productdetails c,store_productmodelmaster f where f.product_mod_id = c.product_model_id and c.current_quantity>0 and product_model_id='''+id+''' GROUP BY c.product_id,c.product_serialno,f.product_mod_name) cat where d.product_com_id  = cat.product_name_id order by d.product_com_name''')            
                else:
                    print("I AM NON----CONSUMABLE")
                    cursor.execute('''select d.product_com_name,cat.product_mod_name,product_serialno,cat.issued_quantity,cat.product_id from store_productcompanymaster d,(select c.product_id,c.product_serialno,f.product_mod_name,COALESCE(SUM(c.current_quantity),0) issued_quantity,c.product_model_id,c.product_name_id  from store_productdetails c,store_productmodelmaster f where f.product_mod_id = c.product_model_id and c.current_quantity=0 and product_model_id='''+id+''' GROUP BY c.product_id,c.product_serialno,f.product_mod_name) cat where d.product_com_id  = cat.product_name_id order by d.product_com_name''')            
            else:
                cursor.execute('''select d.product_com_name,cat.product_mod_name,product_serialno,cat.current_quantity,cat.product_id from store_productcompanymaster d,(select c.product_id,c.product_serialno,f.product_mod_name,COALESCE(SUM(c.current_quantity),0) current_quantity,c.product_model_id,c.product_name_id from store_productdetails c,store_productmodelmaster f where f.product_mod_id = c.product_model_id and c.current_quantity != 0  and product_model_id='''+id+''' GROUP BY c.product_id,c.product_serialno,f.product_mod_name) cat where d.product_com_id  = cat.product_name_id order by d.product_com_name''')
                        
            columns = list(cursor.description)
            inhand_result = cursor.fetchall()      
                                                 
            final_result=[]
            for i in range(0,len(inhand_result)):                                
                a = (inhand_result[i][0],inhand_result[i][1],inhand_result[i][2],int(inhand_result[i][3]))                
                final_result.append(a)            
            results = []
            print("row--------------------")
            for row in inhand_result:
                row_dict = {}
                for i, col in enumerate(columns):
                    row_dict[col.name] = row[i]
                results.append(row_dict)
            page='Product'
            point.append('Category')            
            point.append('Model')            
            point.append('Product')            
            my_data={'op_type': 'Category', 'op_id': 0}
            op_data.append(my_data)
            my_data={'op_type': 'Model', 'op_id': id}
            op_data.append(my_data)
            my_data={'op_type': 'Product', 'op_id': id}
            op_data.append(my_data)
        print("op_data--------",op_data)

        return render(request,"reports/productSummary.html",{'pro_cat_count':results,'point':point,'page':page,'op_name':op_name,'status':request.GET.get('status')})
    except Exception as e:
        print("ERROR",e)        
        


@login_required(login_url="user_login")
def getProductModels(request,id,op):
    try:        
        
        cursor = connection.cursor()
        # total_qun = ProductDetails.objects.values('product_cat_id').annotate(Isum=Sum('initial_quantity'),Csum=Sum('current_quantity'),Rsum=Sum('initial_quantity')-Sum('current_quantity')).values('product_cat_id__product_cat_name','Isum','Csum','Rsum')
        cursor.execute('''select d.product_mod_name,cat.current_quantity from store_productmodelmaster d,(select c.product_model_id, COALESCE(SUM(c.current_quantity),0) current_quantity from store_productdetails c where product_cat_id_id='''+id+''' GROUP BY c.product_model_id) cat where d.product_mod_id = cat.product_model_id order by d.product_mod_name''')
        columns = list(cursor.description)
        inhand_result = cursor.fetchall()      

        print("inhand_result-----",inhand_result)

        cursor.execute('''select c.product_mod_name,c.product_mod_name as no_of_item_inhand,cat.no_of_item_issue,c.product_mod_id from store_productmodelmaster c,(select b.product_model_id,b.product_cat_id_id,COALESCE(sum(a.no_of_item_issue),0) no_of_item_issue from store_producttransactiondetails a  RIGHT JOIN store_productdetails b ON a.product_id_id=b.product_id  group by b.product_model_id,b.product_cat_id_id order by b.product_model_id) cat where  cat.product_cat_id_id='''+id+'''  and c.product_mod_id = cat.product_model_id order by c.product_mod_name''')
        columns = list(cursor.description)    
        issue_result = cursor.fetchall()        
        final_result=[]
        for i in range(0,len(inhand_result)):
            a = (inhand_result[i][0],int(inhand_result[i][1]),int(issue_result[i][2]),int(issue_result[i][3]))
            final_result.append(a)

        results = []
        for row in final_result:
            row_dict = {}
            for i, col in enumerate(columns):
                row_dict[col.name] = row[i]
            results.append(row_dict)
        print("results-------------",results)
        point.append('product_model_summary')
        return render(request,"reports/productSummary.html",{'pro_cat_count':results,'point':point})
    except Exception as e:
        print("ERROR",e)        
        cursor = connection.cursor()        
    # return render(request,"reports/productWise.html")

@login_required(login_url="user_login")
def getProductModelsIssued(request,id):
    print("ASASSSAS--------",id) 
    return render(request,"reports/productWise.html")


    