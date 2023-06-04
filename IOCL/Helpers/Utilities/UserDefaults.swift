//
//  UserDefaults.swift
//  IOCL
//
//  Created by infoneo on 26/12/22.
//

import Foundation
import UIKit
extension UserDefaults {
    
    enum LoginUserDefaults : String , CaseIterable {
        case EMPNO, COMP_CODE, TOWNSHIP_CODE, MOBILE_NO, ADDL_MOBILE_NO, INTERCOM_NO_RESIDENCE, INTERCOM_NO_OFFICE,Token, FIRST_NAME, LAST_NAME, GENDER, GRADE, DESIGNATION, DEPT_CODE,  EMAIL, ONLY_OTP1,  ADDL_MOBILE_NO_PASSWORD, ONLY_OTP2, OFFICE_LOCATION , QTR_NO , isLoggedIn , ComplaintAdminCategory
        
       
    }
    
    func saveString(_ value: String?, forKey: LoginUserDefaults ) {
        if let value = value {
            kUserDefaults.setValue(value, forKey: forKey.rawValue)
            Log(forKey)
        }
    }
    
    func saveBool(_ value: Bool?, forKey: LoginUserDefaults ) {
        kUserDefaults.setValue(value, forKey: forKey.rawValue)
        Log(forKey)
    }
    
    func saveInt(_ value: Int?, forKey: LoginUserDefaults ) {
        kUserDefaults.setValue(value, forKey: forKey.rawValue)
        Log(forKey)
    }
    
    func retriveString(_ key: LoginUserDefaults) -> String {
        return kUserDefaults.value(forKey: key.rawValue) as? String ?? ""
    }
    
    func retriveInt(_ key: LoginUserDefaults) -> Int {
        return kUserDefaults.value(forKey: key.rawValue) as? Int ?? 0
    }
    
    func retriveBool(_ key: LoginUserDefaults) -> Bool {
        return kUserDefaults.value(forKey: key.rawValue) as? Bool ?? false
    }
    
    func saveToDefault(_ obj: LoginData?) {

        kUserDefaults.saveInt(obj?.COMP_CODE, forKey: .COMP_CODE)
        kUserDefaults.saveInt(obj?.TOWNSHIP_CODE, forKey: .TOWNSHIP_CODE)
        kUserDefaults.saveInt(obj?.MOBILE_NO, forKey: .MOBILE_NO)
        kUserDefaults.saveInt(obj?.ADDL_MOBILE_NO, forKey: .ADDL_MOBILE_NO)
        kUserDefaults.saveInt(obj?.INTERCOM_NO_RESIDENCE, forKey: .INTERCOM_NO_RESIDENCE)
        kUserDefaults.saveInt(obj?.INTERCOM_NO_OFFICE, forKey: .INTERCOM_NO_OFFICE)
        kUserDefaults.saveString(obj?.Token, forKey: .Token)
        kUserDefaults.saveString(obj?.EMPNO, forKey: .EMPNO)
        kUserDefaults.saveString(obj?.ComplaintAdminCategory, forKey: .ComplaintAdminCategory)
        kUserDefaults.saveString(obj?.FIRST_NAME , forKey: .FIRST_NAME)
        kUserDefaults.saveString(obj?.LAST_NAME , forKey: .LAST_NAME)
        kUserDefaults.saveString(obj?.GENDER , forKey: .GENDER)
        kUserDefaults.saveString(obj?.GRADE , forKey: .GRADE)
        kUserDefaults.saveString(obj?.DESIGNATION , forKey: .DESIGNATION)
        kUserDefaults.saveString(obj?.DEPT_CODE , forKey: .DEPT_CODE)
        kUserDefaults.saveString(obj?.EMAIL , forKey: .EMAIL)
        kUserDefaults.saveString(obj?.ONLY_OTP1 , forKey: .ONLY_OTP1)
        kUserDefaults.saveString(obj?.ADDL_MOBILE_NO_PASSWORD , forKey: .ADDL_MOBILE_NO_PASSWORD)
        kUserDefaults.saveString(obj?.ONLY_OTP2 , forKey: .ONLY_OTP2)
        kUserDefaults.saveString(obj?.OFFICE_LOCATION , forKey: .OFFICE_LOCATION)
        kUserDefaults.saveString(obj?.QTR_NO , forKey: .QTR_NO)
        kUserDefaults.saveBool(true, forKey: .isLoggedIn)

    }
    
    func removeFromDefault(_ forKey: LoginUserDefaults ) {
        kUserDefaults.removeObject(forKey: forKey.rawValue)
    }
    
    func resetUserDefault(){
        LoginUserDefaults.allCases.forEach { removeObject(forKey: $0.rawValue) }
      }
}
