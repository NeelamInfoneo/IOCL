//
//  OutStationDetailsVC.swift
//  IOCL
//
//  Created by neelam  on 13/03/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class OutStationDetailsVC: UIViewController, WWCalendarTimeSelectorProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var empNoLbl: UILabel!
    @IBOutlet weak var empNameLbl: UILabel!
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
    
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var dataArray = [trip_request_list]()
    var CM_REQUESTID = Int()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
//MARK: - TABLEV VIEW DATASOURCE -
extension OutStationDetailsVC: UITableViewDataSource , UITableViewDelegate {
    
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


extension OutStationDetailsVC {
    
    
}

