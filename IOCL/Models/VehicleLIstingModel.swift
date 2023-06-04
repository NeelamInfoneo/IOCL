//
//  VehicleLIstingModel.swift
//  IOCL
//
//  Created by neelam  on 16/02/23.
//

import Foundation


struct VehicleListingModel {
    var  CM_COMPANY_CODE, CM_REQUESTID,CM_EMPNO,RowNum : Int?
    var CM_TRIP_STARTDT,CM_TRIP_ENDDT ,CM_TRIP_REASON , CM_REQUESTEDON , CM_STATUS, CM_NAME, CM_DESIGNATION, CM_GRADE, CM_TRIPTYPE , CM_INTAPPROVER_REMARKS, FEEDBACK_TEXT, FEEDBACK_CODE  : String?
    var trip_request_list : trip_request_list?
    
    init(_ data : [String : Any]) {
        if let CM_COMPANY_CODE = data["CM_COMPANY_CODE"] as? Int {
            self.CM_COMPANY_CODE = CM_COMPANY_CODE
        }
        if let CM_REQUESTID = data["CM_REQUESTID"] as? Int {
            self.CM_REQUESTID = CM_REQUESTID
        }
        
        if let RowNum = data["RowNum"] as? Int {
            self.RowNum = RowNum
        }
        
        if let CM_EMPNO = data["CM_EMPNO"] as? Int {
            self.CM_EMPNO = CM_EMPNO
        }
        if let CM_TRIPTYPE = data["CM_TRIPTYPE"] as? String {
            self.CM_TRIPTYPE = CM_TRIPTYPE
        }
        
        
        
        if let CM_INTAPPROVER_REMARKS = data["CM_INTAPPROVER_REMARKS"] as? String {
            self.CM_INTAPPROVER_REMARKS = CM_INTAPPROVER_REMARKS
        }
        
        if let CM_TRIP_STARTDT = data["CM_TRIP_STARTDT"] as? String {
            self.CM_TRIP_STARTDT = CM_TRIP_STARTDT
        }
        if let CM_TRIP_ENDDT = data["CM_TRIP_ENDDT"] as? String {
            self.CM_TRIP_ENDDT = CM_TRIP_ENDDT
        }
        if let CM_TRIP_REASON = data["CM_TRIP_REASON"] as? String {
            self.CM_TRIP_REASON = CM_TRIP_REASON
        }
        
        if let CM_STATUS = data["CM_STATUS"] as? String {
            self.CM_STATUS = CM_STATUS
        }
        
        if let CM_NAME = data["CM_NAME"] as? String {
            self.CM_NAME = CM_NAME
        }
        if let CM_GRADE = data["CM_GRADE"] as? String {
            self.CM_GRADE = CM_GRADE
        }
        if let CM_DESIGNATION = data["CM_DESIGNATION"] as? String {
            self.CM_DESIGNATION = CM_DESIGNATION
        }
    }
}

struct trip_request_list {
    var CT_DATE, CT_TIME, CT_PLACETO_REPORT, CT_PLACETO_VISIT ,  CT_VEHICLE_NAME , CT_VEHICLE_NO ,  CT_DRIVER_NAME , CT_DRIVER_CONTACTNO  : String?
    var CT_REQUESTID,CT_SERIALNO,CT_COMPANY_CODE  : Int?
    var vehicleModelAry : VehicleAdminModelData?
    
    
    
    init(_ data : [String : Any]) {
        
        if let CT_REQUESTID = data["CT_REQUESTID"] as? Int {
            self.CT_REQUESTID = CT_REQUESTID
        }
        if let CT_SERIALNO = data["CT_SERIALNO"] as? Int {
            self.CT_SERIALNO = CT_SERIALNO
        }
        if let CT_COMPANY_CODE = data["CT_COMPANY_CODE"] as? Int {
            self.CT_COMPANY_CODE = CT_COMPANY_CODE
        }
        if let CT_VEHICLE_NAME = data["CT_VEHICLE_NAME"] as? String {
            self.CT_VEHICLE_NAME = CT_VEHICLE_NAME
        }
        if let CT_VEHICLE_NO = data["CT_VEHICLE_NO"] as? String {
            self.CT_VEHICLE_NO = CT_VEHICLE_NO
        }
        if let CT_DRIVER_NAME = data["CT_DRIVER_NAME"] as? String {
            self.CT_DRIVER_NAME = CT_DRIVER_NAME
        }
        if let CT_DRIVER_CONTACTNO = data["CT_DRIVER_CONTACTNO"] as? String {
            self.CT_DRIVER_CONTACTNO = CT_DRIVER_CONTACTNO
        }
        if let CT_DATE = data["CT_DATE"] as? String {
            self.CT_DATE = CT_DATE
        }
        if let CT_TIME = data["CT_TIME"] as? String {
            self.CT_TIME = CT_TIME
        }
        if let CT_PLACETO_REPORT = data["CT_PLACETO_REPORT"] as? String {
            self.CT_PLACETO_REPORT = CT_PLACETO_REPORT
        }
        if let CT_PLACETO_VISIT = data["CT_PLACETO_VISIT"] as? String {
            self.CT_PLACETO_VISIT = CT_PLACETO_VISIT
        }
        
        let vehicleModelAry = VehicleAdminModelData()
        self.vehicleModelAry = vehicleModelAry
    }
}


struct VehicleAdminModelData {
    var CT_SERIALNO, CT_VEHICLE_NAME, CT_VEHICLE_NO,CT_DRIVER_NAME, CT_DRIVER_CONTACTNO, CT_STATUS : String?
    
   
}


