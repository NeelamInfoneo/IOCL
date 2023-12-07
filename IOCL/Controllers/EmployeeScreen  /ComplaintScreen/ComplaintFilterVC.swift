//
//  ComplaintFilterVC.swift
//  IOCL
//
//  Created by neelam  on 16/03/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

protocol filterdataPass{
    func filterDataPassing(Complaint_Category :String , Complaint_Sub_Category :String ,Complaint_Sub_Sub_Category :String )
}

class ComplaintFilterVC: UIViewController {
    
    @IBOutlet weak var categoryText: UITextField!
    @IBOutlet weak var complaintSubType_Text: UITextField!
    @IBOutlet weak var complaintSubSubType_Text: UITextField!
    
    
    var delegate : filterdataPass!
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
        
        self.categoryText.setLeftPaddingPoints(10)
        self.complaintSubType_Text.setLeftPaddingPoints(10)
        self.complaintSubSubType_Text.setLeftPaddingPoints(10)
        CallForGetComplaintCategoryAPI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        self.delegate.filterDataPassing(Complaint_Category: categoryText.text ?? "", Complaint_Sub_Category: complaintSubType_Text.text ?? "", Complaint_Sub_Sub_Category: complaintSubSubType_Text.text ?? "")
        dismiss(animated: true)
        
    }
    
    @IBAction func exitBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func complaintTypeBtnAction(_ sender: UIButton) {
        
        if complaintdropDown != nil{
            complaintdropDown
                .setLayoutCell(width: 220)
                .show(self, targetView: sender)
        }
    }
    
    @IBAction func complaintSubCategoryBtnAction(_ sender: UIButton) {
        
        if categoryText.text == "" {
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
    
    //MARK: - FUNCTIONS -
    //MARK: - SET COMPLAINT DROPDOWN  --------------
    func setComplaintSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        complaintdropDown = BKDropDown.instance()
            .bind(complaintArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.categoryText.text = item.title
                print("item value \(item.title)")
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
            self.complaintDataArray = []
            self.complaintSubArray = []
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
                
                KRProgressHUD.dismiss()
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
            self.complaintSubArray = []
            self.complaintSub_SubArray = []
            let dict = response
            print("JSON: \(dict)")
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
                KRProgressHUD.dismiss()
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
        let params : [String:Any]  = ["CATEGORY" : CATEGORY ,
                                      "SUB_CATEGORY" : SUB_CATEGORY]
        
        ServiceRequest.shared.GetComplaintSubSubCategoryApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.complaintSub_SubArray = []
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
}

