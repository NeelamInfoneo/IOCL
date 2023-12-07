//
//  ComposeEmailVC.swift
//  IOCL
//
//  Created by neelam  on 06/03/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class ComposeEmailVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CCDataPass {
    func ccDataPassing(CC_MAIL: String) {
        self.toCCEmailLbl.text = CC_MAIL
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var toEmailLbl: PaddingLabel!
    @IBOutlet weak var toCCEmailLbl: PaddingLabel!
    @IBOutlet weak var subjectLbl: PaddingLabel!
    @IBOutlet weak var desLbl: PaddingLabel!
    
    var  CC_MAIL = String()
    var  FROM_MAIL = String()
    var  MAILBODY = String()
    var  SUBJECT = String()
    var  To_MAIL = String()
    
    var LEAVE_TYPEValue = String()
    var FROM_DATEValue = String()
    var FROM_TIMEValue = String()
    var FROM_AMPMValue = String()
    var TO_DATEValue = String()
    var TO_TIMEValue = String()
    var TO_AMPMValue = String()
    var PURPOSEValue = String()
    var RESPONSIBILITYValue = String()
    var DISASTER_COValue = String()
    var DESTINATIONValue = String()
    var REMARKSValue = String()
    var ADMIN_RES_EMPNOValue = Int()
    var ADMIN_RES_NAMEValue  = String()
    var JOB_IC_1_EMPNOValue = String()
    var JOB_IC_1Value = String()
    var JOB_IC_2_EMPNOValue = String()
    var JOB_IC_2Value = String()
    var JOB_IC_3_EMPNOValue = String()
    var JOB_IC_3Value = String()
    var JOB_IC_4_EMPNOValue = String()
    var JOB_IC_4Value = String()
    var APPROVERValue = Int()
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toEmailLbl.text = To_MAIL
        toCCEmailLbl.text = CC_MAIL
        subjectLbl.text = SUBJECT
        desLbl.text = MAILBODY.capitalized
        setvc()
        // Do any additional setup after loading the view.
    }
    
    private func setvc() {
        
        toEmailLbl.paddingLeft = 10
        toEmailLbl.paddingRight = 10
        toEmailLbl.paddingTop = 5
        toEmailLbl.paddingBottom = 5
        
        subjectLbl.paddingLeft = 10
        subjectLbl.paddingRight = 10
        subjectLbl.paddingTop = 5
        subjectLbl.paddingBottom = 5
        
        toCCEmailLbl.paddingLeft = 10
        toCCEmailLbl.paddingRight = 10
        toCCEmailLbl.paddingTop = 5
        toCCEmailLbl.paddingBottom = 5
        
        desLbl.paddingLeft = 10
        desLbl.paddingRight = 10
        desLbl.paddingTop = 5
        desLbl.paddingBottom = 5
        
        
        
        //        toEmailLbl.padding = ui
        //        toCCEmailLbl.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        //        subjectLbl.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        //        desLbl.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func tapOnBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addCCBtnAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AddCCVC") as! AddCCVC
        viewController.CCDataDelagte = self
        viewController.CC_MAIL =  self.CC_MAIL
        viewController.modalPresentationStyle = .custom
        self.navigationController?.present(viewController, animated: false)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        CallAddOutstationAPI()
    }
    @IBAction func exitBtnAction(_ sender: UIButton) {
        
        
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

extension ComposeEmailVC{
    
    //MARK: - ADD COMPLAINT API CALLING FUNCTIONS ------------------------------------------
    func CallAddOutstationAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let url = "\(ApiLink.HOST_URL)\(AddOutstation)"
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(Token ?? "")",
            "Accept": "application/json"
        ]
        
        let params : [String:Any]  = [
            "LEAVE_TYPE": LEAVE_TYPEValue ,
            "FROM_DATE": FROM_DATEValue ,
            "FROM_TIME": FROM_TIMEValue ,
            "FROM_AMPM": FROM_AMPMValue ,
            "TO_DATE": TO_DATEValue ,
            "TO_TIME": TO_TIMEValue ,
            "TO_AMPM": TO_AMPMValue ,
            "PURPOSE": PURPOSEValue,
            "RESPONSIBILITY": RESPONSIBILITYValue ,
            "DISASTER_CO": DISASTER_COValue ,
            "DESTINATION": DESTINATIONValue ,
            "REMARKS" : REMARKSValue ,
            "ADMIN_RES_EMPNO" : ADMIN_RES_EMPNOValue  ,
            "ADMIN_RES_NAME" : ADMIN_RES_NAMEValue ,
            "JOB_IC_1_EMPNO" : JOB_IC_1_EMPNOValue,
            "JOB_IC_1" : JOB_IC_1Value ,
            "JOB_IC_2_EMPNO" : JOB_IC_2_EMPNOValue ,
            "JOB_IC_2" : JOB_IC_2Value ,
            "JOB_IC_3_EMPNO" : JOB_IC_3_EMPNOValue ,
            "JOB_IC_3" : JOB_IC_3Value ,
            "JOB_IC_4_EMPNO" : JOB_IC_4_EMPNOValue ,
            "JOB_IC_4" : JOB_IC_4Value ,
            "APPROVER" : APPROVERValue  ,
        ]
        print(params)
        
        ServiceRequest.shared.AddOutstationApi(params, completionHandler: { isSucess, response, errorMsg in
           
            KRProgressHUD.dismiss()
           
                let dict = response
                print("JSON: \(dict)")
                let statuscode = dict?["statuscode"] as? Int
                let message = dict?["message"] as? String
                if (statuscode == 200){
                    self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage: "Outstation Add Successfully", btnOneTitle: "Ok") {_ in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else if (statuscode == 401){
                    
                }else {
                    KRProgressHUD.dismiss()
                    self.createAlert(title: kAppName, message: kServerError)
                 
            }
        })
    }
    
}
