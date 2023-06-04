//
//  LoginData.swift
//  IOCL
//
//  Created by InfoneoMacMini on 19/01/23.
//

import Foundation
struct LoginData {
  
    var  COMP_CODE, TOWNSHIP_CODE, MOBILE_NO, ADDL_MOBILE_NO, INTERCOM_NO_RESIDENCE, INTERCOM_NO_OFFICE : Int?
    var EMPNO, Token, FIRST_NAME, LAST_NAME, GENDER, GRADE, DESIGNATION, DEPT_CODE,  EMAIL, ONLY_OTP1,  ADDL_MOBILE_NO_PASSWORD, ONLY_OTP2, OFFICE_LOCATION, ComplaintAdminCategory , QTR_NO : String?
    
    init(_ data : [String : Any]) {
        
        if let EMPNO = data["EMPNO"] as? String {
            self.EMPNO = EMPNO
        }
        if let ComplaintAdminCategory = data["ComplaintAdminCategory"] as? String {
            self.ComplaintAdminCategory = ComplaintAdminCategory
        }
        if let COMP_CODE = data["COMP_CODE"] as? Int {
            self.COMP_CODE = COMP_CODE
        }
        if let TOWNSHIP_CODE = data["TOWNSHIP_CODE"] as? Int {
            self.TOWNSHIP_CODE = TOWNSHIP_CODE
        }
        
        if let INTERCOM_NO_OFFICE = data["INTERCOM_NO_OFFICE"] as? Int {
            self.INTERCOM_NO_OFFICE = INTERCOM_NO_OFFICE
        }
        if let INTERCOM_NO_RESIDENCE = data["INTERCOM_NO_RESIDENCE"] as? Int {
            self.INTERCOM_NO_RESIDENCE = INTERCOM_NO_RESIDENCE
        }
        
        
        
        if let Token = data["Token"] as? String {
            self.Token = Token
        }
        if let FIRST_NAME = data["FIRST_NAME"] as? String {
            self.FIRST_NAME = FIRST_NAME
        }
        if let LAST_NAME = data["LAST_NAME"] as? String {
            self.LAST_NAME = LAST_NAME
        }
        if let GENDER = data["GENDER"] as? String {
            self.GENDER = GENDER
        }
        if let DESIGNATION = data["DESIGNATION"] as? String {
            self.DESIGNATION = DESIGNATION
        }
        if let EMAIL = data["EMAIL"] as? String {
            self.EMAIL = EMAIL
        }
        if let ONLY_OTP1 = data["ONLY_OTP1"] as? String {
            self.ONLY_OTP1 = ONLY_OTP1
        }
        if let ADDL_MOBILE_NO_PASSWORD = data["ADDL_MOBILE_NO_PASSWORD"] as? String {
            self.ADDL_MOBILE_NO_PASSWORD = ADDL_MOBILE_NO_PASSWORD
        }
        if let ONLY_OTP2 = data["ONLY_OTP2"] as? String {
            self.ONLY_OTP2 = ONLY_OTP2
        }
        if let OFFICE_LOCATION = data["OFFICE_LOCATION"] as? String {
            self.OFFICE_LOCATION = OFFICE_LOCATION
        }
        if let QTR_NO = data["QTR_NO"] as? String {
            self.QTR_NO = QTR_NO
        }
    }
    
    
}
