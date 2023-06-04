//
//  ProfileData.swift
//  IOCL
//
//  Created by InfoneoMacMini on 09/02/23.
//

import Foundation
struct ProfileData {

var EMPNO, COMP_CODE, MOBILE_NO, TOWNSHIP_CODE, INTERCOM_NO_RESIDENCE, INTERCOM_NO_OFFICE: Int?
var FIRST_NAME , LAST_NAME, GENDER, GRADE, DESIGNATION, DEPT_CODE, EMAIL, ONLY_OTP1, ONLY_OTP2 , QTR_NO , OFFICE_LOCATION   : String?


init(_ data : [String : Any]) {
    if let EMPNO = data["EMPNO"] as? Int {
        self.EMPNO = EMPNO
    }
    if let COMP_CODE = data["COMP_CODE"] as? Int {
        self.COMP_CODE = COMP_CODE
    }
    if let MOBILE_NO = data["MOBILE_NO"] as? Int {
        self.MOBILE_NO = MOBILE_NO
    }
    if let TOWNSHIP_CODE = data["TOWNSHIP_CODE"] as? Int {
        self.TOWNSHIP_CODE = TOWNSHIP_CODE
    }
    if let INTERCOM_NO_RESIDENCE = data["INTERCOM_NO_RESIDENCE"] as? Int {
        self.INTERCOM_NO_RESIDENCE = INTERCOM_NO_RESIDENCE
    }
    if let INTERCOM_NO_OFFICE = data["INTERCOM_NO_OFFICE"] as? Int {
        self.INTERCOM_NO_OFFICE = INTERCOM_NO_OFFICE
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
    if let GENDER = data["GENDER"] as? String {
        self.GENDER = GENDER
    }
    if let DESIGNATION = data["DESIGNATION"] as? String {
        self.DESIGNATION = DESIGNATION
    }
    if let DEPT_CODE = data["DEPT_CODE"] as? String {
        self.DEPT_CODE = DEPT_CODE
    }
    
    if let EMAIL = data["EMAIL"] as? String {
        self.EMAIL = EMAIL
    }
    if let ONLY_OTP1 = data["ONLY_OTP1"] as? String {
        self.ONLY_OTP1 = ONLY_OTP1
    }
    if let ONLY_OTP2 = data["ONLY_OTP2"] as? String {
        self.ONLY_OTP2 = ONLY_OTP2
    }
    if let QTR_NO = data["QTR_NO"] as? String {
        self.QTR_NO = QTR_NO
    }
    if let OFFICE_LOCATION = data["OFFICE_LOCATION"] as? String {
        self.OFFICE_LOCATION = OFFICE_LOCATION
    }
 
}
}
