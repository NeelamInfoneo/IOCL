//
//  OTPLoginVC.swift
//  GESEME
//
//  Created by InfoneoMacMini on 22/08/22.
//

import UIKit
import Alamofire
import KRProgressHUD

class OTPLoginVC: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var enterpasstext : UITextField!
    @IBOutlet weak var passwordBtn: UIButton!
    var otp =  Int()
    var mobileNumberValue = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        enterpasstext.setLeftPaddingPoints(10)
        passwordBtn.setImage(UIImage(named: "EysClose"), for: .normal)
        enterpasstext.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 40)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        kAppDelegate.setHomeTabVC()
        //        if enterpasstext.text ?? "" == "\(otp)" {
        //            self.createAlert(title: kAppName, message: kServerError)
        //        }else {
        //   CallForOtpLoginAPI()
        //}
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
    
    
    func CallForOtpLoginAPI(){
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        var params = [String:Any]()
        params = [
            "MOBILE_NO" : "\(mobileNumberValue)" ,
            "Otp" : enterpasstext.text ?? "" ,
        ]
        print("Params \(params)")
        ServiceRequest.shared.GetOTPVrify(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            let message = dict?["message"] as! String
            if (statuscode == 200){
                kAppDelegate.setHomeTabVC()
            }else {
                self.createAlert(title: kAppName, message: message)
            }
        })
    }

}
