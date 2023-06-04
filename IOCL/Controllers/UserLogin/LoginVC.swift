//
//  LoginVC.swift
//  GESEME
//
//  Created by InfoneoMacMini on 18/08/22.
//

import UIKit
import Alamofire
import KRProgressHUD

class LoginVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mobileNumberText: UITextField!
    @IBOutlet weak var enterpasstext : UITextField!
    @IBOutlet weak var passwordBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var counrtyLbl: UIButton!
    @IBOutlet weak var counrtyWidth: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: UILabel!
    
    var userType = String()
    var mobileNumberValue = String()
    var loginDetailData : LoginData?
    var primaryOtpValue = String()
    var primaryMobileNoValue = Int()
    var secondaryOtpValue = String()
    var secondaryMobileNoValue = Int()
    var ProfileDetailData : ProfileData?
    var fcmToken = UserDefaults.standard.value(forKey: "fcm_token") as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fcmToken \(fcmToken)")
        mobileNumberText.setLeftPaddingPoints(10)
        enterpasstext.setLeftPaddingPoints(10)
        mobileNumberText.delegate = self
        enterpasstext.delegate = self
        enterpasstext.isSecureTextEntry = true
        if userType == "LDAP Login" {
            mobileNumberText.placeholder = "Enter Emp No."
            titleLbl.text = "Fill in your emp number"
            counrtyWidth.constant = 0
            counrtyLbl.isHidden = true
            mobileNumberText.text = "00040657"
            enterpasstext.text = "ioCl!1234"
        }else if userType == "Employee Login" {
            titleLbl.text = "Fill in your registered number"
            mobileNumberText.text = "9891793570"
            enterpasstext.text = "ioCl!1234"
        }
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
            CallForLoginAPI()
        }
    }
    
    @IBAction func forgotepasswordBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        self.navigationController?.pushViewController(viewController, animated: true)
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
    //    func CallForGetUserDetailAPI(){
    //        KRProgressHUD.show()
    //        if reachability.isConnectedToNetwork() == false{
    //            KRProgressHUD.dismiss()
    //                self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
    //            return
    //        }
    //        let url = "\(ApiLink.HOST_URL)\(GetUserDetail)"
    //        var params = [String:Any]()
    //
    //
    //
    //         params = [
    //            "MOBILE_NO" : mobileNumberText.text ?? "" ,
    //        ]
    //        print("Params \(params)")
    //        NetworkManager.sharedInstance.manager.request(url, method: .post, parameters: params).responseJSON{ response in
    //            KRProgressHUD.dismiss()
    //            switch response.result {
    //            case .success(let value):
    //                print(value)
    //                let dict = value as! [String:Any]
    //                print("JSON: \(dict)")
    //                 let statuscode = dict["statuscode"] as? Int
    //
    //                if (statuscode == 200){
    //                    let DataDic = dict["data"] as! [String:Any]
    //                    self.primaryOtpValue = DataDic["ONLY_OTP1"] as? String ?? ""
    //                    self.primaryMobileNoValue = DataDic["MOBILE_NO"] as? Int ?? 0
    //                    self.secondaryMobileNoValue = DataDic["ADDL_MOBILE_NO"] as? Int ?? 0
    //                    self.secondaryOtpValue = DataDic["ONLY_OTP2"] as? String ?? ""
    //                    self.CallForLoginAPI()
    //                }else if (statuscode == 401){
    //
    //
    //                }else {
    //
    //
    //                }
    //            case .failure(let error):
    //                print(error)
    //                KRProgressHUD.dismiss()
    //                  self.createAlert(title: kAppName, message: kServerError)
    //            }
    //
    //        }
    //
    //    }
    
    //MARK: - API CALLING -
    
  

    
    func CallForLoginAPI(){
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        var params = [String:Any]()
        if userType == "LDAP Login" {
            params = [
                "EMPNO" : mobileNumberText.text ?? "" ,
                "PASSWORD" : enterpasstext.text ?? "" ,
                "IsiOs" : "true" ,
                "Token" : fcmToken ?? ""
            ]
        }else if userType == "Employee Login" {
            params = [
                "MOBILE_NO" : mobileNumberText.text ?? "" ,
                "PASSWORD" : enterpasstext.text ?? "" ,
                "IsiOs" : "true" ,
                "Token" : fcmToken ?? ""
            ]
        }
        
       
       
     
        ServiceRequest.shared.GetLogin(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            let message = dict?["message"] as? String
            if (statuscode == 200){
                let DataDic = dict?["data"] as? [String:Any]
                let Token = DataDic?["Token"]as? String
                let INTERCOM_NO_OFFICE = DataDic?["INTERCOM_NO_OFFICE"] as? Int ?? 0
                let INTERCOM_NO_RESIDENCE = DataDic?["INTERCOM_NO_RESIDENCE"] as? Int ?? 0
                let MOBILE_NO = DataDic?["MOBILE_NO"] as? Int ?? 0
                let GRADE = DataDic?["GRADE"] as? String ?? ""
                let QTR_NO = DataDic?["QTR_NO"] as? String ?? ""
                let CompleteProfile = true
                self.primaryOtpValue = DataDic?["ONLY_OTP1"] as? String ?? ""
                self.primaryMobileNoValue = DataDic?["MOBILE_NO"] as? Int ?? 0
                self.secondaryMobileNoValue = DataDic?["ADDL_MOBILE_NO"] as? Int ?? 0
                self.secondaryOtpValue = DataDic?["ONLY_OTP2"] as? String ?? ""
                //  = DataDic["QTR_NO"] as? String ?? ""
                UserDefaults.standard.setValue(Token, forKey: "Token")
              print("Token \(UserDefaults.standard.value(forKey: "Token"))")
                UserDefaults.standard.setValue(CompleteProfile, forKey: "CompleteProfile")
                UserDefaults.standard.setValue(QTR_NO, forKey: "QTR_NO")
                UserDefaults.standard.setValue(GRADE, forKey: "GRADE")
                UserDefaults.standard.setValue(INTERCOM_NO_OFFICE, forKey: "INTERCOM_NO_OFFICE")
                UserDefaults.standard.setValue(INTERCOM_NO_RESIDENCE, forKey: "INTERCOM_NO_RESIDENCE")
                let IsApproverAdmin = DataDic?["IsApproverAdmin"] as? Bool
                let IsCarRequestAdmin = DataDic?["IsCarRequestAdmin"] as? Bool
                let IsHRSurveyAdmin = DataDic?["IsHRSurveyAdmin"] as? Bool
                let IsComplaintAdmin = DataDic?["IsComplaintAdmin"] as? Bool
                let IsOutstationDisasterCoordinator = DataDic?["IsOutstationDisasterCoordinator"] as? Bool
                UserDefaults.standard.setValue(IsApproverAdmin, forKey: "IsApproverAdmin")
                UserDefaults.standard.setValue(IsHRSurveyAdmin, forKey: "IsHRSurveyAdmin")
                UserDefaults.standard.setValue(IsCarRequestAdmin, forKey: "IsCarRequestAdmin")
                UserDefaults.standard.setValue(IsComplaintAdmin, forKey: "IsComplaintAdmin")
                UserDefaults.standard.setValue(IsOutstationDisasterCoordinator, forKey: "IsOutstationDisasterCoordinator")
                let obj = LoginData.init(DataDic!)
                self.loginDetailData = obj
                kUserDefaults.saveToDefault(self.loginDetailData)
                print(kUserDefaults.retriveString(.INTERCOM_NO_OFFICE))
                print(kUserDefaults.retriveString(.INTERCOM_NO_OFFICE))
                print(self.primaryOtpValue)
                print(self.secondaryOtpValue)
                
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                        print("\(key) = \(value) \n")
                      }
                
                if self.userType == "LDAP Login" {
                    kAppDelegate.setHomeTabVC()
                }else{
                    if "\(self.primaryMobileNoValue)" == self.mobileNumberText.text ?? "" {
                        if self.primaryOtpValue == "N" || self.primaryOtpValue == ""  {
                            kAppDelegate.setHomeTabVC()
                        }else if  self.primaryOtpValue == "Y"  {
                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "OTPLoginVC") as! OTPLoginVC
                            viewController.mobileNumberValue = self.primaryMobileNoValue
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    }else if "\(self.secondaryMobileNoValue)" == self.mobileNumberText.text ?? "" {
                        if self.secondaryOtpValue == "N"  || self.secondaryOtpValue == ""{
                            kAppDelegate.setHomeTabVC()
                        }else if self.secondaryOtpValue == "Y" {
                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "OTPLoginVC") as! OTPLoginVC
                            viewController.mobileNumberValue = self.secondaryMobileNoValue
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    }
                }
                
            }else if (statuscode == 401){  
                self.createAlert(title: kAppName, message: message ?? "")
            }else if (statuscode == 300){
                self.createAlert(title: kAppName, message: message ?? "")
                
            }
            
        })
        
    }
    
    
    
    
}
extension LoginVC : UITextFieldDelegate {
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
            return NewLength <= 20
            
            
        }
        
        return true
    }
    
    
}

