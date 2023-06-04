//
//  ComplaintScreenVC.swift
//  IOCL
//
//  Created by InfoneoMacMini on 19/01/23.
//

import UIKit
import DropDown
import AVFoundation
import Alamofire
import SwiftyJSON
import KRProgressHUD

class ComplaintScreenVC: UIViewController , WWCalendarTimeSelectorProtocol ,UITextViewDelegate{
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
    var QTR_NO = UserDefaults.standard.value(forKey: "QTR_NO") as? String
    var OFFICE_LOCATION = UserDefaults.standard.value(forKey: "OFFICE_LOCATION") as? String
    
    //MARK: - VARIABLES -
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var selectType = String()
    var QuaterValue = String()
    var officeLocataion = String()
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
        
        self.quarterNo_Lbl.text = QTR_NO
        self.quarterNo_Lbl.text = "Quater Number"
        self.quarterNo_Text.isUserInteractionEnabled = false
        des_Text.delegate = self
        self.quarterNo_Text.text = kUserDefaults.retriveString(.QTR_NO)
        mobileNo_Text.delegate = self
        setvc()
        CallForGetComplaintCategoryAPI()
        complaintType_Text.setLeftPaddingPoints(10)
        complaintSubType_Text.setLeftPaddingPoints(10)
        complaintSubSubType_Text.setLeftPaddingPoints(10)
        quarterNo_Text.setLeftPaddingPoints(10)
        mobileNo_Text.setLeftPaddingPoints(10)
        complaintType_Text.isUserInteractionEnabled = false
        complaintSubType_Text.isUserInteractionEnabled = false
        complaintSubSubType_Text.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    
    
    private func setvc() {
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        print(newText.count)
        self.desTextCount.text = "\(newText.count)/100"
        return numberOfChars < 100    // 10 Limit Value
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
            CallForAddComplaintAPI()
        }
        
    }
    
    @IBAction func complaintHistoryBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
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
                    self.quarterNo_Lbl.text = "Quater Number"
                    self.quarterNo_Text.isUserInteractionEnabled = false
                    self.mobileNo_Text.text =  "\(self.INTERCOM_NO_RESIDENCE ?? 0 )"
                }else  if  self.complaintType_Text.text == "Office Equipment" {
                    self.quarterNo_Text.text = ""
                    self.quarterNo_Text.isUserInteractionEnabled = true
                    self.quarterNo_Lbl.text = "Office Location"
                    self.mobileNo_Text.text =  "\(self.INTERCOM_NO_OFFICE ?? 0)"
                }
                self.CallForGetComplaintSubCategoryAPI(CATEGORY: item.title)
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
extension ComplaintScreenVC: UITableViewDataSource , UITableViewDelegate {
    
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
extension ComplaintScreenVC {
    
    //MARK: - GetComplaintCategory API CALLING FUNCTIONS ------------------------------------------
    func CallForGetComplaintCategoryAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        
        ServiceRequest.shared.GetComplaintCategoryApi(nil, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.complaintArray = []
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                self.complaintDataArray = dict?["data"] as! [[String:Any]]
                for item in self.complaintDataArray {
                    let Name = item["CATEGORY"] as! String
                    self.complaintArray.append(Name)
                }
                self.setComplaintSetupDropDown()
            }else if (statuscode == 401){
                
                
            }else {
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
        
    }
    
    //MARK: - GetComplaintSubCategory API CALLING FUNCTIONS ------------------------------------------
    func CallForGetComplaintSubCategoryAPI(CATEGORY : String) {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let params : [String:Any]  = ["CATEGORY" : CATEGORY ]
        ServiceRequest.shared.GetComplaintSubCategoryApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.complaintSubArray = []
            let statuscode = dict?["statuscode"] as? Int
            
            if (statuscode == 200){
                self.complaintSubDataArray = dict?["data"] as! [[String:Any]]
                for item in self.complaintSubDataArray {
                    let Name = item["SUB_CATEGORY"] as! String
                    self.complaintSubArray.append(Name)
                }
                self.setComplaintSubCategorySetupDropDown()
            }else if (statuscode == 401){
                
                
            }else {
                self.createAlert(title: kAppName, message: kServerError)
                
            }
            
        })
    }
    
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
            let dict = response as! [String:Any]
            print("JSON: \(dict)")
            self.complaintSub_SubArray = []
            let statuscode = dict["statuscode"] as? Int
            if (statuscode == 200){
                self.complaintSub_SubDataArray = dict["data"] as! [[String:Any]]
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
    
    
    
    //MARK: - ADD COMPLAINT API CALLING FUNCTIONS ------------------------------------------
    func CallForAddComplaintAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        var params = [String:Any]()
        if  self.complaintType_Text.text == "Estate" {
            params  = [
                "GRADE" : kUserDefaults.retriveString(.GRADE) ,
                "COMPLAINT_CATEGORY_ID" : self.complaintSub_SubID ,
                "COMP_DESC" : des_Text.text ?? "" ,
                "REMARKS" : "" ,
                "QTR_NO" : self.quarterNo_Lbl.text ?? "" ,
                "OFFICE_LOCATION" : ""  ,
                "VENDOR_SERNO" : ""
            ]
        }else  if  self.complaintType_Text.text == "Office Equipment" {
            params = [
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
        ServiceRequest.shared.AddComplaintApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
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
                
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
}

extension ComplaintScreenVC : UITextFieldDelegate {
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




