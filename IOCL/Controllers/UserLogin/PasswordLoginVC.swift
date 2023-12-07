//
//  PasswordLoginVC.swift
//  GESEME
//
//  Created by InfoneoMacMini on 22/08/22.
//

import UIKit
import KRProgressHUD
import Alamofire
import SwiftyJSON

class PasswordLoginVC: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - OUTLETS -
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var enterpasstext : UITextField!
    @IBOutlet weak var hindiBtn : UIButton!
    @IBOutlet weak var englishBtn : UIButton!
    @IBOutlet weak var passwordBtn: UIButton!
    
    //MARK: - VARIABLES -
    var mobileNumberValue = String()
    var loginDetailData : LoginData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KRProgressHUD.set(activityIndicatorViewColors: [selctedBorder])
        enterpasstext.setLeftPaddingPoints(10)
        passwordBtn.setImage(UIImage(named: "EysClose"), for: .normal)
        enterpasstext.isSecureTextEntry = true
        enterpasstext.text = "1234"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 40)
    }
    
    //MARK: - BUTTON ACTIONS -
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        if enterpasstext.text == "" {
            self.createAlert(title: kAppName, message: kEnterPassword)
        }else{
          //  CallForLoginAPI()
        }
        
    }
    
    @IBAction func forgotBtnAction(_ sender: UIButton) {
      //  CallForOtpSendAPI()
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
    
    //    //MARK: - API CALLING -
    //    func CallForLoginAPI(){
    //        KRProgressHUD.show()
    //        if reachability.isConnectedToNetwork() == false{
    //            KRProgressHUD.dismiss()
    //                self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
    //            return
    //        }
    //        let url = "\(ApiLink.HOST_URL)\(UserLogin)"
    //        var params = [String:Any]()
    //
    //         params = [
    //            "MOBILE_NO" : mobileNumberValue ,
    //            "PASSWORD" : enterpasstext.text ?? ""
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
    //                let message = dict["message"] as? String
    //                if (statuscode == 200){
    //                    let DataDic = dict["data"] as! [String:Any]
    //                    let Token = DataDic["Token"]as? String
    //                    UserDefaults.standard.setValue(Token, forKey: "Token")
    //                    let obj = LoginData.init(DataDic)
    //                    self.loginDetailData = obj
    //                    kUserDefaults.saveToDefault(obj)
    //                   kAppDelegate.setHomeTabVC()
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
    //
    //    func CallForRefreshTokenAPI(Token:String){
    //        KRProgressHUD.show()
    //        if reachability.isConnectedToNetwork() == false{
    //            KRProgressHUD.dismiss()
    //                self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
    //            return
    //        }
    //        let url = "\(ApiLink.HOST_URL)\(RefereshToken)"
    //        let headers: HTTPHeaders = [
    //            "Authorization": "Basic \(Token)",
    //            "Accept": "application/json"
    //        ]
    //
    //        NetworkManager.sharedInstance.manager.request(url, method: .post, parameters: nil , headers: headers).responseJSON{ response in
    //            KRProgressHUD.dismiss()
    //            switch response.result {
    //            case .success(let value):
    //                print(value)
    //                let dict = value as! [String:Any]
    //                print("JSON: \(dict)")
    //                 let statuscode = dict["statuscode"] as? Int
    //
    //                let message = dict["message"] as? String
    //                if (statuscode == 200){
    //
    //
    //
    //                            // kAppDelegate.setHomeTabVC()
    //                                let vc = IOCLTabbarController.instantiate(fromAppStoryboard: .Main)
    //                                self.navigationController?.pushViewController(vc, animated: true)
    //
    //                }else if (statuscode == 401){
    //
    //
    //                }else {
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
    //
    //    func CallForOtpSendAPI(){
    ////        KRProgressHUD.show()
    ////        if reachability.isConnectedToNetwork() == false{
    ////            KRProgressHUD.dismiss()
    ////                self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
    ////            return
    ////        }
    ////
    ////        let url = "\(ApiLink.HOST_URL)\(VerifyForgotPassword)"
    ////        var params = [String:Any]()
    ////
    ////
    ////        params = [
    ////
    ////            "mobile" : mobileNumberValue  ,
    ////        ]
    ////
    ////
    ////        print("Params \(params)")
    ////
    ////        NetworkManager.sharedInstance.manager.request(url, method: .post, parameters: params).responseJSON{ response in
    ////            KRProgressHUD.dismiss()
    ////            switch response.result {
    ////            case .success(let value):
    ////                print(value)
    ////                let dict = value as! [String:Any]
    ////                print("JSON: \(dict)")
    ////                let statuscode = dict["status"] as! Bool
    ////                let message = dict["message"] as? String
    ////                if (statuscode == true){
    ////                    let DataDic = dict["data"] as! [String:Any]
    ////
    ////
    ////                    let mobile = DataDic["mobile"]as? String
    ////                    let otp = DataDic["otp"]as? Int
    ////
    ////                    _ = presentAlertWithOptions("", message: message, controller: self, buttons: ["Ok"], tapBlock:
    ////                        {
    ////                            (UIAlertAction, position) in
    ////                            if position == 0{
    ////
    ////
    ////                                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    ////                                let viewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
    ////                                viewController.mobileNo =  self.mobileNumberValue
    ////                                viewController.otp = otp!
    ////                                self.navigationController?.pushViewController(viewController, animated: true)
    ////
    ////
    ////                     }
    ////                    })
    ////
    ////
    ////
    ////
    ////
    ////
    ////
    ////
    ////                }else {
    ////                    _ = presentAlertWithOptions("", message: message, controller: self, buttons: ["Ok"], tapBlock:
    ////                        {
    ////                            (UIAlertAction, position) in
    ////                            if position == 0{
    ////
    ////
    ////                     }
    ////                    })
    ////                }
    ////            case .failure(let error):
    ////                print(error)
    ////
    ////                KRProgressHUD.dismiss()
    ////                  self.createAlert(title: kAppName, message: kServerError)
    ////            }
    ////
    ////        }
    ////
    //    }
    //
    //
    //
    //}
}
