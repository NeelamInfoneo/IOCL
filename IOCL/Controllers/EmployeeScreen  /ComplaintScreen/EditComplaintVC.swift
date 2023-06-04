//
//  EditComplaintVC.swift
//  IOCL
//
//  Created by InfoneoMacMini on 31/01/23.
//

import UIKit
import DropDown
import AVFoundation
import Alamofire
import SwiftyJSON
import KRProgressHUD

class EditComplaintVC: UIViewController  , WWCalendarTimeSelectorProtocol {
    //MARK: - OUTLETS -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var complaintType_Text: UITextField!
    @IBOutlet weak var complaintSubType_Text: UITextField!
    @IBOutlet weak var complaintSubSubType_Text: UITextField!
    @IBOutlet weak var quarterNo_Text: UITextField!
    @IBOutlet weak var des_Text: UITextView!
    @IBOutlet weak var quarterNo_Lbl: UILabel!
    @IBOutlet weak var desTextCount: UILabel!
    @IBOutlet weak var mobileNo_Text: UITextField!
    var INTERCOM_NO_RESIDENCE = UserDefaults.standard.value(forKey: "INTERCOM_NO_RESIDENCE") as? Int
    var INTERCOM_NO_OFFICE = UserDefaults.standard.value(forKey: "INTERCOM_NO_OFFICE") as? Int
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    //MARK: - VARIABLES -
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var selectType = String()
    var complaintType_Value = String()
    var complaintSubType_Value = String()
    var complaintSubSubType_Value = String()
    var quarterNo_Value = String()
    var des_Value = String()
    var mobileNo_Value = String()
    
    var COMP_ID = Int()
    //MARK: - COMPLAINT VARIABLES -
    var complaintArray = [String]()
    var complaintID = Int()
    var complaintDataArray = [[String:Any]]()
    var complaintdropDown:BKDropDown!
    
    //MARK: - COMPLAINT SUB VARIABLES -
    var complaintSubArray = [String]()
    var complaintSubID = Int()
    var complaintSubDataArray = [[String:Any]]()
    var complaintSubdropDown:BKDropDown!
    
    //MARK: - COMPLAINT SUB SUB VARIABLES -
    var complaintSub_SubArray = [String]()
    var complaintSub_SubID = Int()
    var complaintSub_SubDataArray = [[String:Any]]()
    var complaintSub_SubdropDown:BKDropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        setvc()
        desTextCount.isHidden = true
        self.quarterNo_Text.text = kUserDefaults.retriveString(.QTR_NO)
        self.quarterNo_Lbl.text = "Quater Number"
        self.quarterNo_Text.isUserInteractionEnabled = false
        complaintType_Text.text = complaintType_Value
        
        complaintSubType_Text.text = complaintSubType_Value
        complaintSubSubType_Text.text = complaintSubSubType_Value
        quarterNo_Text.text = quarterNo_Value
        des_Text.text = des_Value
        mobileNo_Text.text = mobileNo_Value
        if  self.complaintType_Text.text == "Estate" {
            self.quarterNo_Lbl.text = "Quater Number"
            self.quarterNo_Text.text = kUserDefaults.retriveString(.QTR_NO)
            self.quarterNo_Text.isUserInteractionEnabled = false
            self.mobileNo_Text.text =  "\(self.INTERCOM_NO_RESIDENCE ?? 0 )"
        }else  if  self.complaintType_Text.text == "Office Equipment" {
            self.quarterNo_Text.text = ""
            self.quarterNo_Text.isUserInteractionEnabled = true
            self.quarterNo_Lbl.text = "Office Location"
            self.mobileNo_Text.text =  "\(self.INTERCOM_NO_OFFICE ?? 0)"
        }
        
        
        complaintType_Text.setLeftPaddingPoints(10)
        complaintSubType_Text.setLeftPaddingPoints(10)
        complaintSubSubType_Text.setLeftPaddingPoints(10)
        quarterNo_Text.setLeftPaddingPoints(10)
        mobileNo_Text.setLeftPaddingPoints(10)
        complaintType_Text.isUserInteractionEnabled = false
        complaintSubType_Text.isUserInteractionEnabled = false
        complaintSubSubType_Text.isUserInteractionEnabled = false
        mobileNo_Text.delegate = self
        
        CallForGetComplaintSubSubCategoryAPI(CATEGORY : complaintType_Value  , SUB_CATEGORY : complaintSubType_Value )
        
        // Do any additional setup after loading the view.
    }
    
    
    private func setvc() {
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    
    //MARK: - BUTTON FUNCTIONS -
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func tapOnNotificationBtn(_ sender: Any) {
        
        let vc = NotificationVC.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func complaintTypeBtnAction(_ sender: UIButton) {
        
        if complaintdropDown != nil{
            complaintdropDown
                .setLayoutCell(width: 220)
                .show(self, targetView: sender)
        }
    }
    
    @IBAction func complaintSubCategoryBtnAction(_ sender: UIButton) {
        
        if complaintType_Text.text == "" {
            self.createAlert(title: kAppName, message: kCamplaintCategory)
        }else {
            if complaintSubdropDown != nil{
                complaintSubdropDown
                    .setLayoutCell(width:220)
                    .show(self, targetView: sender)
            }
        }
    }
    
    @IBAction func complaintSubSubCategoryBtnAction(_ sender: UIButton) {
        if complaintSubType_Text.text == "" {
            self.createAlert(title: kAppName, message: kCamplaintSubCategory)
        }else {
            if complaintSub_SubdropDown != nil{
                complaintSub_SubdropDown
                    .setLayoutCell(width:220)
                    .show(self, targetView: sender)
            }
        }
        
        
    }
    
    @IBAction func complaintSubmitBtnAction(_ sender: UIButton) {
        
        if self.complaintType_Text.text == "" {
            self.createAlert(title: kAppName, message: kCamplaintCategory)
        }else if complaintSubType_Text.text == "" {
            self.createAlert(title: kAppName, message: kCamplaintSubCategory)
        }else if complaintSubSubType_Text.text == "" {
            self.createAlert(title: kAppName, message: kCamplaintSubSubCategory)
        }else if quarterNo_Text.text == "" {
            self.createAlert(title: kAppName, message: kQuaterNumber)
        }else if quarterNo_Text.text == "" {
            self.createAlert(title: kAppName, message: kCompDetails)
        }else {
            CallForUpdateComplaintAPI()
        }
        
    }
    
    @IBAction func complaintHistoryBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ComplaintHistoryViewController") as! ComplaintHistoryViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func clearBtnAction(_ sender: UIButton) {
        complaintType_Text.text = ""
        complaintSubType_Text.text = ""
        complaintSubSubType_Text.text = ""
        quarterNo_Text.text = ""
        des_Text.text = ""
        mobileNo_Text.text = ""
    }
    
    //MARK: - SET COMPLAINT DROPDOWN  --------------
    func setComplaintSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        complaintdropDown = BKDropDown.instance()
            .bind(complaintArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.complaintType_Text.text = item.title
                print("item value \(item.title)")
                if  self.complaintType_Text.text == "Estate" {
                    self.quarterNo_Text.text = kUserDefaults.retriveString(.QTR_NO)
                    self.quarterNo_Lbl.text = "Quater Number"
                    self.quarterNo_Text.isUserInteractionEnabled = false
                    self.mobileNo_Text.text =  "\(self.INTERCOM_NO_RESIDENCE ?? 0 )"
                }else  if  self.complaintType_Text.text == "Office Equipment" {
                    self.quarterNo_Text.text = ""
                    self.quarterNo_Text.isUserInteractionEnabled = true
                    self.quarterNo_Lbl.text = "Office Location"
                    self.mobileNo_Text.text =  "\(self.INTERCOM_NO_OFFICE ?? 0)"
                }
                dropDown.hide()
            })
    }
    
    //MARK: - SET COMPLAINT SUB DROPDOWN  --------------
    func setComplaintSubCategorySetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        complaintSubdropDown = BKDropDown.instance()
            .bind(complaintSubArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.complaintSubType_Text.text = item.title
                print("item value \(item.title)")
                for (i,item) in self.complaintSubDataArray.enumerated() {
                    print(i)
                    let Name = item["CATEGORY"] as! String
                    self.CallForGetComplaintSubSubCategoryAPI(CATEGORY: Name , SUB_CATEGORY:   self.complaintSubType_Text.text ?? "")
                }
                dropDown.hide()
            })
    }
    //MARK: - SET COMPLAINT SUB SUB DROPDOWN  --------------
    func setComplaintSubSubCategorySetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        complaintSub_SubdropDown = BKDropDown.instance()
            .bind(complaintSub_SubArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.complaintSubSubType_Text.text = item.title
                print("item value \(item.title)")
                for (i,item) in self.complaintSub_SubDataArray.enumerated() {
                    print(i)
                    self.complaintSub_SubID = item["ID"] as! Int
                    
                }
                dropDown.hide()
            })
    }
}
//MARK: - TABLEV VIEW DATASOURCE -
extension EditComplaintVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
}
//MARK: - API CALLING FUNCTIONS -
extension EditComplaintVC {
    
    
    
    //MARK: - GetComplaintSubSubCategory API CALLING FUNCTIONS ------------------------------------------
    func CallForGetComplaintSubSubCategoryAPI(CATEGORY : String , SUB_CATEGORY :String ) {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let url = "\(ApiLink.HOST_URL)\(GetComplaintSubSubCategory)"
        let params : [String:Any]  = ["CATEGORY" : CATEGORY ,
                                      "SUB_CATEGORY" : SUB_CATEGORY]
        ServiceRequest.shared.GetComplaintSubSubCategoryApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.complaintSub_SubDataArray = []
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                self.complaintSub_SubDataArray = dict?["data"] as! [[String:Any]]
                for item in self.complaintSub_SubDataArray {
                    let Name = item["SUB_SUB_CATEGORY"] as! String
                    self.complaintSub_SubArray.append(Name)
                }
                self.setComplaintSubSubCategorySetupDropDown()
            }else if (statuscode == 401){
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
    
    
    //MARK: - Update COMPLAINT API CALLING FUNCTIONS ------------------------------------------
    func CallForUpdateComplaintAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        var params = [String:Any]()
        if  self.complaintType_Text.text == "Estate" {
            params  = [
                "COMP_ID" : COMP_ID ,
                "GRADE" : kUserDefaults.retriveString(.GRADE) ,
                "COMPLAINT_CATEGORY_ID" : self.complaintSub_SubID ,
                "COMP_DESC" : des_Text.text ?? "" ,
                "REMARKS" : "" ,
                "QTR_NO" : self.quarterNo_Lbl.text ?? "" ,
                "OFFICE_LOCATION" : ""  ,
                "VENDOR_SERNO" : 1
            ]
        }else  if  self.complaintType_Text.text == "Office Equipment" {
            params = [
                "COMP_ID" : COMP_ID ,
                "GRADE" : kUserDefaults.retriveString(.GRADE) ,
                "COMPLAINT_CATEGORY_ID" : self.complaintSub_SubID ,
                "COMP_DESC" : des_Text.text ?? "" ,
                "REMARKS" : "" ,
                "QTR_NO" : "" ,
                "OFFICE_LOCATION" : self.quarterNo_Lbl.text ?? "" ,
                "VENDOR_SERNO" : 1
            ]
        }
        print(params)
        
        ServiceRequest.shared.UpdateAddComplaintApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            if (response != nil){
                let dict = response
                print("JSON: \(dict)")
                self.complaintSub_SubDataArray = []
                let statuscode = dict?["statuscode"] as? Int
                let message = dict?["message"] as? String
                if (statuscode == 200){
                    self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage: message ?? "", btnOneTitle: "Ok") {_ in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else if (statuscode == 401){
                    self.createAlert(title: kAppName, message: kServerError)
                }else {
                    self.createAlert(title: kAppName, message: message  ?? "")
                }
            }else{
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
            
        })
    }
    
}
    
    extension EditComplaintVC : UITextFieldDelegate {
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            textField.endEditing(true)
            textField.isUserInteractionEnabled = true
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Tell the keyboard where to go on next / go button.
            return true
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == mobileNo_Text {
                let NewLength = (mobileNo_Text.text?.count)! + string.count - range.length
                return NewLength <= 10
            }
            return true
        }
        
        
    }
    
    
    
    
