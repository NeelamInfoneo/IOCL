//
//  NotificationModel.swift
//  IOCL
//
//  Created by neelam  on 05/04/23.
//



import Foundation
struct NotificationModel {
var   SenderName, SenderEmail   , MODE_TYPE ,  MESSAGE , CREATED_ON  : String?
var SenderMobileNo, ID , SenderEMPNO  : Int?
 
init(_ data : [String : Any]) {
    
    if let SenderMobileNo = data["SenderMobileNo"] as? Int {
        self.SenderMobileNo = SenderMobileNo
    }
    if let SenderEMPNO = data["SenderEMPNO"] as? Int {
        self.SenderEMPNO = SenderEMPNO
    }
    if let ID = data["ID"] as? Int {
        self.ID = ID
    }
    if let SenderEMPNO = data["SenderEMPNO"] as? Int {
        self.SenderEMPNO = SenderEMPNO
    }
    if let SenderName = data["SenderName"] as? String {
        self.SenderName = SenderName
    }
    if let SenderEmail = data["SenderEmail"] as? String {
        self.SenderEmail = SenderEmail
    }
    if let MODE_TYPE = data["MODE_TYPE"] as? String {
        self.MODE_TYPE = MODE_TYPE
    }
    if let MESSAGE = data["MESSAGE"] as? String {
        self.MESSAGE = MESSAGE
    }
    if let CREATED_ON = data["CREATED_ON"] as? String {
        self.CREATED_ON = CREATED_ON
    }
 
}
}


