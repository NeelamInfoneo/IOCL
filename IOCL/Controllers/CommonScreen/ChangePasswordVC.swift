//
//  ChangePasswordVC.swift
//  IOCL
//
//  Created by neelam  on 23/04/23.
//

import UIKit
import SideMenu
import Alamofire
import KRProgressHUD

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var currentPass_Text: UITextField!
    @IBOutlet weak var newPassword_Text: UITextField!
    @IBOutlet weak var comfirmPassword_Text: UITextField!
    var Token = UserDefaults.standard.value(forKey: "Token") as? String

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPass_Text.setLeftPaddingPoints(10)
        newPassword_Text.setLeftPaddingPoints(10)
        comfirmPassword_Text.setLeftPaddingPoints(10)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitbtnAction(_ sender: UIButton) {
       
            CallForChangePasswordAPI()
  
       
    }
    
    @IBAction func exitbtnAction(_ sender: UIButton) {
        dismiss(animated: true)
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
                    self.createAlert(title: kAppName, message: kUpdateProfile)

                }else if (statuscode == 401){
                      
                }else {
               
                KRProgressHUD.dismiss()
                  self.createAlert(title: kAppName, message: kServerError)
            }

        })
        
    }
    

}
