//
//  Global.swift
//
//
//  Created by Priya Sharma on 08/09/16.
//  Copyright © 2016 Priya Sharma. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

let reachability = Reachability()
var JobSeekerValue = 2
var JobProviderValue = 3
var ServiceProviderValue = "ServiceProvider"
var AgentsValue = 6

var AppColors = UIColor(red: 246/255.0, green:
                           121.0/255.0, blue: 11.0/255.0, alpha: 1.0)
var ViewBorderLine = UIColor(red: 243/255.0, green:
                           236.0/255.0, blue: 250.0/255.0, alpha: 1.0)
var ViewBackground = UIColor(red: 61/255.0, green:
                           9.0/255.0, blue: 114.0/255.0, alpha: 1.0)

var texColor = UIColor(red: 85/255.0, green:
                        85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
var selctedBorder = UIColor(red: 216/255.0, green:
                                101.0/255.0, blue: 41.0/255.0, alpha: 1.0)

var ButtonBorder = UIColor(red: 79/255.0, green:
                        28.0/255.0, blue: 133.0/255.0, alpha: 1.0)

var greyBackground = UIColor(red: 235/255.0, green:
                        235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
let screenWidth = UIScreen.main.bounds.width
class ApiLink {

    static let HOST_URL = "https://www.refapi.in"
    static let IMAGE_BASE_URL = "https://www.refapi.in"
//
//  static let HOST_URL = "https://chat.infoneotech.com"
//   static let IMAGE_BASE_URL = "https://chat.infoneotech.com"
    static let INTERNET_ERROR_MESSAGE = "Oops! It seems you are not connected with internet. Please check your internet connection."
}

//Common Base URL constant

var GetUserDetail = "/api/GetUserDetail"
var UserLogin = "/api/UserLogin"
var RefereshToken = "/api/RefereshToken"
var ForgetPassword = "/api/ForgetPassword"
var GetComplaintStatus = "/api/GetComplaintStatus"
var GetComplaintCategory = "/api/GetComplaintCategory"
var GetComplaintSubCategory = "/api/GetComplaintSubCategory"
var GetComplaintSubSubCategory = "/api/GetComplaintSubSubCategory"
var AddComplaint = "/api/AddComplaint"
var GetComplaints = "/api/GetComplaints"
var GetAdminComplaints = "/api/GetAdminComplaints"

var AddCarRequest = "/api/AddCarRequest"
var GetProfile = "/api/GetProfile"
var UpdateProfile = "/api/UpdateProfile"
var ChangePassword = "/api/ChangePassword"
var UpdateComplaint = "/api/UpdateComplaint"
var ComplaintFeedback = "/api/ComplaintFeedback"
var GetCarRequests = "/api/GetCarRequests"
var GetCarRequestById = "/api/GetCarRequestById"
var CarRequestApproveByApprover = "/api/CarRequestApproveByApprover"
var CarRequestApproveByAdmin = "/api/CarRequestApproveByAdmin"

var AddOutstation = "/api/AddOutstation"
var GetOutstation = "/api/GetOutstation"
var OutstationLeaveType = "/api/OutstationLeaveType"
var GetCarRequestStatus = "/api/GetCarRequestStatus"
var GetQuizFullDetail = "/api/GetQuizFullDetail"
var GetOutstationAdministrativeResponsibility = "/api/GetOutstationAdministrativeResponsibility"
var GetOutstationApprover = "/api/GetOutstationApprover"
var OutstationRequestApproveByApprover = "/api/OutstationRequestApproveByApprover"
var GetQuizList = "/api/GetQuizList"
var GetOutstationJobIncharge = "/api/GetOutstationJobIncharge"
var UpdateCarRequest = "/api/UpdateCarRequest"
var GetNotifications = "/api/GetNotifications"
var GetVendorMaster = "/api/GetVendorMaster"
var UpdateComplaintStatus = "/api/UpdateComplaintStatus"
var OutstationRequestPreview = "/api/OutstationRequestPreview"
var GetFeedbackCode = "/api/GetFeedbackCode"
var GetSurveyDataForAdmin = "/api/GetSurveyDataForAdmin"
var GetSurveyList = "/api/GetSurvey"
var GetSurveyListForAdmin = "/api/GetSurveyListForAdmin"
var GetPromotionalOffers = "/api/GetPromotionalOffers"
var ParticipateInSurvey = "/api/ParticipateInSurvey"
var GetTownships = "/api/GetTownships"
var CheckOutstationApprover = "/api/CheckOutstationApprover"

@objc class Reachability: NSObject {
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags)
        {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}

public class Reachability1
{
  class func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
        SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
      }
    }
    var flags : SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
      return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
  }
}












func DLog(value: Any) {
#if DEBUG
    print(value)
#endif
}

//Common constant



func sortWithKeys(_ dict: [String: Any]) -> [String: Any] {
    let sorted = dict.sorted(by: { $0.key > $1.key })
    var newDict: [String: Any] = [:]
    for sortedDict in sorted {
        newDict[sortedDict.key] = sortedDict.value
    }
    return newDict
}


extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundedTopLeft(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }

    func roundedTopRight(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedBottomLeft(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomLeft],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedBottomRight(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomRight],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedBottom(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomRight , .bottomLeft],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedTop(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .topLeft],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedLeft(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedRight(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .bottomRight],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedAllCorner(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .bottomRight , .topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
