//
//  ResentPasswordChangeVC.swift
//  IOCL
//
//  Created by neelam  on 17/05/23.
//

import UIKit
import SideMenu
import Alamofire
import KRProgressHUD


class ResentPasswordChangeVC: UIViewController {


        @IBOutlet weak var newPassword_Text: UITextField!
        @IBOutlet weak var comfirmPassword_Text: UITextField!
    @IBOutlet weak var newPasswordBtn: UIButton!
    @IBOutlet weak var confirmPasswordBtn: UIButton!
        var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var otpKey = String()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            newPassword_Text.setLeftPaddingPoints(10)
            comfirmPassword_Text.setLeftPaddingPoints(10)
            // Do any additional setup after loading the view.
        }
        
        @IBAction func submitbtnAction(_ sender: UIButton) {
           
                CallForChangePasswordAPI()
      
           
        }
    
    @IBAction func newPasswordBtnAction(_ sender: UIButton) {
        newPasswordBtn.isSelected = !newPasswordBtn.isSelected
        if newPasswordBtn.isSelected == true {
            newPasswordBtn.isSelected = true
            newPassword_Text.isSecureTextEntry = false
            newPasswordBtn.setImage(UIImage(named: "eysBlue"), for: .normal)
        }else{
            newPasswordBtn.isSelected = false
            newPassword_Text.isSecureTextEntry = true
            newPassword_Text.backgroundColor = .clear
            newPassword_Text.tintColor = .white
            newPasswordBtn.setImage(UIImage(named: "EysClose"), for: .normal)
        }
    }
    
    
    @IBAction func confirmPasswordBtnAction(_ sender: UIButton) {
        confirmPasswordBtn.isSelected = !confirmPasswordBtn.isSelected
        if confirmPasswordBtn.isSelected == true {
            confirmPasswordBtn.isSelected = true
            comfirmPassword_Text.isSecureTextEntry = false
            confirmPasswordBtn.setImage(UIImage(named: "eysBlue"), for: .normal)
        }else{
            confirmPasswordBtn.isSelected = false
            comfirmPassword_Text.isSecureTextEntry = true
            comfirmPassword_Text.backgroundColor = .clear
            comfirmPassword_Text.tintColor = .white
            confirmPasswordBtn.setImage(UIImage(named: "EysClose"), for: .normal)
        }
    }
    

        
        @IBAction func backbtnAction(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)
        }
        
    //MARK: - ChangePassword API CALLING -
        func CallForChangePasswordAPI(){
            KRProgressHUD.show()
            if reachability.isConnectedToNetwork() == false{
                KRProgressHUD.dismiss()
                    self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
                return
            }
            var params = [String:Any]()
             params = [
                "Password": newPassword_Text.text ?? "" ,
                "NewPassword": comfirmPassword_Text.text ?? "" ,
                
            ]
            print(params)
            ServiceRequest.shared.ChangePasswordApi(params, completionHandler: { isSucess, response, errorMsg in
        
                KRProgressHUD.dismiss()
                    let dict = response as! [String:Any]
                    print("JSON: \(dict)")
                     let statuscode = dict["statuscode"] as? Int

                    let message = dict["message"] as? String
                    if (statuscode == 200){
                    
                        self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage:"Password Update Successfully ", btnOneTitle: "Ok") {_ in
                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                       
                    }else if (statuscode == 401){
                          
                    }else {
                   
                    KRProgressHUD.dismiss()
                      self.createAlert(title: kAppName, message: kServerError)
                }

            })
            
        }
        

    }


