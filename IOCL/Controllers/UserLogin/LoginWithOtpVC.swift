//
//  LoginWithOtpVC.swift
//  IOCL
//
//  Created by neelam  on 15/03/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class LoginWithOtpVC: UIViewController ,UITableViewDelegate, UITableViewDataSource {
       
        @IBOutlet weak var mobileNumberText: UITextField!
        @IBOutlet weak var enterpasstext : UITextField!
        @IBOutlet weak var passwordBtn: UIButton!
        @IBOutlet weak var topView: UIView!
    @IBOutlet weak var counrtyLbl: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var counrtyWidth: NSLayoutConstraint!
        var userType = Int()
        var mobileNumberValue = String()
        var loginDetailData : LoginData?
        var primaryOtpValue = String()
        var primaryMobileNoValue = Int()
        var secondaryOtpValue = String()
        var secondaryMobileNoValue = Int()
        var ProfileDetailData : ProfileData?
        //var UserType = UserDefaults.standard.value(forKey: "Usser_Type") as? Int
        //var UserType = Int()
        override func viewDidLoad() {
            super.viewDidLoad()
            print("UserType \(userType)")
            mobileNumberText.setLeftPaddingPoints(10)
            enterpasstext.setLeftPaddingPoints(10)
            mobileNumberText.delegate = self
            enterpasstext.delegate = self
            enterpasstext.isSecureTextEntry = true
            mobileNumberText.text = "9876543210"
            enterpasstext.text = "1234"
            // Do any additional setup after loading the view.
        }
        
        override func viewDidLayoutSubviews() {
               super.viewDidLayoutSubviews()
            topView.roundCorners(corners: [.topLeft, .topRight], radius: 40)
           }

        @IBAction func loginBtnAction(_ sender: UIButton) {
                    if mobileNumberText.text == "" {
                        self.createAlert(title: kAppName, message: kMobileNumber)
                    }else if enterpasstext.text == "" {
                        self.createAlert(title: kAppName, message: kEnterPassword)
                    }else {
                        //CallForGetUserDetailAPI()
                    }
        }
        
        @IBAction func passwordBtnAction(_ sender: UIButton) {
            
            passwordBtn.isSelected = !passwordBtn.isSelected
            if passwordBtn.isSelected == true {
                passwordBtn.isSelected = true
                enterpasstext.isSecureTextEntry = false
                passwordBtn.setImage(UIImage(named: "eysBlue"), for: .normal)
            }else{
                passwordBtn.isSelected = false
                enterpasstext.isSecureTextEntry = true
                enterpasstext.backgroundColor = .clear
                enterpasstext.tintColor = .white
                passwordBtn.setImage(UIImage(named: "EysClose"), for: .normal)
            }
        }
        
        @IBAction func backBtnAction(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)
        }
        //------TableView Delegate and DataSource-------//
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 0
            
        }
        
        
        
        //MARK: - API CALLING -
//        func CallForGetUserDetailAPI(){
//            KRProgressHUD.show()
//            if reachability.isConnectedToNetwork() == false{
//                KRProgressHUD.dismiss()
//                    self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
//                return
//            }
//            let url = "\(ApiLink.HOST_URL)\(GetUserDetail)"
//            var params = [String:Any]()
//
//             params = [
//                "MOBILE_NO" : mobileNumberText.text ?? "" ,
//            ]
//            print("Params \(params)")
//            NetworkManager.sharedInstance.manager.request(url, method: .post, parameters: params).responseJSON{ response in
//                KRProgressHUD.dismiss()
//                switch response.result {
//                case .success(let value):
//                    print(value)
//                    let dict = value as! [String:Any]
//                    print("JSON: \(dict)")
//                     let statuscode = dict["statuscode"] as? Int
//
//                    if (statuscode == 200){
//                        let DataDic = dict["data"] as! [String:Any]
//                        self.primaryOtpValue = DataDic["ONLY_OTP1"] as? String ?? ""
//                        self.primaryMobileNoValue = DataDic["MOBILE_NO"] as? Int ?? 0
//                        self.secondaryMobileNoValue = DataDic["ADDL_MOBILE_NO"] as? Int ?? 0
//                        self.secondaryOtpValue = DataDic["ONLY_OTP2"] as? String ?? ""
//
//
//    //                    let IsApproverAdmin = true
//    //                    UserDefaults.standard.set(IsApproverAdmin, forKey: "IsApproverAdmin")
//
//                          let IsHRSurveyAdmin = true
//                         UserDefaults.standard.set(IsHRSurveyAdmin, forKey: "IsHRSurveyAdmin")
//
//
//                        // UserDefaults.standard.set(IsCarRequestAdmin, forKey: "IsCarRequestAdmin")
//                       // UserDefaults.standard.set(IsComplaintAdmin, forKey: "IsComplaintAdmin")
//
//                        //  let IsApproverAdmin = DataDic["IsApproverAdmin"] as? Bool
//                          let IsCarRequestAdmin = DataDic["IsCarRequestAdmin"] as? Bool
//
//                       // let IsHRSurveyAdmin = DataDic["IsHRSurveyAdmin"] as? Bool
//    //                    let IsComplaintAdmin = DataDic["IsComplaintAdmin"]
//
//
//
//                        self.CallForLoginAPI()
//                    }else if (statuscode == 401){
//
//
//                    }else {
//
//
//                    }
//                case .failure(let error):
//                    print(error)
//                    KRProgressHUD.dismiss()
//                      self.createAlert(title: kAppName, message: kServerError)
//                }
//
//            }
//
//        }
        
        //MARK: - API CALLING -
//        func CallForLoginAPI(){
//            KRProgressHUD.show()
//            if reachability.isConnectedToNetwork() == false{
//                KRProgressHUD.dismiss()
//                    self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
//                return
//            }
//            let url = "\(ApiLink.HOST_URL)\(UserLogin)"
//            var params = [String:Any]()
//             params = [
//                "MOBILE_NO" : mobileNumberText.text ?? "" ,
//                "Otp" : enterpasstext.text ?? ""
//            ]
//            print("Params \(params)")
//            NetworkManager.sharedInstance.manager.request(url, method: .post, parameters: params).responseJSON{ response in
//                KRProgressHUD.dismiss()
//                switch response.result {
//                case .success(let value):
//                    print(value)
//                    let dict = value as! [String:Any]
//                    print("JSON: \(dict)")
//                     let statuscode = dict["statuscode"] as? Int
//
//                    let message = dict["message"] as? String
//                    if (statuscode == 200){
//                        let DataDic = dict["data"] as! [String:Any]
//                        let Token = DataDic["Token"]as? String
//                        let INTERCOM_NO_OFFICE = DataDic["INTERCOM_NO_OFFICE"] as? Int ?? 0
//                        let INTERCOM_NO_RESIDENCE = DataDic["INTERCOM_NO_RESIDENCE"] as? Int ?? 0
//                        UserDefaults.standard.setValue(Token, forKey: "Token")
//                        UserDefaults.standard.setValue(INTERCOM_NO_OFFICE, forKey: "INTERCOM_NO_OFFICE")
//                        UserDefaults.standard.setValue(INTERCOM_NO_RESIDENCE, forKey: "INTERCOM_NO_RESIDENCE")
//                        let obj = LoginData.init(DataDic)
//                        self.loginDetailData = obj
//                        kUserDefaults.saveToDefault(self.loginDetailData)
//                        print(kUserDefaults.retriveString(.INTERCOM_NO_OFFICE))
//                              print(kUserDefaults.retriveString(.INTERCOM_NO_OFFICE))
//                        self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage: kLogoutMessage, btnOneTitle: "Ok") {_ in
//                            kAppDelegate.setHomeTabVC()
//                        }
//
//                    }else if (statuscode == 401){
//
//
//                    }else {
//
//
//                    }
//                case .failure(let error):
//                    print(error)
//                    KRProgressHUD.dismiss()
//                      self.createAlert(title: kAppName, message: kServerError)
//                }
//
//            }
//
//        }

        
        
        
    }
    extension LoginWithOtpVC : UITextFieldDelegate {
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            textField.endEditing(true)
            textField.isUserInteractionEnabled = true
            
      
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Tell the keyboard where to go on next / go button.
            
            
            return true
        }
        
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            
            if textField == mobileNumberText {
                
                let NewLength = (mobileNumberText.text?.count)! + string.count - range.length
                return NewLength <= 10
                
                
            }
            
            return true
        }
        
        
    }

