//
//  VerifyOTPVC.swift
//  IOCL
//
//  Created by neelam  on 17/05/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class VerifyOTPVC: UIViewController  ,UITableViewDelegate, UITableViewDataSource {
        
        
        
        @IBOutlet weak var topView: UIView!
        @IBOutlet weak var enterOtptext : UITextField!
        @IBOutlet weak var passwordBtn: UIButton!

        var otp =  Int()
        var mobileNumberValue = Int()
    var otpKey = String()

        override func viewDidLoad() {
            super.viewDidLoad()
            enterOtptext.setLeftPaddingPoints(10)
            enterOtptext.isSecureTextEntry = true
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
           
                    if enterOtptext.text ?? "" == "\(otp)" {
                        self.createAlert(title: kAppName, message: kServerError)
                    }else {
               CallForOtpLoginAPI()
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
                "Otp" : enterOtptext.text ?? "" ,
                "OtpKey" : otpKey ,
            ]
            print("Params \(params)")
            ServiceRequest.shared.GetOTPVrify(params, completionHandler: { isSucess, response, errorMsg in
                KRProgressHUD.dismiss()
                let dict = response
                print("JSON: \(dict)")
                let statuscode = dict?["statuscode"] as? Int
                let message = dict?["message"] as! String
                if (statuscode == 200){
               
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "ResentPasswordChangeVC") as! ResentPasswordChangeVC
                    self.navigationController?.pushViewController(viewController, animated: true)
                }else {
                    self.createAlert(title: kAppName, message: message)
                }
            })
        }

    }
