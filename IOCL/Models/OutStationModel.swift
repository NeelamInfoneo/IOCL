//
//  OutStationModel.swift
//  IOCL
//
//  Created by neelam  on 17/02/23.
//

import Foundation

struct OutStationListingModel {
var  RowNum, COMPANY_CODE , ADMIN_RES_EMPNO : Int?
    var OUTSTATION_NO,LEAVE_TYPE ,FROM_DATE , FROM_TIME , FROM_AMPM, TO_DATE, TO_TIME, TO_AMPM, DESTINATION,PURPOSE,RESPONSIBILITY,APP_STATUS,APPROVER , JOB_IC_1, JOB_IC_2, JOB_IC_3 ,JOB_IC_4, DISASTER_CO ,EMPNO, APP_REMARKS, EmployeeName , ApproverName , ADMIN_RES_NAME , JOB_IC_1_Name, JOB_IC_2_Name , JOB_IC_3_Name , JOB_IC_4_Name , JOB_IC_1_EMPNO , JOB_IC_2_EMPNO , JOB_IC_3_EMPNO , JOB_IC_4_EMPNO , REMARKS  : String?
  

init(_ data : [String : Any]) {
    if let RowNum = data["RowNum"] as? Int {
        self.RowNum = RowNum
    }
    
    if let EMPNO = data["EMPNO"] as? String {
        self.EMPNO = EMPNO
    }
    
    if let ADMIN_RES_NAME = data["ADMIN_RES_NAME"] as? String {
        self.ADMIN_RES_NAME = ADMIN_RES_NAME
    }
    
    if let REMARKS = data["REMARKS"] as? String {
        self.REMARKS = REMARKS
    }
    
    if let JOB_IC_1_EMPNO = data["JOB_IC_1_EMPNO"] as? String {
        self.JOB_IC_1_EMPNO = JOB_IC_1_EMPNO
    }
    
    if let JOB_IC_2_EMPNO = data["JOB_IC_2_EMPNO"] as? String {
        self.JOB_IC_2_EMPNO = JOB_IC_2_EMPNO
    }
    if let JOB_IC_3_EMPNO = data["JOB_IC_3_EMPNO"] as? String {
        self.JOB_IC_3_EMPNO = JOB_IC_3_EMPNO
    }
    if let JOB_IC_4_EMPNO = data["JOB_IC_4_EMPNO"] as? String {
        self.JOB_IC_4_EMPNO = JOB_IC_4_EMPNO
    }
    
    if let ADMIN_RES_EMPNO = data["ADMIN_RES_EMPNO"] as? Int {
        self.ADMIN_RES_EMPNO = ADMIN_RES_EMPNO
    }
    
    if let ApproverName = data["ApproverName"] as? String {
        self.ApproverName = ApproverName
    }
    
    if let JOB_IC_1_EMPNO = data["JOB_IC_1_EMPNO"] as? String {
        self.JOB_IC_1_EMPNO = JOB_IC_1_EMPNO
    }
    
    if let COMPANY_CODE = data["COMPANY_CODE"] as? Int {
        self.COMPANY_CODE = COMPANY_CODE
    }
    if let JOB_IC_1_Name = data["JOB_IC_1_Name"] as? String {
        self.JOB_IC_1_Name = JOB_IC_1_Name
    }
    if let JOB_IC_2_Name = data["JOB_IC_2_Name"] as? String {
        self.JOB_IC_2_Name = JOB_IC_2_Name
    }
    if let JOB_IC_3_Name = data["JOB_IC_3_Name"] as? String {
        self.JOB_IC_3_Name = JOB_IC_3_Name
    }
    if let JOB_IC_4_Name = data["JOB_IC_4_Name"] as? String {
        self.JOB_IC_4_Name = JOB_IC_4_Name
    }
    
    if let APP_REMARKS = data["APP_REMARKS"] as? String {
        self.APP_REMARKS = APP_REMARKS
    }
    if let APPROVER = data["APPROVER"] as? String {
        self.APPROVER = APPROVER
    }
    if let OUTSTATION_NO = data["OUTSTATION_NO"] as? String {
        self.OUTSTATION_NO = OUTSTATION_NO
    }
    if let LEAVE_TYPE = data["LEAVE_TYPE"] as? String {
        self.LEAVE_TYPE = LEAVE_TYPE
    }
    if let FROM_DATE = data["FROM_DATE"] as? String {
        self.FROM_DATE = FROM_DATE
    }
    if let DISASTER_CO = data["DISASTER_CO"] as? String {
        self.DISASTER_CO = DISASTER_CO
    }
    if let FROM_TIME = data["FROM_TIME"] as? String {
        self.FROM_TIME = FROM_TIME
    }
    if let FROM_AMPM = data["FROM_AMPM"] as? String {
        self.FROM_AMPM = FROM_AMPM
    }
    
    if let TO_DATE = data["TO_DATE"] as? String {
        self.TO_DATE = TO_DATE
    }
    
    if let TO_DATE = data["TO_DATE"] as? String {
        self.TO_DATE = TO_DATE
    }

    if let EmployeeName = data["EmployeeName"] as? String {
        self.EmployeeName = EmployeeName
    }
    if let DESTINATION = data["DESTINATION"] as? String {
        self.DESTINATION = DESTINATION
    }
    if let PURPOSE = data["PURPOSE"] as? String {
        self.PURPOSE = PURPOSE
    }
    
    if let RESPONSIBILITY = data["RESPONSIBILITY"] as? String {
        self.RESPONSIBILITY = RESPONSIBILITY
    }
    if let APP_STATUS = data["APP_STATUS"] as? String {
        self.APP_STATUS = APP_STATUS
    }
    if let JOB_IC_1 = data["JOB_IC_1"] as? String {
        self.JOB_IC_1 = JOB_IC_1
    }
    if let JOB_IC_2 = data["JOB_IC_2"] as? String {
        self.JOB_IC_2 = JOB_IC_2
    }
    if let JOB_IC_3 = data["JOB_IC_3"] as? String {
        self.JOB_IC_3 = JOB_IC_3
    }
    if let JOB_IC_4 = data["JOB_IC_4"] as? String {
        self.JOB_IC_4 = JOB_IC_4
    }
    
    
    
    
  }
}

