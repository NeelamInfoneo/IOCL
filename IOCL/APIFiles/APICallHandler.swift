//
//  ServiceRequest.swift
//  Contractor iPad
//
//  Created by Rajeev Singh on 15/12/21.
//


//This is API Handler class and this class have the main responsibility for handling all the API related to this application.

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import KRProgressHUD


class APICallHandler: NSObject {
//
//
//
    static let shared = APICallHandler()
//
    var alertShowing = false
//    typealias ServiceResponse = (JSON?, Error?) -> Void
//    typealias ServiceResponseJson = ([String:Any]?, Error?) -> Void
//    typealias ServiceResponseData = (Data?, Error?) -> Void
//    typealias SuccessFailureResonse = (Bool, String?) -> Void
//
//    func GetPromotionalOffersApI(_ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "https://chat.infoneotech.com\(GetPromotionalOffers)"
//        print(baseURLString)
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//    func GetLogin(paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(UserLogin)"
//        print(baseURLString)
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    func GetOTPVrify( paramDict:Dictionary<String, Any>,_ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(UserLogin)"
//        print(baseURLString)
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    func GetTownshipsApi( _ completion: @escaping ServiceResponseJson) -> Void{
//        var baseURLString = "\(ApiLink.HOST_URL)\(GetTownships)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//        print(headers)
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//    func GetProfileApi( _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(GetProfile)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//        print(headers)
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//    func UpdateProfileApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(UpdateProfile)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//        print(headers)
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//
//    func GetCheckOutstationApprover( _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(CheckOutstationApprover)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//        print(headers)
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//
//                    print(response)
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//
//
//
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//    //MARK: - ----  All GetComplaint START API CALLING FUNCTIONS ----------
//
//    func GetComplaintsApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(GetComplaints)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//        print(headers)
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//    func GetComplaintCategoryApi( _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =  "\(ApiLink.HOST_URL)\(GetComplaintCategory)"
//
//        print(baseURLString)
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//    func GetComplaintSubCategoryApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =  "\(ApiLink.HOST_URL)\(GetComplaintSubCategory)"
//
//        print(baseURLString)
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//    func GetComplaintSubSubCategoryApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =  "\(ApiLink.HOST_URL)\(GetComplaintSubSubCategory)"
//
//        print(baseURLString)
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//
//
//    func AddComplaintApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =  "\(ApiLink.HOST_URL)\(AddComplaint)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//    func ComplaintFeedbackApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =  "\(ApiLink.HOST_URL)\(ComplaintFeedback)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//
//
//    func GetFeedbackCodeApi( _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =  "\(ApiLink.HOST_URL)\(GetFeedbackCode)"
//
//        print(baseURLString)
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//    func UpdateAddComplaintApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =  "\(ApiLink.HOST_URL)\(AddComplaint)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//    //MARK: - ----  All Complaint API ENDED FUNCTIONS ----------
//
//
//    //MARK: - ----  All CarRequest START API FUNCTIONS ----------
//    func GetCarRequestStatusApi(  _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =  "\(ApiLink.HOST_URL)\(GetCarRequestStatus)"
//
//        print(baseURLString)
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//    func GetCarRequestsApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(GetCarRequests)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    func AddCarRequestApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(AddCarRequest)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    func GetCarRequestByIdApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(GetCarRequestById)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    func UpdateCarRequestApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(UpdateCarRequest)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//    //MARK: - ----  All CarRequest API ENDED FUNCTIONS ----------
//
//
//    //MARK: - ----  All OutStation START API FUNCTIONS ----------
//
//    func GetOutstationApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(GetOutstation)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//    func GetOutstationAdministrativeResponsibilityApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(GetOutstationAdministrativeResponsibility)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//    func GetOutstationApproverApi(_ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(GetOutstationApprover)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//
//    func GetOutstationJobInchargeApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(GetOutstationJobIncharge)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    func  OutstationRequestPreviewApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(OutstationRequestPreview)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    func  AddOutstationApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(AddOutstation)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//    //MARK: - ----  All Outstation API ENDED FUNCTIONS ----------
//
//
//
//    //MARK: - ----  Quiz API FUNCTIONS ----------
//    func  GetQuizListApi(_ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(GetQuizList)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//    func  GetQuizFullDetailApi(paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(GetQuizFullDetail)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//    //MARK: - ----  SurveyL API FUNCTIONS ----------
//
//    func  GetSurveyListApi(_ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(GetSurveyList)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    func  ParticipateInSurveyApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(ParticipateInSurvey)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//
//
//    func  GetSurveyDataForAdminApi(  paramDict:Dictionary<String, Any>, _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString =    "\(ApiLink.HOST_URL)\(GetSurveyDataForAdmin)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    //MARK: - ----  ADMIN COMPLAINT API FUNCTIONS ----------
//
//    func GetAdminComplaintsApi( paramDict:Dictionary<String, Any>,  _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(GetAdminComplaints)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    func UpdateComplaintStatusApi( paramDict:Dictionary<String, Any>,  _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(UpdateComplaintStatus)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//    func GetVendorMasterApi( _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(GetVendorMaster)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//    //MARK: - ----  CarRequestApproveByAdmin COMPLAINT API FUNCTIONS ----------
//
//
//
//    func CarRequestApproveByAdminApi(  paramDict:Dictionary<String, Any>,  _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(CarRequestApproveByAdmin)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//    func CarRequestApproveByApproverApi(  paramDict:Dictionary<String, Any>,  _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(CarRequestApproveByApprover)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//    func OutstationRequestApproveByApproverApi(  paramDict:Dictionary<String, Any>,  _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(OutstationRequestApproveByApprover)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: paramDict, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//    func GetNotificationsApi(  _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(GetNotifications)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
//
//
//
//    func ChangePasswordApi(  _ completion: @escaping ServiceResponseJson) -> Void{
//        let baseURLString = "\(ApiLink.HOST_URL)\(ChangePassword)"
//        print(baseURLString)
//        let Token = UserDefaults.standard.value(forKey: "Token") as? String
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic \(Token ?? "")",
//            "Accept": "application/json"
//        ]
//            AF.request(baseURLString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: { (response) in
//                guard response.error == nil, let _data = response.data else {
//                    completion( nil  ,  response.error )
//                    return
//                }
//                do {
//                    if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
//                        print("\n======================================Response JONS:======================================\n")
//                        print(responseJSON)
//                        completion(responseJSON  , nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                    completion( nil  ,  error as NSError)
//                }
//            })
//    }
//
//
}


extension APICallHandler {
  func request(
    method: HTTPMethod,
    apiURL: URLConvertible,
    headers: HTTPHeaders?,
    parameters: [String : Any]?,
    encoding: ParameterEncoding = JSONEncoding.default,
    completionHandler: @escaping (_ success: Bool?, [String: Any]?, String?) -> ()
  ) {
    guard Reachability1.isConnectedToNetwork() else {
      if !self.alertShowing {
        self.alertShowing = true
        let alert = UIAlertController(title: kNetworkProblemKey, message: kAlertNoNetworkMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: kOk, style: UIAlertAction.Style.cancel, handler: { (act) in
          self.alertShowing = false
        }))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
      }
      //completionHandler(false ,nil, nil, NSError(domain: "somedomain", code:
      completionHandler(false ,nil, kSomthingWentWrongKey)
      return
    }
    print("URL:===========> \(apiURL)")
    print("Parameter:===========> \(parameters ?? [:])")
    print("Token : \(headers)")
    AF.request(apiURL, method: method, parameters: parameters, encoding: encoding, headers: headers).response(completionHandler: { (response) in
      guard response.error == nil, let _data = response.data else {
//        completionHandler(false, nil, kSomthingWentWrongKey)
        completionHandler(false, nil, response.error!.errorDescription)
        return
      }
      do {
        if let responseJSON = try JSONSerialization.jsonObject(with: _data, options: []) as? [String : Any] {
          print("\n======================================Response JONS:======================================\n")
          print(responseJSON)
          print("\n============================================================================\n")
          if let code = responseJSON["statuscode"] as? Int {
              if code == 401{
                // log out and go login screen
                Loader.isLoader(show: false)
            
            }else {
//              let responseModel = try JSONDecoder().decode(T.self, from: _data)
              completionHandler(true, responseJSON, nil)
            }
          }
        }
      } catch let error as NSError {
        Log(error)
        completionHandler(false, nil, kSomthingWentWrongKey)
      }
    })
  }
}

struct CommonResponseModel: Decodable {
  let statuscode: Int?
  let message, status: String?
    let data : Bool?
  enum CodingKeys: String, CodingKey {
    case statuscode, message, status, data
  }
}

