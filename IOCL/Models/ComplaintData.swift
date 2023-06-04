//
//  ComplaintData.swift
//  IOCL
//
//  Created by InfoneoMacMini on 23/01/23.
//

import Foundation

struct ComplaintData {
    
    var COMP_ID, RowNum, EMPNO, COMP_CODE, TOWNSHIP_CODE, COMPLAINT_CATEGORY_ID, COMPLAINT_STATUS_ID, VENDOR_SERNO  : Int?
    var GRADE,FEEDBACK_TEXT ,FEEDBACK_CODE , DESIGNATION, DEPT_CODE, UPDATED_ON, COMP_DESC, OFFICE_LOCATION, EmployeeName ,QTR_NO ,REMARKS , Vendor_Name: String?
    var MA_COMPLAINT_CATEGORY : ComplaintCategoryData?
    var MA_COMPLAINT_STATUS : ComplaintStatusData?
    
    init(_ data : [String : Any]) {
        if let COMP_ID = data["COMP_ID"] as? Int {
            self.COMP_ID = COMP_ID
        }
        if let RowNum = data["RowNum"] as? Int {
            self.RowNum = RowNum
        }
        if let Vendor_Name = data["Vendor_Name"] as? String {
            self.Vendor_Name = Vendor_Name
        }
        if let REMARKS = data["REMARKS"] as? String {
            self.REMARKS = REMARKS
        }
        if let QTR_NO = data["QTR_NO"] as? String {
            self.QTR_NO = QTR_NO
        }
        if let EMPNO = data["EMPNO"] as? Int {
            self.EMPNO = EMPNO
        }
        if let COMP_CODE = data["COMP_CODE"] as? Int {
            self.COMP_CODE = COMP_CODE
        }
        if let TOWNSHIP_CODE = data["TOWNSHIP_CODE"] as? Int {
            self.TOWNSHIP_CODE = TOWNSHIP_CODE
        }
        if let COMPLAINT_CATEGORY_ID = data["COMPLAINT_CATEGORY_ID"] as? Int {
            self.COMPLAINT_CATEGORY_ID = COMPLAINT_CATEGORY_ID
        }
        if let VENDOR_SERNO = data["VENDOR_SERNO"] as? Int {
            self.VENDOR_SERNO = VENDOR_SERNO
        }
        if let GRADE = data["GRADE"] as? String {
            self.GRADE = GRADE
        }
        if let DESIGNATION = data["DESIGNATION"] as? String {
            self.DESIGNATION = DESIGNATION
        }
        if let FEEDBACK_TEXT = data["FEEDBACK_TEXT"] as? String {
            self.FEEDBACK_TEXT = FEEDBACK_TEXT
        }
        
        if let FEEDBACK_CODE = data["FEEDBACK_CODE"] as? String {
            self.FEEDBACK_CODE = FEEDBACK_CODE
        }
        if let DEPT_CODE = data["DEPT_CODE"] as? String {
            self.DEPT_CODE = DEPT_CODE
        }
        if let UPDATED_ON = data["UPDATED_ON"] as? String {
            self.UPDATED_ON = UPDATED_ON
        }
        if let COMP_DESC = data["COMP_DESC"] as? String {
            self.COMP_DESC = COMP_DESC
        }
        if let OFFICE_LOCATION = data["OFFICE_LOCATION"] as? String {
            self.OFFICE_LOCATION = OFFICE_LOCATION
        }
        if let EmployeeName = data["EmployeeName"] as? String {
            self.EmployeeName = EmployeeName
        }
        if let MA_COMPLAINT_CATEGORY = data["MA_COMPLAINT_CATEGORY"] as? [String: Any] {
            let obj = ComplaintCategoryData(MA_COMPLAINT_CATEGORY)
            self.MA_COMPLAINT_CATEGORY = obj
        }
        if let MA_COMPLAINT_STATUS = data["MA_COMPLAINT_STATUS"] as? [String: Any] {
            let obj1 = ComplaintStatusData(MA_COMPLAINT_STATUS)
            self.MA_COMPLAINT_STATUS = obj1
        }
    }
}

struct ComplaintCategoryData {
    var DEPT_CODE, COMPLAINT_CATEGORY, COMPLAINT_SUB_CATEGORY, COMPLAINT_SUB_SUB_CATEGORY : String?
    var CATEGORY_ID : Int?
    
    init(_ data : [String : Any]) {
        
        if let CATEGORY_ID = data["CATEGORY_ID"] as? Int {
            self.CATEGORY_ID = CATEGORY_ID
        }
        
        if let DEPT_CODE = data["DEPT_CODE"] as? String {
            self.DEPT_CODE = DEPT_CODE
        }
        if let COMPLAINT_CATEGORY = data["COMPLAINT_CATEGORY"] as? String {
            self.COMPLAINT_CATEGORY = COMPLAINT_CATEGORY
        }
        if let COMPLAINT_SUB_CATEGORY = data["COMPLAINT_SUB_CATEGORY"] as? String {
            self.COMPLAINT_SUB_CATEGORY = COMPLAINT_SUB_CATEGORY
        }
        if let COMPLAINT_SUB_SUB_CATEGORY = data["COMPLAINT_SUB_SUB_CATEGORY"] as? String {
            self.COMPLAINT_SUB_SUB_CATEGORY = COMPLAINT_SUB_SUB_CATEGORY
        }
       
    }
}
struct ComplaintStatusData {
    var COMPLAINT_STATUS : String?
    
    init(_ data : [String : Any]) {
        if let COMPLAINT_STATUS = data["COMPLAINT_STATUS"] as? String {
            self.COMPLAINT_STATUS = COMPLAINT_STATUS
        }
    }
}


