//
//  ApproverOutStationListVC.swift
//  IOCL
//
//  Created by neelam  on 12/03/23.
//

import UIKit
import KRProgressHUD
import Alamofire

class ApproverOutStationListVC: UIViewController  , WWCalendarTimeSelectorProtocol, outstationUpdateDate {
    func outstationUpdateApiData(ApiStatus: String) {
        if ApiStatus == "1" {
            self.CallForGetOutstationAPI()
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var startDate_Text: UITextField!
    @IBOutlet weak var endtDate_Text: UITextField!
    @IBOutlet weak var statusTxt: UITextField!
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var selectType = String()
    var vehicleArray = [String]()
    var vehicleID = Int()
    var vehicleDataArray = [[String:Any]]()
    var vehicledropDown:BKDropDown!
    var statusValue = String()
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var refreshControl = UIRefreshControl()
    
    var IsApproverAdmin = UserDefaults.standard.value(forKey: "IsApproverAdmin") as? Bool
    var dataArray = [OutStationListingModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setvc()
        // Do any additional setup after loading the view.
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CallForGetOutstationAPI()
    }
    @objc func refresh(_ sender: AnyObject) {
        CallForGetOutstationAPI()
    }
    
    //MARK: - FUNCTIONS -
    private func setvc() {
        setVehicleSetupDropDown()
        topView.roundCornerBottom(30)
        startDate_Text.setLeftPaddingPoints(10)
        endtDate_Text.setLeftPaddingPoints(10)
        statusTxt.setLeftPaddingPoints(10)
        topView.backgroundColor = .appColor(.appOrange)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func tapOnNotificationBtn(_ sender: Any) {
        
        let vc = NotificationVC.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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
    @IBAction func tapViewDetailsAddBtn(_ sender: UIButton) {
        
        let vc = ApproveOutStationDetails.instantiate(fromAppStoryboard: .Approver)
        vc.delegate = self
        vc.empNameValue = dataArray[sender.tag - 100].EmployeeName ?? ""
        vc.outsttaionNo = dataArray[sender.tag - 100].OUTSTATION_NO ?? ""
        vc.empNoValue =  dataArray[sender.tag - 100].EMPNO ?? ""
        vc.designationValue =  dataArray[sender.tag - 100].DESTINATION ?? ""
        vc.leaveTypeValue =  dataArray[sender.tag - 100].LEAVE_TYPE ?? ""
        let startDate = dataArray[sender.tag - 100].TO_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        let fromTime = dataArray[sender.tag - 100].FROM_TIME ?? ""
        let from_AMPM = dataArray[sender.tag - 100].FROM_AMPM ?? ""
        let endDate = dataArray[sender.tag - 100].FROM_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        let toTime = dataArray[sender.tag - 100].TO_DATE ?? ""
        let to_AMPM = dataArray[sender.tag - 100].TO_TIME ?? ""
        vc.startDateValue =  dataArray[sender.tag - 100].FROM_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        
        vc.endDateValue = "\(startDate) \(fromTime) \(from_AMPM)"
        vc.purposeOfleaveValue = dataArray[sender.tag - 100].PURPOSE ?? ""
        vc.administrativeValue =  dataArray[sender.tag - 100].RESPONSIBILITY ?? ""
        vc.approverValue =  dataArray[sender.tag - 100].ApproverName ?? ""
        vc.jobInCharge_1_Value =  dataArray[sender.tag - 100].JOB_IC_1 ?? ""
        vc.jobInCharge_2_Value =  dataArray[sender.tag - 100].JOB_IC_2 ?? ""
        vc.jobInCharge_3_Value =  dataArray[sender.tag - 100].JOB_IC_3 ?? ""
        vc.jobInCharge_4_Value =  dataArray[sender.tag - 100].JOB_IC_4 ?? ""
        vc.disterRoleValue =  dataArray[sender.tag - 100].DISASTER_CO ?? ""
        vc.remarkValue =  dataArray[sender.tag - 100].APP_REMARKS ?? ""
        vc.tripStatus =  dataArray[sender.tag - 100].APP_STATUS ?? ""
        
        vc.modalPresentationStyle = .custom
        self.navigationController?.present(vc, animated: false)
        
    }
    
    //MARK: - SELECT TIME -
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        print("Selected \n\(date)\n---")
        singleDate = date
        if selectType == "SelectStartDate" {
            self.startDate_Text.text = date.stringFromFormat("yyyy-MM-dd")
        }else if selectType == "SelectEndDate" {
            self.endtDate_Text.text = date.stringFromFormat("yyyy-MM-dd")
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
    func setVehicleSetupDropDown() {
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
extension ApproverOutStationListVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
        cell.detailsBtn.tag = indexPath.row + 100
        cell.destinationtext.text = "\(dataArray[indexPath.row].DESTINATION ?? "")"
        cell.approvertext.text = "\(dataArray[indexPath.row].APPROVER ?? "")"
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
        cell.datetext.text = "Date - " + (FROMdate) + " - " + (TOdate)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    
}
extension ApproverOutStationListVC {
    
    //MARK: - CallForGetOutstationAPI History API CALLING FUNCTIONS ------------------------------------------
    
    func CallForGetOutstationAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        
        let param = [
            "PageIndex": "",
            "PageSize": "",
            "FROM_DATE":"",
            "TO_DATE": "",
            "IsApprover": "true",
            "IsAdmin": "" ,
            "APP_STATUS" : statusTxt ?? ""
        ] as [String : Any]
        print(param)
        ServiceRequest.shared.GetOutstationApi(param, completionHandler: { isSucess, response, errorMsg in
            
            KRProgressHUD.dismiss()
            
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
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
                
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
}
