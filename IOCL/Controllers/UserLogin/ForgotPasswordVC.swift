//
//  ForgotPasswordVC.swift
//  GESEMEJOBS
//
//  Created by InfoneoMacMini on 14/11/22.
//

import UIKit
import Alamofire
import KRProgressHUD

class ForgotPasswordVC: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var enterOtptext : UITextField!
    @IBOutlet weak var enterpasstext : UITextField!
    @IBOutlet weak var passwordBtn: UIButton!
    
    var mobileNo = String()
    var otp = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        enterpasstext.setLeftPaddingPoints(10)
        enterOtptext.setLeftPaddingPoints(10)
        passwordBtn.setImage(UIImage(named: "EysClose"), for: .normal)
        enterpasstext.isSecureTextEntry = true
        // Do any additional setup after loading the view.
        setvc()
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
       }
    
    private func setvc() {
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
        if enterOtptext.text == "" {
            self.createAlert(title: kAppName, message: kEnterOtp)
        }else if enterpasstext.text == "" {
            self.createAlert(title: kAppName, message: kEnterPassword)
        }else{
            self.CallForForgotPasswordAPI()
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
    
        func CallForForgotPasswordAPI(){
//            KRProgressHUD.show()
//            if reachability.isConnectedToNetwork() == false{
//                KRProgressHUD.dismiss()
//                    self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
//                return
//            }
//            let url = "\(ApiLink.HOST_URL)\(ForgotPasswordFinal)"
//            var params = [String:Any]()
//
//
//            params = [
//
//                "mobile" : mobileNo ,
//                "new_password" : enterpasstext.text ?? "" ,
//                "otp": enterOtptext.text ?? ""
//            ]
//            print("Params \(url)")
//            print("Params \(params)")
//
//            NetworkManager.sharedInstance.manager.request(url, method: .post, parameters: params).responseJSON{ response in
//                KRProgressHUD.dismiss()
//                switch response.result {
//                case .success(let value):
//                    print(value)
//                    let dict = value as! [String:Any]
//                    print("JSON: \(dict)")
//                    let statuscode = dict["status"] as! Bool
//                    let message = dict["message"] as? String
//                    if (statuscode == true){
//
//                        _ = presentAlertWithOptions("", message: message, controller: self, buttons: ["Ok"], tapBlock:
//                            {
//                                (UIAlertAction, position) in
//                                if position == 0{
//                                    self.navigationController?.popViewController(animated: true)
//
//                         }
//                        })
//
//                    }else {
//                        presentAlert("", msgStr: message, controller: self)
//                    }
//                case .failure(let error):
//                    print(error)
//
//                    KRProgressHUD.dismiss()
//                      self.createAlert(title: kAppName, message: kServerError)
//                }
//
//            }
            
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
}
