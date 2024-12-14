from django.shortcuts import render,redirect
from django.http import HttpResponse,JsonResponse
from .models import BuildingMaster,SectionDetails,CourtEstablishmentMaster
from django.contrib import messages
from django.core import serializers
from django.contrib.auth.decorators import login_required
import json


# Building Data Collection START ===============================================
@login_required(login_url="user_login")
def buildingDetailsRedirect(request):
    list_all_bm = BuildingMaster.objects.all()
    list_all_est = CourtEstablishmentMaster.objects.all()
    return render(request,"master/location/buildingDetails.html",{'flag':'NEW','list_all_bm':list_all_bm,'list_all_est':list_all_est})

@login_required(login_url="user_login")
def buildingDetailsSubmit(request):
    bm = BuildingMaster()
    est = CourtEstablishmentMaster.objects.get(est_id=request.POST.get('est_id'))
    buildingname = request.POST.get('buildingname')
    is_exists = BuildingMaster.objects.filter(building_name=buildingname,est=est).exists()
    if is_exists:
        messages.info(request, 'Building Name with given Establishment  is already exists.!!')
        print("RETURN FROM EXIXST")
        return redirect('/buildingDetailsRedirect')
        # return render(request,"master/product/buildingname.html",{'list_all_bm':list_all_bm})
    bm.building_name = buildingname
    bm.est = est
    bm.save()
    messages.success(request, 'Building Name Saved Successfully...!!')
    return redirect('/buildingDetailsRedirect')
    # return render(request,"master/product/buildingname.html",{'list_all_bm':list_all_bm})

@login_required(login_url="user_login")
def buildingDetailsUpdateRedirect(request):
    bmid = request.GET.get('bmid')
    bmdata = BuildingMaster.objects.filter(building_id=bmid)
    list_all_bm = BuildingMaster.objects.all()
    list_all_est = CourtEstablishmentMaster.objects.all()
    return render(request,"master/location/buildingDetails.html",{'flag':'UPDATE','bmdata':bmdata,'list_all_bm':list_all_bm,'list_all_est':list_all_est})

@login_required(login_url="user_login")
def buildingDetailsUpdate(request):
    bmdata = BuildingMaster.objects.get(building_id=request.POST.get('bmid'))
    bmdata.est=CourtEstablishmentMaster.objects.get(est=request.POST.get('est_id'))
    bmdata.building_name=request.POST.get('buildingname')
    bmdata.save()
    messages.success(request, 'Building Name UPDATED Successfully...!!')
    return redirect('/buildingDetailsRedirect')

# Building Data Collection END ===============================================

# Section Data Collection Start ===============================================
@login_required(login_url="user_login")
def sectionRedirect(request):
    list_all_est = CourtEstablishmentMaster.objects.all()
    list_all_sc = SectionDetails.objects.all()
    return render(request,"master/location/sectionDetails.html",{'list_all_est':list_all_est,'list_all_sc':list_all_sc})
@login_required(login_url="user_login")
def sectionDetailsSubmit(request):
    sd = SectionDetails()
    building_obj = BuildingMaster.objects.get(building_id=request.POST.get('buildingname'))
    sectiontype = request.POST.get('sectiontype')
    sectionname = request.POST.get('sectionname')
    floor = request.POST.get('floor')
    room = request.POST.get('room')
    landmark = request.POST.get('landmark')
    is_exists = SectionDetails.objects.filter(building_name=building_obj,section_type=sectiontype,section_name=sectionname,floor = floor,roomno=room,landmark=landmark).exists()
    if is_exists:
        messages.info(request, 'Section Detail with this Building Name and Section Type is already exists.!!')
        return redirect('/sectionRedirect')
        
    sd.building = building_obj
    sd.section_type = sectiontype
    sd.section_name = sectionname
    sd.floor = floor
    sd.roomno = room
    sd.landmark = landmark
    sd.save()
    messages.success(request, 'Section Details SAVED Successfully...!!')
    return redirect('/sectionRedirect')
    
@login_required(login_url="user_login")
def sectionDetailsUpdateRedirect(request):
    scid = request.GET.get('scid')
    scdata = SectionDetails.objects.filter(section_id=scid)
    list_all_sc = SectionDetails.objects.all()
    list_all_bm = BuildingMaster.objects.all()
    list_all_est = CourtEstablishmentMaster.objects.all()
    return render(request,"master/location/sectionDetails.html",{'flag':'UPDATE','scdata':scdata,'list_all_bm':list_all_bm,'list_all_sc':list_all_sc,'list_all_est':list_all_est})

@login_required(login_url="user_login")
def sectionDetailsUpdate(request):
    scdata = SectionDetails.objects.get(section_id=request.POST.get('scid'))
    scdata.building=BuildingMaster.objects.get(building_id=request.POST.get('buildingname'))
    scdata.section_type=request.POST.get('sectiontype')
    scdata.section_name=request.POST.get('sectionname')
    scdata.floor=request.POST.get('floor')
    scdata.roomno=request.POST.get('room')
    scdata.landmark=request.POST.get('landmark')
    scdata.save()
    messages.success(request, 'Section Details UPDATED Successfully...!!')
    return redirect('/sectionRedirect')




@login_required(login_url="user_login")
def buildingFilter(request):
    list_all_build = BuildingMaster.objects.filter(est=request.GET.get('procat'))
    print("list_all_protype----",list_all_build)
    return render(request,"master/location/sectionListAJX.html",{'flag':'buildingFilter','list_all_build':list_all_build})


# Section Data Collection END ===============================================

# Location Data Collection Start ===============================================

# def locationRedirect(request):
#     list_all_loc = LocationDetails.objects.select_related('section_id')
#     return render(request,"master/location/locationDetails.html",{'list_all_loc':list_all_loc})
    
# def locationSectionFilter(request):
#     sectype = request.GET.get('sectype')
#     list_all_sc = SectionDetails.objects.filter(section_type=sectype)
#     return render(request,"master/location/sectionListAJX.html",{'list_all_sc':list_all_sc})

# def locationDetailsSubmit(request):
#     loc = LocationDetails()
#     # sectiontype_obj = SectionDetails.objects.get(section_id=request.POST.get('sectionname')).section_type
#     section_obj = SectionDetails.objects.get(section_id=request.POST.get('sectionname'))
#     floor = request.POST.get('floor')
#     room = request.POST.get('room')
#     landmark = request.POST.get('landmark')
#     is_exists = LocationDetails.objects.filter(section_id=section_obj,floor = floor,roomno=room,landmark=landmark).exists()
#     if is_exists:
#         messages.info(request, 'Location Detail with given Details is already exists.!!')
#         return redirect('/locationRedirect')
#     loc.section_id = section_obj
#     loc.floor = floor
#     loc.roomno = room
#     loc.landmark = landmark
#     loc.save()
#     messages.success(request, 'Location Detail SAVED Successfully...!!')
#     return redirect('/locationRedirect')

        
# def locationDetailsUpdateRedirect(request):
#     locid = request.GET.get('locid')
#     locdata = LocationDetails.objects.filter(location_id=locid)
#     list_all_loc = LocationDetails.objects.select_related('section_id')
#     return render(request,"master/location/locationDetails.html",{'flag':'UPDATE','locdata':locdata,'list_all_loc':list_all_loc})


# def locationDetailsUpdate(request):
#     locdata = LocationDetails.objects.get(location_id=request.POST.get('locid'))
#     locdata.section_id=SectionDetails.objects.get(section_id=request.POST.get('sectionname'))
#     locdata.floor=request.POST.get('floor')
#     locdata.roomno=request.POST.get('room')
#     locdata.landmark=request.POST.get('landmark')
#     locdata.save()
#     messages.success(request, 'Location Detail UPDATED Successfully...!!')
#     return redirect('/locationRedirect')
    
    
    

    
# Location Data Collection END ===============================================

