//
//  ApproveOutStationDetails.swift
//  IOCL
//
//  Created by neelam  on 13/03/23.
//

import UIKit
import Alamofire
import KRProgressHUD

protocol outstationUpdateDate{
    func outstationUpdateApiData(ApiStatus :String)
}

class ApproveOutStationDetails: UIViewController , WWCalendarTimeSelectorProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var empNoLbl: UILabel!
    @IBOutlet weak var empNameLbl: UILabel!
    @IBOutlet weak var approveBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var designationLbl: UILabel!
    @IBOutlet weak var leaveTypeLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var endDateLbl: UILabel!
    @IBOutlet weak var purposeOfleaveLbl: UILabel!
    @IBOutlet weak var administrativeLbl: UILabel!
    @IBOutlet weak var approverLbl: UILabel!
    @IBOutlet weak var jobInCharge_1_Lbl: UILabel!
    @IBOutlet weak var jobInCharge_2_Lbl: UILabel!
    @IBOutlet weak var jobInCharge_3_Lbl: UILabel!
    @IBOutlet weak var jobInCharge_4_Lbl: UILabel!
    @IBOutlet weak var disterRoleLbl: UILabel!
    @IBOutlet weak var desText: UITextView!
    
    var delegate :outstationUpdateDate!
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var dataArray = [trip_request_list]()
    var outsttaionNo = String()
    var empNoValue = String()
    var empNameValue = String()
    var designationValue = String()
    var leaveTypeValue = String()
    var startDateValue = String()
    var endDateValue = String()
    var purposeOfleaveValue = String()
    var administrativeValue = String()
    var approverValue = String()
    var jobInCharge_1_Value = String()
    var jobInCharge_2_Value = String()
    var jobInCharge_3_Value = String()
    var jobInCharge_4_Value = String()
    var disterRoleValue = String()
    var tripStatus = String()
    var selectType = String()
    var remarkValue = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        if tripStatus == "Approved" {
            desText.text = remarkValue
            desText.isUserInteractionEnabled = false
            approveBtn.setTitle("APPROVED", for: .normal)
            rejectBtn.isHidden = true
            approveBtn.isUserInteractionEnabled = false
        }else  if tripStatus == "Rejected" {
            desText.text = remarkValue
            rejectBtn.setTitle("REJECTED", for: .normal)
            approveBtn.isHidden = true
        }else  if tripStatus == "Pending" {
            rejectBtn.isHidden = false
            approveBtn.isHidden = false
        }
        empNoLbl.text = "EMP NO :- \(empNoValue)"
        designationLbl.text = designationValue
        leaveTypeLbl.text = leaveTypeValue
        startDateLbl.text = startDateValue
        endDateLbl.text = endDateValue
        purposeOfleaveLbl.text = purposeOfleaveValue
        administrativeLbl.text = administrativeValue
        approverLbl.text = approverValue
        jobInCharge_1_Lbl.text = jobInCharge_1_Value
        jobInCharge_2_Lbl.text =  jobInCharge_2_Value
        jobInCharge_3_Lbl.text =   jobInCharge_3_Value
        jobInCharge_4_Lbl.text =  jobInCharge_4_Value
        disterRoleLbl.text = disterRoleValue
        empNameLbl.text = "EMP Name :- \(empNameValue)"
        
        //     CallForGetCarRequestByIdAPI()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    @IBAction func ApproveBtnAction(_ sender: UIButton) {
        
        self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kApproveMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
            
        }, btnTwoTitle: "Approve") {_ in
            self.selectType = "Approved"
            self.CallForOutstationRequestApproveByApproverAPI(selectType: self.selectType)
        }
        
        
    }
    @IBAction func rejectBtnAction(_ sender: UIButton) {
        
        self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kApproveMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
            
        }, btnTwoTitle: "Rejected") {_ in
            self.selectType = "Rejected"
            self.CallForOutstationRequestApproveByApproverAPI(selectType: self.selectType)
        }
        
    }
    
    
    
}
//MARK: - TABLEV VIEW DATASOURCE -
extension ApproveOutStationDetails: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
        
        cell.DateLbl.text = dataArray[indexPath.row].CT_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        cell.timeLbl.text = dataArray[indexPath.row].CT_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "hh:mm") ?? ""
        cell.reportToVisitLbl.text = dataArray[indexPath.row].CT_PLACETO_VISIT ?? ""
        cell.placeToVisitLbl.text = dataArray[indexPath.row].CT_PLACETO_REPORT ?? ""
        cell.vehicleTypeText.setLeftPaddingPoints(10)
        cell.vehicleNoText.setLeftPaddingPoints(10)
        cell.driverMobileNoText.setLeftPaddingPoints(10)
        cell.driverNameNoText.setLeftPaddingPoints(10)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
        
    }
    
    
}


extension ApproveOutStationDetails {
    
    //MARK: - GetComplaint History API CALLING FUNCTIONS ------------------------------------------
    
    func CallForOutstationRequestApproveByApproverAPI(selectType :String) {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        
        let params : [String:Any]  = [
            "OUTSTATION_NO" : outsttaionNo ,
            "APP_STATUS" : selectType,
            "APP_REMARKS" : desText.text ?? ""
        ]
        
        
        print(params)
        
        
        ServiceRequest.shared.OutstationRequestApproveByApproverApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            let message = dict?["message"] as? String
            if (statuscode == 200){
                self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage: message ?? "", btnOneTitle: "Ok") {_ in
                    self.delegate.outstationUpdateApiData(ApiStatus: "1")
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

