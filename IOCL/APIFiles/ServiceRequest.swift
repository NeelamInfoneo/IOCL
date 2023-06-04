//
//  ServiceRequest.swift
//  IOCL
//
//  Created by neelam  on 08/05/23.
//

import Foundation
import Foundation
import Alamofire
import SwiftyJSON
import KRProgressHUD

class ServiceRequest {
    
    static let shared = ServiceRequest()
    
    var alertShowing = false
    typealias ServiceResponse = (JSON?, Error?) -> Void
    typealias ServiceResponseJson = ([String:Any]?, Error?) -> Void
    typealias ServiceResponseData = (Data?, Error?) -> Void
    typealias SuccessFailureResonse = (Bool, String?) -> Void
}


extension ServiceRequest {
    
    func GetPromotionalOffersApI(
        _ param: [String: Any]?,
        completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "https://chat.infoneotech.com\(GetPromotionalOffers)",
            headers: CommonUtilities.shared.bearerHeaders,
            parameters: nil
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    
    
    func GetLogin(
        _ param: [String: Any]?,
        completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(UserLogin)" ,
            headers: nil,
            parameters: param
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    
    func GetOTPVrify( _ param: [String: Any]?,
                      completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(UserLogin)" ,
            headers: nil,
            parameters: param
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    
    func GetForgoteAPi( _ param: [String: Any]?,
                      completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(ForgetPassword)" ,
            headers: nil,
            parameters: param
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    
    
    func GetTownshipsApi( _ param: [String: Any]?,
                          completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:   "\(ApiLink.HOST_URL)\(GetTownships)" ,
            headers: CommonUtilities.shared.bearerHeaders,
            parameters: nil
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    func GetProfileApi(_ param: [String: Any]?,
                       completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:   "\(ApiLink.HOST_URL)\(GetProfile)" ,
            headers: CommonUtilities.shared.bearerHeaders,
            parameters: nil
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    
    func UpdateProfileApi(
        _ param: [String: Any]?,
        completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:   "\(ApiLink.HOST_URL)\(UpdateProfile)" ,
            headers: CommonUtilities.shared.bearerHeaders,
            parameters: param
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    
    func GetCheckOutstationApprover(_ param: [String: Any]?,
                                    completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:   "\(ApiLink.HOST_URL)\(CheckOutstationApprover)" ,
            headers: CommonUtilities.shared.bearerHeaders,
            parameters: nil
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    //MARK: - ----  All GetComplaint START API CALLING FUNCTIONS ----------
    
    func GetComplaintsApi(_ param: [String: Any]?,
                          completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:   "\(ApiLink.HOST_URL)\(GetComplaints)" ,
            headers: CommonUtilities.shared.bearerHeaders,
            parameters: param
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    func GetComplaintCategoryApi( _ param: [String: Any]?,
                                  completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(GetComplaintCategory)" ,
            headers: nil ,
            parameters: nil
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    func GetComplaintSubCategoryApi(_ param: [String: Any]?,
                                    completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(GetComplaintSubCategory)",
            headers: CommonUtilities.shared.bearerHeaders ,
            parameters: param
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    
    func GetComplaintSubSubCategoryApi(_ param: [String: Any]?,
                                       completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(GetComplaintSubSubCategory)",
            headers: CommonUtilities.shared.bearerHeaders ,
            parameters: param
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    func AddComplaintApi(_ param: [String: Any]?,
                         completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(AddComplaint)",
            headers: CommonUtilities.shared.bearerHeaders ,
            parameters: param
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    
    
    
    
    
    func ComplaintFeedbackApi(_ param: [String: Any]?,
                              completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL: "\(ApiLink.HOST_URL)\(ComplaintFeedback)",
            headers: CommonUtilities.shared.bearerHeaders ,
            parameters: param
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    func GetFeedbackCodeApi(_ param: [String: Any]?,
                            completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(GetFeedbackCode)",
            headers: CommonUtilities.shared.bearerHeaders ,
            parameters:  nil
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    func UpdateAddComplaintApi(_ param: [String: Any]?,
                               completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(AddComplaint)",
            headers: CommonUtilities.shared.bearerHeaders ,
            parameters: param
            
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    //MARK: - ----  All Complaint API ENDED FUNCTIONS ----------
    
    
    //MARK: - ----  All CarRequest START API FUNCTIONS ----------
    func GetCarRequestStatusApi(_ param: [String: Any]?,
                                completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(GetCarRequestStatus)",
            headers: nil ,
            parameters: nil
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    
    func GetCarRequestsApi(_ param: [String: Any]?,
                           completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(GetCarRequests)",
            headers: CommonUtilities.shared.bearerHeaders ,
            parameters: param
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    func AddCarRequestApi(_ param: [String: Any]?,
                          completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(AddCarRequest)",
            headers: CommonUtilities.shared.bearerHeaders ,
            parameters: param
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    func GetCarRequestByIdApi(_ param: [String: Any]?,
                              completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
        ) {
            Loader.isLoader(show: true)
            APICallHandler.shared.request(
                method: .post,
                apiURL:   "\(ApiLink.HOST_URL)\(GetCarRequestById)",
                headers: CommonUtilities.shared.bearerHeaders ,
                parameters: param
            ) { (isSucess, response, error) in
                completionHandler(isSucess, response, error)
                Loader.isLoader(show: false)
            }
        }
        
    
    func UpdateCarRequestApi(_ param: [String: Any]?,
                             completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
       ) {
           Loader.isLoader(show: true)
           APICallHandler.shared.request(
               method: .post,
               apiURL:  "\(ApiLink.HOST_URL)\(UpdateCarRequest)",
               headers: CommonUtilities.shared.bearerHeaders ,
               parameters: param
           ) { (isSucess, response, error) in
               completionHandler(isSucess, response, error)
               Loader.isLoader(show: false)
           }
       }
        
        
        
  
    
    //MARK: - ----  All CarRequest API ENDED FUNCTIONS ----------
    
    
    //MARK: - ----  All OutStation START API FUNCTIONS ----------
    
    func GetOutstationApi(_ param: [String: Any]?,
                          completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(GetOutstation)",
            headers: CommonUtilities.shared.bearerHeaders ,
            parameters: param
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
    
    func OutstationLeaveTypeApi(_ param: [String: Any]?,
                          completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
    ) {
        Loader.isLoader(show: true)
        APICallHandler.shared.request(
            method: .post,
            apiURL:  "\(ApiLink.HOST_URL)\(OutstationLeaveType)",
            headers: nil ,
            parameters: nil
        ) { (isSucess, response, error) in
            completionHandler(isSucess, response, error)
            Loader.isLoader(show: false)
        }
    }
        
    func GetOutstationAdministrativeResponsibilityApi(_ param: [String: Any]?,
                                                      completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
                                ) {
                                    Loader.isLoader(show: true)
                                    APICallHandler.shared.request(
                                        method: .post,
                                        apiURL:  "\(ApiLink.HOST_URL)\(GetOutstationAdministrativeResponsibility)",
                                        headers: CommonUtilities.shared.bearerHeaders ,
                                        parameters: param
                                    ) { (isSucess, response, error) in
                                        completionHandler(isSucess, response, error)
                                        Loader.isLoader(show: false)
                                    }
                                }
        
    
    func GetOutstationApproverApi(_ param: [String: Any]?,
                                  completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
            ) {
                Loader.isLoader(show: true)
                APICallHandler.shared.request(
                    method: .post,
                    apiURL:  "\(ApiLink.HOST_URL)\(GetOutstationApprover)",
                    headers: CommonUtilities.shared.bearerHeaders ,
                    parameters: nil
                ) { (isSucess, response, error) in
                    completionHandler(isSucess, response, error)
                    Loader.isLoader(show: false)
                }
            }
        
    
    func GetOutstationJobInchargeApi(_ param: [String: Any]?,
                                     completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
               ) {
                   Loader.isLoader(show: true)
                   APICallHandler.shared.request(
                       method: .post,
                       apiURL:  "\(ApiLink.HOST_URL)\(GetOutstationJobIncharge)",
                       headers: CommonUtilities.shared.bearerHeaders ,
                       parameters: nil
                   ) { (isSucess, response, error) in
                       completionHandler(isSucess, response, error)
                       Loader.isLoader(show: false)
                   }
               }
        
        
        
      
    
    
    func  OutstationRequestPreviewApi(_ param: [String: Any]?,
                                      completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
                ) {
                    Loader.isLoader(show: true)
                    APICallHandler.shared.request(
                        method: .post,
                        apiURL:  "\(ApiLink.HOST_URL)\(OutstationRequestPreview)",
                        headers: CommonUtilities.shared.bearerHeaders ,
                        parameters: param
                    ) { (isSucess, response, error) in
                        completionHandler(isSucess, response, error)
                        Loader.isLoader(show: false)
                    }
                }
        
   
    
    
    func  AddOutstationApi(_ param: [String: Any]?,
                           completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
     ) {
         Loader.isLoader(show: true)
         APICallHandler.shared.request(
             method: .post,
             apiURL:  "\(ApiLink.HOST_URL)\(AddOutstation)",
             headers: CommonUtilities.shared.bearerHeaders ,
             parameters: param
         ) { (isSucess, response, error) in
             completionHandler(isSucess, response, error)
             Loader.isLoader(show: false)
         }
     }
        
        

    
    
    //MARK: - ----  All Outstation API ENDED FUNCTIONS ----------
    
    
    
    //MARK: - ----  Quiz API FUNCTIONS ----------
    func  GetQuizListApi(_ param: [String: Any]?,
                         completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
   ) {
       Loader.isLoader(show: true)
       APICallHandler.shared.request(
           method: .post,
           apiURL:  "\(ApiLink.HOST_URL)\(GetQuizList)",
           headers: CommonUtilities.shared.bearerHeaders ,
           parameters: nil
       ) { (isSucess, response, error) in
           completionHandler(isSucess, response, error)
           Loader.isLoader(show: false)
       }
   }
   
    
    func  GetQuizFullDetailApi(_ param: [String: Any]?,
                             completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
       ) {
           Loader.isLoader(show: true)
           APICallHandler.shared.request(
               method: .post,
               apiURL:  "\(ApiLink.HOST_URL)\(GetQuizFullDetail)",
               headers: CommonUtilities.shared.bearerHeaders ,
               parameters: param
           ) { (isSucess, response, error) in
               completionHandler(isSucess, response, error)
               Loader.isLoader(show: false)
           }
       }
       
        
        
   
    //MARK: - ----  SurveyL API FUNCTIONS ----------
    
    func  GetSurveyListApi(_ param: [String: Any]?,
                           completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
     ) {
         Loader.isLoader(show: true)
         APICallHandler.shared.request(
             method: .post,
             apiURL: "\(ApiLink.HOST_URL)\(GetSurveyList)",
             headers: CommonUtilities.shared.bearerHeaders ,
             parameters: nil
         ) { (isSucess, response, error) in
             completionHandler(isSucess, response, error)
             Loader.isLoader(show: false)
         }
     }
      
 
    
    func  ParticipateInSurveyApi(_ param: [String: Any]?,
                                 completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
           ) {
               Loader.isLoader(show: true)
               APICallHandler.shared.request(
                   method: .post,
                   apiURL: "\(ApiLink.HOST_URL)\(ParticipateInSurvey)",
                   headers: CommonUtilities.shared.bearerHeaders ,
                   parameters: param
               ) { (isSucess, response, error) in
                   completionHandler(isSucess, response, error)
                   Loader.isLoader(show: false)
               }
           }

    
    func  GetSurveyDataForAdminApi(_ param: [String: Any]?,
                                   completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
             ) {
                 Loader.isLoader(show: true)
                 APICallHandler.shared.request(
                     method: .post,
                     apiURL:  "\(ApiLink.HOST_URL)\(GetSurveyDataForAdmin)",
                     headers: CommonUtilities.shared.bearerHeaders ,
                     parameters: param
                 ) { (isSucess, response, error) in
                     completionHandler(isSucess, response, error)
                     Loader.isLoader(show: false)
                 }
             }
        
        
   
    
    //MARK: - ----  ADMIN COMPLAINT API FUNCTIONS ----------
    
    func GetAdminComplaintsApi(_ param: [String: Any]?,
                                       completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
                 ) {
                     Loader.isLoader(show: true)
                     APICallHandler.shared.request(
                         method: .post,
                         apiURL:   "\(ApiLink.HOST_URL)\(GetAdminComplaints)",
                         headers: CommonUtilities.shared.bearerHeaders ,
                         parameters: param
                     ) { (isSucess, response, error) in
                         completionHandler(isSucess, response, error)
                         Loader.isLoader(show: false)
                     }
                 }
            
   
    
    func UpdateComplaintStatusApi(_ param: [String: Any]?,
                                           completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
                     ) {
                         Loader.isLoader(show: true)
                         APICallHandler.shared.request(
                             method: .post,
                             apiURL:   "\(ApiLink.HOST_URL)\(UpdateComplaintStatus)",
                             headers: CommonUtilities.shared.bearerHeaders ,
                             parameters: param
                         ) { (isSucess, response, error) in
                             completionHandler(isSucess, response, error)
                             Loader.isLoader(show: false)
                         }
                     }
        
    
    func GetVendorMasterApi(_ param: [String: Any]?,
                            completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
      ) {
          Loader.isLoader(show: true)
          APICallHandler.shared.request(
              method: .post,
              apiURL:   "\(ApiLink.HOST_URL)\(GetVendorMaster)",
              headers: CommonUtilities.shared.bearerHeaders ,
              parameters: nil
          ) { (isSucess, response, error) in
              completionHandler(isSucess, response, error)
              Loader.isLoader(show: false)
          }
      }
        
      
    //MARK: - ----  CarRequestApproveByAdmin COMPLAINT API FUNCTIONS ----------
    
    
    
    func CarRequestApproveByAdminApi(_ param: [String: Any]?,
                                     completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
               ) {
                   Loader.isLoader(show: true)
                   APICallHandler.shared.request(
                       method: .post,
                       apiURL:  "\(ApiLink.HOST_URL)\(CarRequestApproveByAdmin)" ,
                       headers: CommonUtilities.shared.bearerHeaders ,
                       parameters: param
                   ) { (isSucess, response, error) in
                       completionHandler(isSucess, response, error)
                       Loader.isLoader(show: false)
                   }
               }

    
    func CarRequestApproveByApproverApi(_ param: [String: Any]?,
                                        completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
                  ) {
                      Loader.isLoader(show: true)
                      APICallHandler.shared.request(
                          method: .post,
                          apiURL:  "\(ApiLink.HOST_URL)\(CarRequestApproveByApprover)" ,
                          headers: CommonUtilities.shared.bearerHeaders ,
                          parameters: param
                      ) { (isSucess, response, error) in
                          completionHandler(isSucess, response, error)
                          Loader.isLoader(show: false)
                      }
                  }
        
 
    func OutstationRequestApproveByApproverApi(_ param: [String: Any]?,
                                               completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
                         ) {
                             Loader.isLoader(show: true)
                             APICallHandler.shared.request(
                                 method: .post,
                                 apiURL:  "\(ApiLink.HOST_URL)\(OutstationRequestApproveByApprover)" ,
                                 headers: CommonUtilities.shared.bearerHeaders ,
                                 parameters: param
                             ) { (isSucess, response, error) in
                                 completionHandler(isSucess, response, error)
                                 Loader.isLoader(show: false)
                             }
                         }
        
        
        

    
    func GetNotificationsApi(_ param: [String: Any]?,
                             completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
       ) {
           Loader.isLoader(show: true)
           APICallHandler.shared.request(
               method: .post,
               apiURL:  "\(ApiLink.HOST_URL)\(GetNotifications)" ,
               headers: CommonUtilities.shared.bearerHeaders ,
               parameters: nil
           ) { (isSucess, response, error) in
               completionHandler(isSucess, response, error)
               Loader.isLoader(show: false)
           }
       }
        
     
    
    
    
    
    func ChangePasswordApi(_ param: [String: Any]?,
                           completionHandler: @escaping(_ isSucess: Bool?, _ responseModel: [String: Any]?, _ errorMsg: String? )-> Void
     ) {
         Loader.isLoader(show: true)
         APICallHandler.shared.request(
             method: .post,
             apiURL:  "\(ApiLink.HOST_URL)\(GetNotifications)" ,
             headers: CommonUtilities.shared.bearerHeaders ,
             parameters: nil
         ) { (isSucess, response, error) in
             completionHandler(isSucess, response, error)
             Loader.isLoader(show: false)
         }
     }
        
    
}
