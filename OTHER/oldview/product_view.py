from django.shortcuts import render,redirect
from django.http import HttpResponse
from .models import ProductCategoryMaster,ProductDetails,ProductCompanyMaster,ProductModelMaster,HealthStatusDetails
from django.contrib import messages
from django.contrib.auth.decorators import login_required

@login_required(login_url="user_login")
def productCategoryFilter(request):
    list_all_protype = ProductCategoryMaster.objects.filter(product_type=request.GET.get('protype'))
    return render(request,"ajaxpage/productAJX.html",{'flag':'productCategoryList','list_all_protype':list_all_protype})

@login_required(login_url="user_login")
def productCompanyFilter(request):
    list_all_com = ProductModelMaster.objects.select_related('product_com_id').filter(product_com_id__product_cat_id=request.GET.get('procat'))
    print(list_all_com.query)
    return render(request,"ajaxpage/productAJX.html",{'flag':'productCompanyList','list_all_com':list_all_com})

@login_required(login_url="user_login")
def productNameFilter(request):
    list_all_protype = ProductDetails.objects.filter(product_type=request.GET.get('productname'))
    return render(request,"ajaxpage/productAJX.html",{'flag':'productModelList','list_all_protype':list_all_protype})

@login_required(login_url="user_login")
def productCatRedirect(request):
    list_all_pc = ProductCategoryMaster.objects.all()
    return render(request,"master/product/productCategory.html",{'flag':'NEW','list_all_pc':list_all_pc})

@login_required(login_url="user_login")
def productCatSubmit(request):
    pcm = ProductCategoryMaster()
    producttype = request.POST.get('producttype')
    productcatname = request.POST.get('productcategory')
    is_exists = ProductCategoryMaster.objects.filter(product_type=producttype,product_cat_name=productcatname).exists()
    if is_exists:
        messages.info(request, 'Product Category with this Product Type is already exists.!!')
        print("RETURN FROM EXIXST")
        return redirect('/productCatRedirect')
        
    pcm.product_type = producttype
    pcm.product_cat_name = productcatname
    pcm.save()
    messages.success(request, 'Product Category SAVED Successfully...!!')
    return redirect('/productCatRedirect')
    
@login_required(login_url="user_login")
def productCatUpdateRedirect(request):
    pcid = request.GET.get('pcid')
    pcdata = ProductCategoryMaster.objects.filter(product_cat_id=pcid)
    list_all_pc = ProductCategoryMaster.objects.all()
    return render(request,"master/product/productCategory.html",{'flag':'UPDATE','pcdata':pcdata,'list_all_pc':list_all_pc})

@login_required(login_url="user_login")
def productCatUpdate(request):
    pcdata = ProductCategoryMaster.objects.get(product_cat_id=request.POST.get('pcid'))
    pcdata.product_type=request.POST.get('producttype')
    pcdata.product_com_name=request.POST.get('productcategory')
    pcdata.save()
    messages.success(request, 'Product Category UPDATED Successfully...!!')
    return redirect('/productCatRedirect')

@login_required(login_url="user_login")
def productCompanyRedirect(request):
    list_all_pc = ProductCategoryMaster.objects.all()
    list_all_pcm = ProductCompanyMaster.objects.all()
    return render(request,"master/product/productCompany.html",{'flag':'NEW','list_all_pc':list_all_pc,'list_all_pcm':list_all_pcm})

@login_required(login_url="user_login")
def productCompanySubmit(request):
    pcn = ProductCompanyMaster()
    productcat = ProductCategoryMaster.objects.get(product_cat_id=request.POST.get('productcat'))
    productcomname = request.POST.get('companyname')
    is_exists = ProductCompanyMaster.objects.filter(product_cat_id=productcat,product_com_name=productcomname).exists()
    if is_exists:
        messages.info(request, 'Product Company Name given details is already exists.!!')
        print("RETURN FROM EXIXST")
        return redirect('/productCompanyRedirect')
        
    pcn.product_cat_id = productcat
    pcn.product_com_name = productcomname
    pcn.save()
    messages.success(request, 'Product Company Name SAVED Successfully...!!')
    return redirect('/productCompanyRedirect')

@login_required(login_url="user_login")
def productCompanyUpdateRedirect(request):
    list_all_pc = ProductCategoryMaster.objects.all()
    list_all_pcm = ProductCompanyMaster.objects.all()
    pcdata = ProductCompanyMaster.objects.filter(product_com_id=request.GET.get('pcid'))
    return render(request,"master/product/productCompany.html",{'flag':'UPDATE','pcdata':pcdata,'list_all_pc':list_all_pc,'list_all_pcm':list_all_pcm})
    
@login_required(login_url="user_login")
def productCompanyUpdate(request):
    pcdata = ProductCompanyMaster.objects.get(product_com_id=request.POST.get('pcid'))
    pcdata.product_cat_id= ProductCategoryMaster.objects.get(product_cat_id=request.POST.get('productcat'))
    pcdata.product_com_name=request.POST.get('companyname')
    pcdata.save()
    messages.success(request, 'Product Company Name UPDATED Successfully...!!')
    return redirect('/productCompanyRedirect')

@login_required(login_url="user_login")
def productModelRedirect(request):
    # list_all_pcm = ProductCompanyMaster.objects.select_related('product_cat_id').filter(product_cat_id__product_type="Non-Consumable")
    list_all_pcm = ProductCompanyMaster.objects.select_related('product_cat_id')
    list_all_pmn = ProductModelMaster.objects.all()
    return render(request,"master/product/productModel.html",{'flag':'NEW','list_all_pcm':list_all_pcm,'list_all_pmn':list_all_pmn})

@login_required(login_url="user_login")
def productModelSubmit(request):
    pcm = ProductModelMaster()
    productcomname = ProductCompanyMaster.objects.get(product_com_id=request.POST.get('productcomname'))
    productmodel = request.POST.get('productmodel')
    is_exists = ProductModelMaster.objects.filter(product_com_id=productcomname,product_mod_name=productmodel).exists()
    if is_exists:
        messages.info(request, 'Product Model Name given details is already exists.!!')
        print("RETURN FROM EXIXST")
        return redirect('/productModelRedirect')
        
    pcm.product_com_id = productcomname
    pcm.product_mod_name = productmodel
    pcm.save()
    messages.success(request, 'Product Model Name SAVED Successfully...!!')
    return redirect('/productModelRedirect')

@login_required(login_url="user_login")
def productModelUpdateRedirect(request):
    list_all_pcm = ProductCompanyMaster.objects.select_related('product_cat_id').filter(product_cat_id__product_type="Non-Consumable")
    list_all_pmn = ProductModelMaster.objects.all()
    pcdata = ProductModelMaster.objects.filter(product_mod_id=request.GET.get('pmid'))
    return render(request,"master/product/productModel.html",{'flag':'UPDATE','pcdata':pcdata,'list_all_pcm':list_all_pcm,'list_all_pmn':list_all_pmn})

@login_required(login_url="user_login")
def productModelUpdate(request):
    pcdata = ProductModelMaster.objects.get(product_mod_id=request.POST.get('pmid'))
    pcdata.product_com_id= ProductCompanyMaster.objects.get(product_com_id=request.POST.get('productcomname'))
    pcdata.product_mod_name=request.POST.get('productmodel')
    pcdata.save()
    messages.success(request, 'Product Model Name UPDATED Successfully...!!')
    return redirect('/productModelRedirect')

@login_required(login_url="user_login")
def productDetails(request):
    list_all_pd = ProductDetails.objects.all()
    list_all_pc = ProductCategoryMaster.objects.all()
    return render(request,"master/product/productDetails.html",{'list_all_pd':list_all_pd,'list_all_pc':list_all_pc})


@login_required(login_url="user_login")
def productDetailsSubmit(request):
    pd = ProductDetails()
    productcat = ProductCategoryMaster.objects.get(product_cat_id=request.POST.get('producttype'))
    productmodel = ProductModelMaster.objects.get(product_mod_id=request.POST.get('modelname'))
    productcmpy = ProductCompanyMaster.objects.get(product_com_id=productmodel.product_com_id.product_com_id) 
    serialno = request.POST.get('serialno')
    quantity = request.POST.get('quantity')
    toner = request.POST.get('toner')
    remarks = request.POST.get('remarks')
    productnew = request.POST.get('productnew')

    is_exists = ProductDetails.objects.filter(product_cat_id=productcat,product_name=productcmpy,product_model=productmodel,product_serialno=serialno).exists()
    if is_exists:
        messages.info(request, 'Product Detail with Given Details is already exists.!!')
        print("RETURN FROM EXIXST")
        return redirect('/productDetails')        
    pd.product_cat_id = productcat
    pd.product_name = productcmpy
    pd.product_model = productmodel
    pd.product_serialno = serialno
    pd.initial_quantity = quantity
    pd.current_quantity = quantity
    pd.cartridge_toner = toner
    pd.remarks = remarks
    pd.product_new_or_open=productnew
    pd.save()
    #Inserting New Health Status of Product
    hs = HealthStatusDetails()
    hs.product_id = ProductDetails.objects.get(product_id=(ProductDetails.objects.last()).product_id)
    hs.save()  
    messages.success(request, 'Product Detail SAVED Successfully...!!')
    return redirect('/productDetails')


@login_required(login_url="user_login")
def productDetailsUpdateRedirect(request):
    pddata = ProductDetails.objects.filter(product_id=request.GET.get('pdid'))
    list_all_pd = ProductDetails.objects.all()
    list_all_pc = ProductCategoryMaster.objects.all()
    return render(request,"master/product/productDetails.html",{'flag':'UPDATE','pddata':pddata,'list_all_pd':list_all_pd,'list_all_pc':list_all_pc})

@login_required(login_url="user_login")
def productDetailsUpdate(request):
    pd = ProductDetails.objects.get(product_id=request.POST.get('pdid'))
    pd.product_cat_id = ProductCategoryMaster.objects.get(product_cat_id=request.POST.get('producttype'))
    print("pd.product_cat_id ---------- ",pd.product_cat_id)
    pd.product_model = ProductModelMaster.objects.get(product_mod_id=request.POST.get('modelname'))
    pd.product_name = ProductCompanyMaster.objects.get(product_com_id=pd.product_model.product_com_id.product_com_id) 
    pd.product_serialno = request.POST.get('serialno')
    pd.current_quantity = request.POST.get('quantity')
    print("request.POST.get('quantity') ==== ",request.POST.get('quantity'))
    pd.cartridge_toner = request.POST.get('toner')
    pd.remarks = request.POST.get('remarks')
    pd.product_new_or_open = request.POST.get('productnew')
    pd.save()
    messages.success(request, 'Product Details UPDATED Successfully...!!')
    return redirect('/productDetails')