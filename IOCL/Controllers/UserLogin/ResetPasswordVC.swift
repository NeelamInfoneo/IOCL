//
//  ResetPasswordVC.swift
//  IOCL
//
//  Created by neelam  on 16/05/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class ResetPasswordVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mobileNumberText: UITextField!
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
    
    
    var otpKey = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fcmToken \(fcmToken)")
        mobileNumberText.setLeftPaddingPoints(10)
        //  mobileNumberText.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      //  topView.roundCorners(corners: [.topLeft, .topRight], radius: 40)
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        if mobileNumberText.text == "" {
            self.createAlert(title: kAppName, message: kMobileNumber)
        }else {
            CallForOtpLoginAPI()
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
    
    
    func CallForOtpLoginAPI(){
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        var params = [String:Any]()
        params = [
            "MOBILE_NO" : mobileNumberText.text ?? ""
        ]
        print("Params \(params)")
        ServiceRequest.shared.GetForgoteAPi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            let message = dict?["message"] as! String
            if (statuscode == 200){
                self.otpKey = dict?["data"] as! String
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "VerifyOTPVC") as! VerifyOTPVC
              viewController.otpKey =    self.otpKey
                viewController.mobileNumberValue =  Int(self.mobileNumberText.text ?? "") ?? 0
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }else {
                self.createAlert(title: kAppName, message: message)
            }
        })
        
    }
}
    extension ResetPasswordVC : UITextFieldDelegate {
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
    

