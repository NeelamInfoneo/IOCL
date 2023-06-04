////
////  AlamofierClass.swift
////  AnimalHusbandry
////
////  Created by InfoneoMacMini on 26/04/22.
////
//
//import Foundation
//import Alamofire
//class NetworkManager {
//       static let sharedInstance = NetworkManager()
//
//       let manager: Alamofire.SessionManager = {
//           let serverTrustPolicies: [String: ServerTrustPolicy] = [
//               "https://dtu.infoneotech.com": .pinCertificates(
//                   certificates: ServerTrustPolicy.certificates(),
//                   validateCertificateChain: true,
//                   validateHost: true),
//               "dtu.infoneotech.com": .disableEvaluation
//           ]
//
//           let configuration = URLSessionConfiguration.default
//           configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//
//           return Alamofire.SessionManager(
//               configuration: configuration,
//               serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//           )
//       }()
//   }
