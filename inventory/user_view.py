from django.shortcuts import render,redirect
from django.http import HttpResponse
from .models import UserDetails,SectionDetails,staffDesignationMaster
from django.contrib import messages
from django.contrib.auth.decorators import login_required

@login_required(login_url="user_login")
def userDesignationRedirect(request):
    list_all_ud = staffDesignationMaster.objects.all()
    return render(request,"master/users/userDesignation.html",{'flag':'NEW','list_all_ud':list_all_ud})
    # return render(request,"master/users/userDesignation.html",{'flag':'NEW','list_all_ud':list_all_ud})

@login_required(login_url="user_login")
def userDesignationSubmit(request):
    udm = staffDesignationMaster()
    usrdestype = request.POST.get('usrdestype')
    usrdesname = request.POST.get('usrdesname')
    print("-------------------------------DATA----------------------",usrdestype,usrdesname)
    is_exists = staffDesignationMaster.objects.filter(staff_type=usrdestype,staff_des_name=usrdesname).exists()
    if is_exists:
        messages.info(request, 'User Designation with this User Type is already exists.!!')
        return redirect('/userDesignationRedirect')
        # return render(request,"master/product/usrdesname.html",{'list_all_ud':list_all_ud})
    udm.staff_type = usrdestype
    udm.staff_des_name = usrdesname
    udm.save() 
    messages.success(request, 'User Designation Saved Successfully. ..!!')
    return redirect('/userDesignationRedirect')
    # return render(request,"master/product/usrdesname.html",{'list_all_ud':list_all_ud})

@login_required(login_url="user_login")
def userDesignationUpdateRedirect(request):
    uddata = staffDesignationMaster.objects.filter(staff_id=request.GET.get('staff_id'))
    list_all_ud = staffDesignationMaster.objects.all()
    return render(request,"master/users/userDesignation.html",{'flag':'UPDATE','uddata':uddata,'list_all_ud':list_all_ud})

@login_required(login_url="user_login")
def userDesignationUpdate(request):
    uddata = staffDesignationMaster.objects.get(staff_id=request.POST.get('udid'))
    uddata.staff_type=request.POST.get('usrdestype')
    uddata.staff_des_name=request.POST.get('usrdesname')
    uddata.save()
    messages.success(request, 'User Designation UPDATED Successfully...!!')
    return redirect('/userDesignationRedirect')


@login_required(login_url="user_login")
def userDetails(request):
    list_of_loc = SectionDetails.objects.all()
    list_of_usr = UserDetails.objects.all()
    print("list_of_usr===========",list_of_usr.query)
    return render(request,"master/users/userDetails.html",{'list_of_usr':list_of_usr,'list_of_loc':list_of_loc})

@login_required(login_url="user_login")
def userDesignationFilter(request):
    list_all_usrdesi=staffDesignationMaster.objects.filter(staff_type=request.GET.get('usrtype'))
    print("list_all_usrdesi-------------",list_all_usrdesi)
    return render(request,"master/users/userDesigListAJX.html",{'list_all_usrdesi':list_all_usrdesi})

@login_required(login_url="user_login")
def userDetailsSubmit(request):
    ud = UserDetails()   
    usrname = request.POST.get('usrname')
    usrmobile = request.POST.get('usrmobile')
    usr_type=request.POST.get('usrtype')
    
    # usrloc =   LocationDetails.objects.get(location_id=request.POST.get('usrloc'))
    # print("USER LOCATION----------- ",usrloc)
    is_exists = UserDetails.objects.filter(usr_name=usrname,usr_mobile=usrmobile).exists()
    if is_exists:
        messages.info(request, 'User Detail with given Details is already exists.!!')
        return redirect('/userDesignationRedirect')
    ud.usr_name = usrname
    ud.usr_mobile = usrmobile
    ud.usr_type = usr_type
    # ud.location_id = usrloc
    ud.save()
    messages.success(request, 'User Details Saved Successfully...!!')
    return redirect('/userDetails')
    
@login_required(login_url="user_login")
def userDetailsUpdateRedirect(request):
    uddata = UserDetails.objects.filter(usr_id=request.GET.get('udid'))
    list_of_usr = UserDetails.objects.all()
    list_of_loc = SectionDetails.objects.all()
    return render(request,"master/users/userDetails.html",{'flag':'UPDATE','uddata':uddata,'list_of_usr':list_of_usr,'list_of_loc':list_of_loc})

@login_required(login_url="user_login")
def userDetailsUpdate(request):
    uddata = UserDetails.objects.get(usr_id=request.POST.get('udid'))    
    uddata.usr_type=request.POST.get('usrtype')
    uddata.usr_name=request.POST.get('usrname')
    uddata.usr_mobile=request.POST.get('usrmobile')
    
    # uddata.location_id=LocationDetails.objects.get(location_id=request.POST.get('usrloc'))
    uddata.save()
    messages.success(request, 'User Details UPDATED Successfully...!!')
    return redirect('/userDetails')
