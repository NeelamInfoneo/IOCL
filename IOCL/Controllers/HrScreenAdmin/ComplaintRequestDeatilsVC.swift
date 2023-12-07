//
//  ComplaintRequestDeatilsVC.swift
//  IOCL
//
//  Created by neelam  on 15/03/23.
//

import UIKit
import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

protocol updateComplanintrequest {
    func updateComplanintRequestDataPass(Status : String)
}


class ComplaintRequestDeatilsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allocatedBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var empNOLbl: UILabel!
    @IBOutlet weak var empNameLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    @IBOutlet weak var companyCategoryLbl: UILabel!
    @IBOutlet weak var companySubCategoryLbl: UILabel!
    @IBOutlet weak var companySubSubCategoryLbl: UILabel!
    @IBOutlet weak var officeLocationLbl: UILabel!
    @IBOutlet weak var qtrNoLbl: UILabel!
    @IBOutlet weak var vendorText: UITextField!
    @IBOutlet weak var desText: UITextView!
    @IBOutlet weak var remarkText: UITextView!
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    
    var delagte : updateComplanintrequest!
    var  selectType = String()
    //MARK: - COMPLAINT VARIABLES -
    var vendotrArray = [String]()
    var vendotrID = Int()
    var vendotrDataArray = [[String:Any]]()
    var vendotrdropDown:BKDropDown!
    var complaintID = Int()
    var empNOValue = Int()
    var empNameValue = String()
    var designationValue = String()
    var companyCategoryValue = String()
    var companySubCategoryValue = String()
    var companySubSubCategoryValue = String()
    var officeLocationValue = String()
    var complaintStatus = String()
    var complaintStatusID = Int()
    var QTRNO = String()
    var Remark = String()
    var Vendor_Name = String()
    var companyDes = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        vendorText.setLeftPaddingPoints(10)
        empNOLbl.text = "Emplopyee No.\(empNOValue)"
        empNameLbl.text = empNameValue
        designationLbl.text = designationValue
        companyCategoryLbl.text = companyCategoryValue
        companySubCategoryLbl.text = companySubCategoryValue
        companySubSubCategoryLbl.text = companySubSubCategoryValue
        officeLocationLbl.text = officeLocationValue
        qtrNoLbl.text = QTRNO
        desText.text =  companyDes
        remarkText.text =  Remark
        vendorText.text =  Vendor_Name
        
        if complaintStatus == "Job Allocated" {
            allocatedBtn.setTitle("Job Already Allocated", for: .normal)
            allocatedBtn.isUserInteractionEnabled = false
            rejectBtn.isHidden = true
        }else  if complaintStatus == "Completed" {
            allocatedBtn.setTitle("Completed", for: .normal)
            allocatedBtn.isUserInteractionEnabled = false
            rejectBtn.isHidden = true
        }else  if complaintStatus == "Rejected" {
            allocatedBtn.setTitle("Rejected", for: .normal)
            allocatedBtn.isUserInteractionEnabled = false
            allocatedBtn.isHidden = true
        }
        
        CallForGetVendorMasterAPI()
        
    }
    
    func setUpUI(){
        if selectType == "Complaint Details" {
            rejectBtn.isHidden = true
            allocatedBtn.isHidden = true            
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    @IBAction func ApproveBtnAction(_ sender: UIButton) {
        self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kAllocatedMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
            
        }, btnTwoTitle: "Job Allocated") {_ in
            self.complaintStatusID = 2
            
            self.CallForGetUpdateComplaintStatusAPI()
            
            
        }
        
        
    }
    @IBAction func rejectBtnAction(_ sender: UIButton) {
        
        if self.remarkText.text == "" {
            self.createAlert(title: kAppName, message: "Please enter remark")
        }else{
            self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kRejectMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
                
            }, btnTwoTitle: "Rejecte") {_ in
                self.complaintStatusID = 4
                self.CallForGetUpdateComplaintStatusAPI()
            }
            
        }
        
        
    }
    
    
    @IBAction func venderBtnAction(_ sender: UIButton) {
        if vendotrdropDown != nil{
            vendotrdropDown
                .setLayoutCell(width: sender.frame.width)
                .show(self, targetView: sender)
        }
    }
    
    //MARK: - SET COMPLAINT DROPDOWN  --------------
    func setVendorSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        vendotrdropDown = BKDropDown.instance()
            .bind(vendotrArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.vendorText.text = item.title
                for item in self.vendotrDataArray {
                    let Name = item["VENDOR_NAME"] as! String
                    if Name == self.vendorText.text {
                        let Id = item["VENDOR_SERNO"] as! Int
                        self.vendotrID = Id
                    }
                }
                dropDown.hide()
            })
    }
    
    
}
//MARK: - TABLEV VIEW DATASOURCE -
extension ComplaintRequestDeatilsVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
        
    }
    
    
}

extension ComplaintRequestDeatilsVC  {
    //MARK: - GetComplaintSubSubCategory API CALLING FUNCTIONS ------------------------------------------
    func CallForGetVendorMasterAPI() {

        let url = "\(ApiLink.HOST_URL)\(GetVendorMaster)"
        
        ServiceRequest.shared.GetVendorMasterApi(nil, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.vendotrArray = []
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                self.vendotrDataArray = dict?["data"] as! [[String:Any]]
                for item in self.vendotrDataArray {
                    let Name = item["VENDOR_NAME"] as! String
                    self.vendotrArray.append(Name)
                }
                self.setVendorSetupDropDown()
            }else if (statuscode == 401){
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
    
    
    func CallForGetUpdateComplaintStatusAPI() {

        let params : [String:Any]  = [
            "COMP_ID" : complaintID ,
            "COMPLAINT_STATUS_ID" : complaintStatusID ,
            "VENDOR_SERNO" : vendotrID ,
            "REMARKS" : desText.text ?? ""
        ]
        print(params)
      
        ServiceRequest.shared.UpdateComplaintStatusApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.vendotrArray = []
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage: "Job Allocated Successfully!", btnOneTitle: "Ok") {_ in
                    self.delagte.updateComplanintRequestDataPass(Status: "1")
                    self.dismiss(animated: true)
                }
            }else if (statuscode == 401){
            }else {
                
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
    
}
