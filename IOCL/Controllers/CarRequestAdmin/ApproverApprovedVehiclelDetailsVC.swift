//
//  ApproverApprovedVehiclelDetailsVC.swift
//  IOCL
//
//  Created by neelam  on 12/03/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class ApproverApprovedVehiclelDetailsVC: UIViewController , WWCalendarTimeSelectorProtocol {
        
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
        var refreshControl = UIRefreshControl()
    
        var index = 0
        var vehicleArray : [[String:Any]] = []
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
        var remark = String()
       
        override func viewDidLoad() {
            super.viewDidLoad()
            if tripStatus == "A0" {
                desText.text = remark
                approveBtn.setTitle("Approved By Dept", for: .normal)
                desText.isUserInteractionEnabled = false
            }else  if tripStatus == "RJ0" {
                desText.text = remark
                rejectBtn.setTitle("Rejected By Dept", for: .normal)
                approveBtn.isHidden = true
                rejectBtn.isHidden = false
            }else  if tripStatus == "A1" {
                desText.text = remark
                approveBtn.setTitle("Approved By HR", for: .normal)
                rejectBtn.isHidden = true
            }else  if tripStatus == "RJ1" {
                desText.text = remark
                rejectBtn.setTitle("Rejected By HR", for: .normal)
                approveBtn.isHidden = true
                rejectBtn.isHidden = false
            }else  if tripStatus == "Submitted" {
                rejectBtn.isHidden = false
                approveBtn.isHidden = false
            }else  if tripStatus == "A2" {
                desText.text = remark
                approveBtn.setTitle("Partially Approved By HR", for: .normal)
                rejectBtn.isHidden = true
            }else  if tripStatus == "RJ2" {
                desText.text = remark
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
            desText.text = remark

            CallForGetCarRequestByIdAPI()
            refreshControl.attributedTitle = NSAttributedString(string: "")
            refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            tableView.addSubview(refreshControl) // not required when using UITableViewController
         }
        
        @objc func refresh(_ sender: AnyObject) {
            CallForGetCarRequestByIdAPI()
        }
        
        @IBAction func backBtnAction(_ sender: UIButton) {
            dismiss(animated: true)
            
        }
        
        @IBAction func ApproveBtnAction(_ sender: UIButton) {
            
            self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kApproveMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
                
            }, btnTwoTitle: "Approve") {_ in
        for i in 0...(self.dataArray.count)-1 {
                  var data : [String: Any] = [:]
            data["CT_VEHICLE_NAME"] = self.dataArray[i].vehicleModelAry?.CT_VEHICLE_NAME ?? ""
            data["CT_VEHICLE_NO"] = self.dataArray[i].vehicleModelAry?.CT_VEHICLE_NO ?? ""
            data["CT_DRIVER_NAME"] = self.dataArray[i].vehicleModelAry?.CT_DRIVER_NAME ?? ""
            data["CT_DRIVER_CONTACTNO"] = self.dataArray[i].vehicleModelAry?.CT_DRIVER_CONTACTNO ?? ""
            data["CT_SERIALNO"] =  self.dataArray[i].CT_SERIALNO
                data["CT_STATUS"] =  "A1"
                
            self.vehicleArray.append(data)
            print(self.vehicleArray)
                var set = Set<String>()
            self.vehicleArray = self.vehicleArray.compactMap {
                    guard let name = $0["CT_VEHICLE_NAME"] as? String else { return nil }
                   
                    return set.insert(name).inserted ? $0 : nil
                }
                }
                self.selectType = "A1"
                self.CallForCarRequestApproveByAdminAPI(selectType: self.selectType, vehicleArray: self.vehicleArray)
            }
            
        }
    
    
   
        @IBAction func rejectBtnAction(_ sender: UIButton) {
            
            if self.desText.text == "" {
                self.createAlert(title: kAppName, message: "Please enter remark")
            }else{
                self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kRejectMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
                    
                }, btnTwoTitle: "Rejecte") {_ in
                    self.selectType = "RJ1"
                    self.CallForCarRequestApproveByAdminAPI(selectType: self.selectType, vehicleArray: self.vehicleArray)
                }
            }
            
        }
        
        
        
    }
    //MARK: - TABLEV VIEW DATASOURCE -
    extension ApproverApprovedVehiclelDetailsVC: UITableViewDataSource , UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
            cell.setfortextfieldDelegate()
            cell.DateLbl.text = dataArray[indexPath.row].CT_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
            cell.timeLbl.text = dataArray[indexPath.row].CT_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "hh:mm") ?? ""
            cell.reportToVisitLbl.text = dataArray[indexPath.row].CT_PLACETO_VISIT ?? ""
            cell.placeToVisitLbl.text = dataArray[indexPath.row].CT_PLACETO_REPORT ?? ""
            cell.vehicleTypeText.setLeftPaddingPoints(10)
            cell.vehicleNoText.setLeftPaddingPoints(10)
            cell.driverMobileNoText.setLeftPaddingPoints(10)
            cell.driverNameNoText.setLeftPaddingPoints(10)
            cell.vehicleTypeText.text = dataArray[indexPath.row].CT_VEHICLE_NAME ?? ""
            cell.vehicleNoText.text = dataArray[indexPath.row].CT_VEHICLE_NO ?? ""
            cell.driverMobileNoText.text = dataArray[indexPath.row].CT_DRIVER_CONTACTNO ?? ""
            cell.driverNameNoText.text = dataArray[indexPath.row].CT_DRIVER_NAME ?? ""

            self.dataArray[indexPath.row].vehicleModelAry?.CT_VEHICLE_NAME = cell.vehicleTypeText.text
            self.dataArray[indexPath.row].vehicleModelAry?.CT_VEHICLE_NO =  cell.vehicleNoText.text
            self.dataArray[indexPath.row].vehicleModelAry?.CT_DRIVER_NAME =  cell.driverMobileNoText.text
            self.dataArray[indexPath.row].vehicleModelAry?.CT_DRIVER_CONTACTNO =  cell.driverNameNoText.text

//            cell.vehicleTypeText.text = dataArray[indexPath.row].CT_VEHICLE_NAME
//            cell.vehicleNoText.text =  dataArray[indexPath.row].CT_VEHICLE_NO
//            cell.driverMobileNoText.text = dataArray[indexPath.row].CT_DRIVER_CONTACTNO
//            cell.driverNameNoText.text = dataArray[indexPath.row].CT_DRIVER_NAME
            
           
            
            cell.CT_VEHICLE_NAMECallBack = { text in
                print(text)
                self.dataArray[indexPath.row].vehicleModelAry?.CT_VEHICLE_NAME = text
            }
            cell.CT_VEHICLE_NOCallBack = { text in
                print(text)
                self.dataArray[indexPath.row].vehicleModelAry?.CT_VEHICLE_NO = text
            }
            cell.CT_DRIVER_NAMECallBack = { text in
                print(text)
                self.dataArray[indexPath.row].vehicleModelAry?.CT_DRIVER_NAME = text
            }
            cell.CT_DRIVER_CONTACTNOCallBack = { text in
                print(text)
                self.dataArray[indexPath.row].vehicleModelAry?.CT_DRIVER_CONTACTNO = text
            }
            return cell
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 270
            
        }
        
    }

extension ApproverApprovedVehiclelDetailsVC {
    
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
    
    
    func CallForCarRequestApproveByAdminAPI(selectType :String , vehicleArray: [[String:Any]]) {

        let params : [String:Any]  = [
            "CM_REQUESTID" : CM_REQUESTID ,
            "CM_FINALAPPROVER_REMARKS": desText.text ?? "" ,
            "CM_STATUS": selectType ,
            "JsonString": vehicleArray.toJSONString()
        ]
        print(params)
        ServiceRequest.shared.CarRequestApproveByAdminApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            let message = dict?["message"] as? String
            if (statuscode == 200){
                self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage: message, btnOneTitle: "Ok") {_ in
                    self.dismiss(animated: true)
                }
            }else if (statuscode == 401){
            }else {
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
}
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}
