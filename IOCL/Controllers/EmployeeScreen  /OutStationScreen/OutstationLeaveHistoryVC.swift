//
//  OutstationLeaveHistoryVC.swift
//  IOCL
//
//  Created by neelam  on 09/01/23.
//

import UIKit
import KRProgressHUD
import Alamofire
class OutstationLeaveHistoryVC: UIViewController  , WWCalendarTimeSelectorProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var startDate_Text: UITextField!
    @IBOutlet weak var endtDate_Text: UITextField!
    @IBOutlet weak var statusTxt: UITextField!

    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var selectType = String()
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var dataArray = [OutStationListingModel]()
    var vehicleArray = [String]()
    var vehicleID = Int()
    var vehicleDataArray = [[String:Any]]()
    var vehicledropDown:BKDropDown!
    var statusValue = String()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        startDate_Text.isUserInteractionEnabled = false
        endtDate_Text.isUserInteractionEnabled = false
        statusTxt.isUserInteractionEnabled = false
        CallForGetOutstationAPI()
        setvc()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
     }
    
    @objc func refresh(_ sender: AnyObject) {
        CallForGetOutstationAPI()
    }
    
    //MARK: - FUNCTIONS -
    private func setvc() {
        setOutStationSetupDropDown()
        startDate_Text.setLeftPaddingPoints(10)
        endtDate_Text.setLeftPaddingPoints(10)
        statusTxt.setLeftPaddingPoints(10)
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func tapOnNotificationBtn(_ sender: Any) {
     
        let vc = NotificationVC.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapOnAddBtn(_ sender: Any) {
     
        let vc = AddOutstationLeaveVC.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapEditBtnBtn(_ sender: UIButton) {
        let vc = EditOutStationVC.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: true)
        vc.LEAVE_TYPEValue = dataArray[sender.tag].LEAVE_TYPE ?? ""
        vc.FROM_DATEValue = dataArray[sender.tag].FROM_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "yyyy-MM-dd") ?? ""
        vc.FROM_TIMEValue = dataArray[sender.tag].FROM_TIME ?? ""
        vc.FROM_AMPMValue = dataArray[sender.tag].FROM_AMPM ?? ""
        vc.TO_DATEValue = dataArray[sender.tag].TO_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "yyyy-MM-dd") ?? ""
        vc.TO_TIMEValue = dataArray[sender.tag].TO_TIME ?? ""
        vc.TO_AMPMValue = dataArray[sender.tag].TO_AMPM ?? ""
        vc.PURPOSEValue = dataArray[sender.tag].PURPOSE ?? ""
        vc.RESPONSIBILITYValue = dataArray[sender.tag].RESPONSIBILITY ?? ""
        vc.DISASTER_COValue = dataArray[sender.tag].DISASTER_CO ?? ""
        vc.DESTINATIONValue = dataArray[sender.tag].DESTINATION ?? ""
        vc.REMARKSValue = dataArray[sender.tag].REMARKS ?? ""
        vc.ADMIN_RES_EMPNOValue = dataArray[sender.tag].ADMIN_RES_EMPNO ?? 0
        vc.ADMIN_RES_NAMEValue  = dataArray[sender.tag].ADMIN_RES_NAME ?? ""
        vc.JOB_IC_1_EMPNOValue = Int(dataArray[sender.tag].JOB_IC_1_EMPNO ?? "") ?? 0
        vc.JOB_IC_1Value = dataArray[sender.tag].JOB_IC_1 ?? ""
        vc.JOB_IC_2_EMPNOValue = Int(dataArray[sender.tag].JOB_IC_2_EMPNO ?? "") ?? 0
        vc.JOB_IC_2Value = dataArray[sender.tag].JOB_IC_2 ?? ""
        vc.JOB_IC_3_EMPNOValue = Int(dataArray[sender.tag].JOB_IC_3_EMPNO ?? "") ?? 0
        vc.JOB_IC_3Value =  dataArray[sender.tag].JOB_IC_3 ?? ""
        vc.JOB_IC_4_EMPNOValue = Int(dataArray[sender.tag].JOB_IC_4_EMPNO ?? "") ?? 0
        vc.JOB_IC_4Value =  dataArray[sender.tag].JOB_IC_4 ?? ""
        vc.APPROVERValue = dataArray[sender.tag].ApproverName ?? ""
        vc.JOB_IC_1_Name = dataArray[sender.tag].JOB_IC_1_Name ?? ""
        vc.JOB_IC_2_Name = dataArray[sender.tag].JOB_IC_2_Name ?? ""
        vc.JOB_IC_3_Name = dataArray[sender.tag].JOB_IC_3_Name ?? ""
        vc.JOB_IC_4_Name = dataArray[sender.tag].JOB_IC_4_Name ?? ""
        vc.Token = UserDefaults.standard.value(forKey: "Token") as? String
        
    }
    
    @IBAction func tapViewDetailsAddBtn(_ sender: UIButton) {
     
        let vc = OutStationDetailsVC.instantiate(fromAppStoryboard: .User)
        vc.empNoValue =  dataArray[sender.tag].EMPNO ?? ""
        vc.designationValue =  dataArray[sender.tag].DESTINATION ?? ""
        vc.leaveTypeValue =  dataArray[sender.tag].LEAVE_TYPE ?? ""
        let startDate = dataArray[sender.tag].TO_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        let fromTime = dataArray[sender.tag].FROM_TIME ?? ""
        let from_AMPM = dataArray[sender.tag].FROM_AMPM ?? ""
        let endDate = dataArray[sender.tag].FROM_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        let toTime = dataArray[sender.tag].TO_DATE ?? ""
        let to_AMPM = dataArray[sender.tag].TO_TIME ?? ""
        vc.startDateValue =  dataArray[sender.tag].FROM_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        
        vc.endDateValue = "\(startDate) \(fromTime) \(from_AMPM)"
        vc.purposeOfleaveValue = dataArray[sender.tag].PURPOSE ?? ""
        vc.administrativeValue =  dataArray[sender.tag].RESPONSIBILITY ?? ""
        vc.approverValue =  dataArray[sender.tag].ApproverName ?? ""
        vc.jobInCharge_1_Value =  dataArray[sender.tag].JOB_IC_1 ?? ""
        vc.jobInCharge_2_Value =  dataArray[sender.tag].JOB_IC_2 ?? ""
        vc.jobInCharge_3_Value =  dataArray[sender.tag].JOB_IC_3 ?? ""
        vc.jobInCharge_4_Value =  dataArray[sender.tag].JOB_IC_4 ?? ""
        vc.disterRoleValue =  dataArray[sender.tag].DISASTER_CO ?? ""
        vc.modalPresentationStyle = .custom
        self.navigationController?.present(vc, animated: false)    }
    
    @IBAction func tapOnStartDateBtn(_ sender: Any) {
        selectType = "SelectStartDate"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        present(selector, animated: true, completion: nil)
    }
    
    @IBAction func tapOnEndDateBtn(_ sender: Any) {
        selectType = "SelectEndDate"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        present(selector, animated: true, completion: nil)
        
    }
    
    //MARK: - SELECT TIME -
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        print("Selected \n\(date)\n---")
        singleDate = date
        if selectType == "SelectStartDate" {
            self.startDate_Text.text = date.stringFromFormat("yyyy-MM-dd")
            self.CallForGetOutstationAPI()
            self.tableView.reloadData()
        }else if selectType == "SelectEndDate" {
            self.endtDate_Text.text = date.stringFromFormat("yyyy-MM-dd")
            self.CallForGetOutstationAPI()
            self.tableView.reloadData()
        }
       
    }
    
    
    @IBAction func statusTypeBtnAction(_ sender: UIButton) {
        
        if vehicledropDown != nil{
            vehicledropDown
                .setLayoutCell(width: sender.frame.width)
            .show(self, targetView: sender)
        }
    }
    
    
    //MARK: - SET COMPLAINT DROPDOWN  --------------
    func setOutStationSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        vehicledropDown = BKDropDown.instance()
            .bind(["Approved" , "Pending","Rejected"])
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.statusTxt.text = item.title
                print("item value \(item.title)")
                self.statusValue = item.title
                self.CallForGetOutstationAPI()
                dropDown.hide()
            })
      }
  }

//MARK: - TABLEV VIEW DATASOURCE -
extension OutstationLeaveHistoryVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
        cell.destinationtext.text = "\(dataArray[indexPath.row].DESTINATION ?? "")"
        cell.approvertext.text = "\(dataArray[indexPath.row].ApproverName ?? "")"
        cell.destext.text = dataArray[indexPath.row].PURPOSE
        cell.leaveTypetext.text = dataArray[indexPath.row].LEAVE_TYPE
        
        cell.titletext.text = "Reuqest No. \(dataArray[indexPath.row].OUTSTATION_NO ?? "")"
        cell.statustext.text = dataArray[indexPath.row].APP_STATUS
        
        let FROMdate = dataArray[indexPath.row].FROM_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        let FROM_TIME = dataArray[indexPath.row].FROM_TIME
        let FROM_AMPM = dataArray[indexPath.row].FROM_AMPM
        
        let TOdate = dataArray[indexPath.row].TO_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        let TO_TIME = dataArray[indexPath.row].TO_TIME
        let TO_AMPM = dataArray[indexPath.row].TO_AMPM
        cell.datetext.text = (FROMdate) + " - " + (TOdate)
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
        
    }
    
    
}
extension OutstationLeaveHistoryVC {
    
    
    


    
    //MARK: - CallForGetOutstationAPI History API CALLING FUNCTIONS ------------------------------------------
    func CallForGetOutstationAPI() {
        let param = [
//            "PageIndex": 0 ,
//            "PageSize": 10,
            "CM_TRIP_STARTDT": startDate_Text.text ?? "",
            "CM_TRIP_ENDDT": endtDate_Text.text ?? "",
            "IsApprover": ""  ,
            "IsAdmin": "" ,
            "APP_STATUS" : statusTxt.text ?? ""
        ] as [String : Any]
       print(param)
        
        ServiceRequest.shared.GetOutstationApi(param, completionHandler: { isSucess, response, errorMsg in
            self.refreshControl.endRefreshing()
                let dict = response
                print("JSON: \(dict)")
                let statuscode = dict?["statuscode"] as? Int
                let message = dict?["message"] as? String
                if (statuscode == 200){
                   let data = dict?["data"] as! [[String:Any]]
                    var Mobj = [OutStationListingModel]()
                    for item in data {
                        let obj = OutStationListingModel.init(item)
                        Mobj.append(obj)
                    }
                    self.dataArray = Mobj
                    self.tableView.reloadData()
                }else if (statuscode == 401){
                    
                }else {
                    self.refreshControl.endRefreshing()
                self.createAlert(title: kAppName, message: message ?? "")
            }
        })
    }
}




