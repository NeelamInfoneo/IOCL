//
//  ApproverVehicleApproveDetailsVC.swift
//  IOCL
//
//  Created by neelam  on 11/03/23.
//

import UIKit
import Alamofire
import KRProgressHUD

protocol updateDate{
    func updateApiData(ApiStatus :String)
}

class ApproverVehicleApproveDetailsVC: UIViewController , WWCalendarTimeSelectorProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var empNoLbl: UILabel!
    @IBOutlet weak var empNameLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    @IBOutlet weak var tripTypeLbl: UILabel!
    @IBOutlet weak var tripStartDateLbl: UILabel!
    @IBOutlet weak var tripEndDateLbl: UILabel!
    @IBOutlet weak var tripReasonLbl: UILabel!
    @IBOutlet weak var desText: UITextView!
    @IBOutlet weak var approveBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!

    var delegate:updateDate!
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var dataArray = [trip_request_list]()
    var CM_REQUESTID = Int()
    
    
    var empNoVale = Int()
    var empNameVale = String()
    var designationVale = String()
    var tripTypeVale = String()
    var tripStartDateVale = String()
    var tripEndDateVale = String()
    var tripReasonVale = String()
    var selectType = String()
    var tripStatus = String()

    var remarkValue = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        if tripStatus == "A0" {
            desText.text = remarkValue
            approveBtn.setTitle("Approved By Dept", for: .normal)
            rejectBtn.isHidden = true
            desText.isUserInteractionEnabled = false
            approveBtn.isUserInteractionEnabled = false
        }else  if tripStatus == "RJ0" {
            desText.text = remarkValue
            rejectBtn.setTitle("Rejected By Dept", for: .normal)
            approveBtn.isHidden = true
            rejectBtn.isHidden = false
        }else  if tripStatus == "A1" {
            desText.text = remarkValue
            approveBtn.setTitle("Approved By HR", for: .normal)
            rejectBtn.isHidden = true
        }else  if tripStatus == "RJ1" {
            desText.text = remarkValue
            rejectBtn.setTitle("Rejected By HR", for: .normal)
            approveBtn.isHidden = true
            rejectBtn.isHidden = false
        }else  if tripStatus == "Submitted" {
            rejectBtn.isHidden = false
            approveBtn.isHidden = false
        }else  if tripStatus == "A2" {
            desText.text = remarkValue
            approveBtn.setTitle("Partially Approved By HR", for: .normal)
            rejectBtn.isHidden = true
        }else  if tripStatus == "RJ2" {
            desText.text = remarkValue
            rejectBtn.setTitle("Partially Rejected By HR", for: .normal)
            approveBtn.isHidden = true
            rejectBtn.isHidden = false

        }
        empNoLbl.text = "EMP NO :- \(empNoVale)"
        empNameLbl.text = "EMP Name :- \(empNameVale)"
        designationLbl.text = designationVale
        tripTypeLbl.text = tripTypeVale
        tripStartDateLbl.text = tripStartDateVale
        tripEndDateLbl.text = tripEndDateVale
        tripReasonLbl.text =  "Trip Reason :- \(tripReasonVale)"
        CallForGetCarRequestByIdAPI()
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    @IBAction func ApproveBtnAction(_ sender: UIButton) {
        
        
        self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kApproveMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
            
        }, btnTwoTitle: "Approve") {_ in
            self.selectType = "A0"
            self.CallForCarRequestApproveByApproverAPI(selectType: self.selectType)
        }

        
    }
    @IBAction func rejectBtnAction(_ sender: UIButton) {
        self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kRejectMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
            
        }, btnTwoTitle: "Rejecte") {_ in
            self.selectType = "RJ0"
            self.CallForCarRequestApproveByApproverAPI(selectType: self.selectType)
        }
       
    }
    
    
    
    
}
//MARK: - TABLEV VIEW DATASOURCE -
extension ApproverVehicleApproveDetailsVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
        
        cell.DateLbl.text = dataArray[indexPath.row].CT_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        cell.timeLbl.text = dataArray[indexPath.row].CT_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "hh:mm") ?? ""
        cell.reportToVisitLbl.text = dataArray[indexPath.row].CT_PLACETO_VISIT ?? ""
        cell.placeToVisitLbl.text = dataArray[indexPath.row].CT_PLACETO_REPORT ?? ""
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
    
}


extension ApproverVehicleApproveDetailsVC {
    
    //MARK: - GetComplaint History API CALLING FUNCTIONS ------------------------------------------
    
    func CallForGetCarRequestByIdAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let url = "\(ApiLink.HOST_URL)\(GetCarRequestById)"
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(Token ?? "")",
            "Accept": "application/json"
        ]
        let params : [String:Any]  = [
            "CM_REQUESTID" : CM_REQUESTID ,
        ]
        
        ServiceRequest.shared.GetCarRequestByIdApi(params, completionHandler: { isSucess, response, errorMsg in
      
            KRProgressHUD.dismiss()
      
                let dict = response
                print("JSON: \(dict)")
                 let statuscode = dict?["statuscode"] as? Int
                if (statuscode == 200){
                    let data = dict?["data"] as! [String:Any]
                    let tripRequestList = data["trip_request_list"] as! [[String:Any]]
                    var Mobj = [trip_request_list]()
                    for item in tripRequestList {
                        let obj = trip_request_list.init(item)
                        Mobj.append(obj)
                    }
                    self.dataArray = Mobj
                    self.tableView.reloadData()
                }else if (statuscode == 401){
                }else {
                
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
    
    
    func CallForCarRequestApproveByApproverAPI(selectType :String) {
      
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(Token ?? "")",
            "Accept": "application/json"
        ]
        let params : [String:Any]  = [
            "CM_REQUESTID" : CM_REQUESTID ,
            "CM_INTAPPROVER_REMARKS": desText.text ?? "" ,
            "CM_STATUS": selectType
        ]
        
        ServiceRequest.shared.CarRequestApproveByApproverApi(params, completionHandler: { isSucess, response, errorMsg in
         
                let dict = response as! [String:Any]
                print("JSON: \(dict)")
                let statuscode = dict["statuscode"] as? Int
                let message = dict["message"] as? String

                if (statuscode == 200){
             
                    self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage: message ?? "", btnOneTitle: "Ok") {_ in
                        let data = dict["data"] as? [String:Any]
                        let tripRequestList = data?["trip_request_list"] as? [[String:Any]]
                        var Mobj = [trip_request_list]()
                        for item in tripRequestList ?? [] {
                            let obj = trip_request_list.init(item)
                            Mobj.append(obj)
                        }
                        self.dataArray = Mobj
                        self.tableView.reloadData()
                        self.delegate.updateApiData(ApiStatus: "1")
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

