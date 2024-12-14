from django.urls import path

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
    path('issueUserDetailsFilter', views.issueUserDetailsFilter, name='issueUserDetailsFilter'),
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


    path('AllWiseRedirect', report_view.AllWiseRedirect, name='AllWiseRedirect'),
    path('AllWiseReport', report_view.AllWiseReport, name='AllWiseReport'),
    path('byFilterRedirect', report_view.byFilterRedirect, name='byFilterRedirect'),
    path(r'productWiseReportRedirect', report_view.productWiseReportRedirect, name='productWiseReportRedirect'),
    path('reportFilter', report_view.reportFilter, name='reportFilter'),

    path(r'getProductModels', report_view.getProductModels, name='getProductModels'),
    
    path('transferRedirect', views.transferRedirect, name='transferRedirect'),
    path('transferGetIssueStuff', views.transferGetIssueStuff, name='transferGetIssueStuff'),
    path('transferDetailsSubmit', views.transferDetailsSubmit, name='transferDetailsSubmit'),
    
    path('replaceRedirect', views.replaceRedirect, name='replaceRedirect'),    
    path('getAllIssuedStuffOfUser', views.getAllIssuedStuffOfUser, name='getAllIssuedStuffOfUser'),
    path('getAllReplaceListStuff', views.getAllReplaceListStuff, name='getAllReplaceListStuff'),  
    path('replaceDetailsSubmit', views.replaceDetailsSubmit, name='replaceDetailsSubmit'), 
    path('sectionDesigMapRedirect', views.sectionDesigMapRedirect, name='sectionDesigMapRedirect'), 
    path('DesigEmpMapRedirect', views.DesigEmpMapRedirect, name='DesigEmpMapRedirect'), 
    path('newPuchaseRedirect', purchase_view.newPuchaseRedirect, name='newPuchaseRedirect'),   
    path('getSerialNumber', purchase_view.getSerialNumber, name='getSerialNumber'), 
      
]
