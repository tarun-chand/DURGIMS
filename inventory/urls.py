from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from . import views
from . import product_view
from . import user_view
from . import location_view
from . import report_view
from . import purchase_view

import re  as r

urlpatterns = [
    path('', views.index, name='index'),
    path('home', views.home, name='home'),
    path('user_login', views.user_login, name='user_login'),
    path('user_logout', views.user_logout, name='user_logout'),
    path('theDashboard', views.theDashboard, name='theDashboard'),
    
    
    path(r'dashboardOperational', views.dashboardOperational, name='dashboardOperational'),
    
    path('productCategoryFilter', product_view.productCategoryFilter, name='productCategoryFilter'),
    path('productNameFilter', product_view.productNameFilter, name='productNameFilter'),
    path('productCompanyFilter', product_view.productCompanyFilter, name='productCompanyFilter'),

    path('productCatRedirect', product_view.productCatRedirect, name='productCatRedirect'),
    path('productCatSubmit', product_view.productCatSubmit, name='productCatSubmit'),
    path('productCatUpdateRedirect', product_view.productCatUpdateRedirect, name='productCatUpdateRedirect'),
    path('productCatUpdate', product_view.productCatUpdate, name='productCatUpdate'),

    path('productCompanyRedirect', product_view.productCompanyRedirect, name='productCompanyRedirect'),
    path('productCompanySubmit', product_view.productCompanySubmit, name='productCompanySubmit'),
    path('productCompanyUpdateRedirect', product_view.productCompanyUpdateRedirect, name='productCompanyUpdateRedirect'),
    path('productCompanyUpdate', product_view.productCompanyUpdate, name='productCompanyUpdate'),

    path('productModelRedirect', product_view.productModelRedirect, name='productModelRedirect'),
    path('productModelSubmit', product_view.productModelSubmit, name='productModelSubmit'),
    path('productModelUpdateRedirect', product_view.productModelUpdateRedirect, name='productModelUpdateRedirect'),
    path('productModelUpdate', product_view.productModelUpdate, name='productModelUpdate'),
    
    path('productDetails', product_view.productDetails, name='productDetails'),
    path('productDetailsSubmit', product_view.productDetailsSubmit, name='productDetailsSubmit'),
    path('productDetailsUpdateRedirect', product_view.productDetailsUpdateRedirect, name='productDetailsUpdateRedirect'),
    path('productDetailsUpdate', product_view.productDetailsUpdate, name='productDetailsUpdate'),
    
    path('userDesignationRedirect', user_view.userDesignationRedirect, name='userDesignationRedirect'),
    path('userDesignationSubmit', user_view.userDesignationSubmit, name='userDesignationSubmit'),
    path('userDesignationUpdateRedirect', user_view.userDesignationUpdateRedirect, name='userDesignationUpdateRedirect'),
    path('userDesignationUpdate', user_view.userDesignationUpdate, name='userDesignationUpdate'),

    path('userDetails', user_view.userDetails, name='userDetails'),
    path('userDesignationFilter', user_view.userDesignationFilter, name='userDesignationFilter'),
    path('userDetailsSubmit', user_view.userDetailsSubmit, name='userDetailsSubmit'),
    path('userDetailsUpdateRedirect', user_view.userDetailsUpdateRedirect, name='userDetailsUpdateRedirect'),
    path('userDetailsUpdate', user_view.userDetailsUpdate, name='userDetailsUpdate'),

    path('buildingDetailsRedirect', location_view.buildingDetailsRedirect, name='buildingDetailsRedirect'),
    path('buildingDetailsSubmit', location_view.buildingDetailsSubmit, name='buildingDetailsSubmit'),
    path('buildingDetailsUpdateRedirect', location_view.buildingDetailsUpdateRedirect, name='buildingDetailsUpdateRedirect'),
    path('buildingDetailsUpdate', location_view.buildingDetailsUpdate, name='buildingDetailsUpdate'),
  
    path('sectionRedirect', location_view.sectionRedirect, name='sectionRedirect'),
    path('sectionDetailsSubmit', location_view.sectionDetailsSubmit, name='sectionDetailsSubmit'),
    path('sectionDetailsUpdateRedirect', location_view.sectionDetailsUpdateRedirect, name='sectionDetailsUpdateRedirect'),
    path('sectionDetailsUpdate', location_view.sectionDetailsUpdate, name='sectionDetailsUpdate'),
    path('buildingFilter', location_view.buildingFilter, name='buildingFilter'),

    



    # path('locationRedirect', location_view.locationRedirect, name='locationRedirect'),
    # path('locationSectionFilter', location_view.locationSectionFilter, name='locationSectionFilter'),
    # path('locationDetailsSubmit', location_view.locationDetailsSubmit, name='locationDetailsSubmit'),
    # path('locationDetailsUpdateRedirect', location_view.locationDetailsUpdateRedirect, name='locationDetailsUpdateRedirect'),
    # path('locationDetailsUpdate', location_view.locationDetailsUpdate, name='locationDetailsUpdate'),


    path('issueRedirect', views.issueRedirect, name='issueRedirect'),
    path('issueProductCategoryFilter', views.issueProductCategoryFilter, name='issueProductCategoryFilter'),
    path('issueProductModelFilter', views.issueProductModelFilter, name='issueProductModelFilter'),
    path('issueOtherProductDetailsFilter', views.issueOtherProductDetailsFilter, name='issueOtherProductDetailsFilter'),
    path('issueSectionDetailsFilter', views.issueSectionDetailsFilter, name='issueSectionDetailsFilter'),
    path('sectionDesigDetailsFilter', views.sectionDesigDetailsFilter, name='sectionDesigDetailsFilter'),    
    path('IssueDetailsSubmit', views.IssueDetailsSubmit, name='IssueDetailsSubmit'),
    path('listAllIssueDetails', views.listAllIssueDetails, name='listAllIssueDetails'), 
    path('issueReceiptPage', views.issueReceiptPage, name='issueReceiptPage'), 
    path('issueReceiptPageById', views.issueReceiptPageById, name='issueReceiptPageById'), 
    path('listIssueDetailsByDate', views.listIssueDetailsByDate, name='listIssueDetailsByDate'), 
    path('listReturnDetailsByDate', views.listReturnDetailsByDate, name='listReturnDetailsByDate'), 
    

    path('returnRedirect', views.returnRedirect, name='returnRedirect'),
    path('returnGetIssueStuff', views.returnGetIssueStuff, name='returnGetIssueStuff'),
    path('returnDetailsSubmit', views.returnDetailsSubmit, name='returnDetailsSubmit'),
    path('listAllReturnDetails', views.listAllReturnDetails, name='listAllReturnDetails'),
    path('healthDetailsRedirect', views.healthDetailsRedirect, name='healthDetailsRedirect'),
    path('healthDetailsSearch', views.healthDetailsSearch, name='healthDetailsSearch'),


    path('AllWiseRedirect', report_view.AllWiseRedirect, name='AllWiseRedirect'),  
    path('getReportBy', report_view.getReportBy, name='getReportBy'),  
    path('getReportByRedir', report_view.getReportByRedir, name='getReportByRedir'),    
    path('getCourtSectionSummaryData', report_view.getCourtSectionSummaryData, name='getCourtSectionSummaryData'),          
    path('productWiseReportSubmit', report_view.productWiseReportSubmit, name='productWiseReportSubmit'),
    path('AllWiseReport', report_view.AllWiseReport, name='AllWiseReport'),
    path('byFilterRedirect', report_view.byFilterRedirect, name='byFilterRedirect'),
    path(r'productWiseReportRedirect', report_view.productWiseReportRedirect, name='productWiseReportRedirect'),
    path('reportFilter', report_view.reportFilter, name='reportFilter'),

    path(r'getProductModels', report_view.getProductModels, name='getProductModels'),
    path('getCourtSectionWiseData', report_view.getCourtSectionWiseData, name='getCourtSectionWiseData'),
    
    path('transferRedirect', views.transferRedirect, name='transferRedirect'),
    path('transferGetIssueStuff', views.transferGetIssueStuff, name='transferGetIssueStuff'),
    path('transferDetailsSubmit', views.transferDetailsSubmit, name='transferDetailsSubmit'),
    
    path('replaceRedirect', views.replaceRedirect, name='replaceRedirect'),    
    path('getAllIssuedStuffOfUser', views.getAllIssuedStuffOfUser, name='getAllIssuedStuffOfUser'),
    path('getAllReplaceListStuff', views.getAllReplaceListStuff, name='getAllReplaceListStuff'),  
    path('replaceDetailsSubmit', views.replaceDetailsSubmit, name='replaceDetailsSubmit'), 
    path('sectionDesigMapRedirect', views.sectionDesigMapRedirect, name='sectionDesigMapRedirect'), 
    path('shiftAssetChargeRedirect', views.shiftAssetChargeRedirect, name='shiftAssetChargeRedirect'),    
    path('shiftAssetChargeSubmit', views.shiftAssetChargeSubmit, name='shiftAssetChargeSubmit'),         
    path('DesigEmpMapRedirect', views.DesigEmpMapRedirect, name='DesigEmpMapRedirect'),                 

    path('IntSectionDesigMapRedirect', views.IntSectionDesigMapRedirect, name='IntSectionDesigMapRedirect'),     
    path('IntSectionDesigMapSubmit', views.IntSectionDesigMapSubmit, name='IntSectionDesigMapSubmit'), 
    path('assignSectionDesigMap', views.assignSectionDesigMap, name='assignSectionDesigMap'),

    path('newPuchaseRedirect', purchase_view.newPuchaseRedirect, name='newPuchaseRedirect'),   
    path('documentUpload', purchase_view.documentUpload, name='documentUpload'),         
    path('newPuchaseSubmit', purchase_view.newPuchaseSubmit, name='newPuchaseSubmit'), 
    path('editPuchaseRedirect', purchase_view.editPuchaseRedirect, name='editPuchaseRedirect'), 
    
    path('healthDetailsUpdateRedirect', views.healthDetailsUpdateRedirect, name='healthDetailsUpdateRedirect'), 
    path('healthDetailsUpdate', views.healthDetailsUpdate, name='healthDetailsUpdate'), 
    
    path('uploadPawatiRedirect', views.uploadPawatiRedirect, name='uploadPawatiRedirect'), 
    
    path('getAllUserDesList', views.getAllUserDesList, name='getAllUserDesList'), 
    path('uploadPawatiSubmit', views.uploadPawatiSubmit, name='uploadPawatiSubmit'), 

     

    path('getCourtSectionList', views.getCourtSectionList, name='getCourtSectionList'),   
    path('getUsersWiseData', report_view.getUsersWiseData, name='getUsersWiseData'), 
    path('checkIPRedirect', report_view.checkIPRedirect, name='checkIPRedirect'),
    path('checkIP', report_view.checkIP, name='checkIP'),
    path('getProductList', report_view.getProductList, name='getProductList'),         
    path('getProductList', views.getProductList, name='getProductList'),   
    path('getAllDesignationOfSection', views.getAllDesignationOfSection, name='getAllDesignationOfSection'),   
    path('showAllDesignation', views.showAllDesignation, name='showAllDesignation'),
    path('getDesignationOfSection', views.getDesignationOfSection, name='getDesignationOfSection'),   
    path('SDMSubmit', views.SDMSubmit, name='SDMSubmit'),   
    path('DEMSubmit', views.DEMSubmit, name='DEMSubmit'),
    path('ReDesigEmpMapRedirect', views.ReDesigEmpMapRedirect, name='ReDesigEmpMapRedirect'),
    path('getAllDesignationRemap', views.getAllDesignationRemap, name='getAllDesignationRemap'),
    path('getCourtWiseUSer', views.getCourtWiseUSer, name='getCourtWiseUSer'),    
    path('getSelectedSectionDesignationRemap', views.getSelectedSectionDesignationRemap, name='getSelectedSectionDesignationRemap'),
    path('ReDEMSubmit', views.ReDEMSubmit, name='ReDEMSubmit'),

    path('editIPRedirect', views.editIPRedirect, name='editIPRedirect'),
    path('ipAddrSubmit', views.ipAddrSubmit, name='ipAddrSubmit'),
    
    
    path('udashboard', report_view.userWiseDataRedirect, name='userWiseDataRedirect'),
    path('getCourtSectionUserWiseData', report_view.getCourtSectionUserWiseData, name='getCourtSectionUserWiseData'),    
    
    
    

    
    
    

    

       

      
]
if settings.DEBUG:
  urlpatterns+=static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)
