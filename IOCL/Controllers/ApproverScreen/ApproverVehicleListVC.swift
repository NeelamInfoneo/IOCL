//
//  ApproverVehicleListVC.swift
//  IOCL
//
//  Created by neelam  on 11/03/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class ApproverVehicleListVC: UIViewController  , WWCalendarTimeSelectorProtocol ,updateDate{
    func updateApiData(ApiStatus: String) {
        if ApiStatus == "1" {
            CallForGetCarRequestsAPI()
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
    var CM_STATUS = String()
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var IsApproverAdmin = UserDefaults.standard.value(forKey: "IsApproverAdmin") as? Bool
    
    var dataArray = [VehicleListingModel]()
    var vehicleArray = [String]()
    var vehicleID = String()
    var vehicleDataArray = [[String:Any]]()
    var vehicledropDown:BKDropDown!
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setvc()
        startDate_Text.setLeftPaddingPoints(10)
        endtDate_Text.setLeftPaddingPoints(10)
        statusTxt.setLeftPaddingPoints(10)
        CallForGetCarRequestsAPI()
        setVehicleSetupDropDown()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(_ sender: AnyObject) {
        CallForGetCarRequestsAPI()
    }
    //MARK: - FUNCTIONS -
    private func setvc() {
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func vehicleDetailsBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Approver", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ApproverVehicleApproveDetailsVC") as! ApproverVehicleApproveDetailsVC
        viewController.CM_REQUESTID = dataArray[sender.tag - 100].CM_REQUESTID ?? 0
        viewController.empNoVale = dataArray[sender.tag - 100].CM_EMPNO ?? 0
        viewController.empNameVale = dataArray[sender.tag - 100].CM_NAME ?? ""
        viewController.designationVale = dataArray[sender.tag - 100].CM_DESIGNATION ?? ""
        viewController.tripTypeVale = dataArray[sender.tag - 100].CM_TRIPTYPE ?? ""
        viewController.tripStartDateVale = dataArray[sender.tag - 100].CM_TRIP_STARTDT ?? ""
        viewController.tripEndDateVale = dataArray[sender.tag - 100].CM_TRIP_ENDDT ?? ""
        viewController.tripReasonVale = dataArray[sender.tag - 100].CM_TRIP_REASON ?? ""
        viewController.tripStatus = dataArray[sender.tag - 100].CM_STATUS ?? ""
        viewController.remarkValue = dataArray[sender.tag - 100].CM_INTAPPROVER_REMARKS ?? ""
        viewController.delegate = self
        viewController.modalPresentationStyle = .custom
        self.navigationController?.present(viewController, animated: false)
        
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
    
    
    //MARK: - SELECT TIME -
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        if selectType == "SelectStartDate" {
            self.startDate_Text.text = date.stringFromFormat("yyyy-MM-dd")
            self.CallForGetCarRequestsAPI()
        }else if selectType == "SelectEndDate" {
            self.endtDate_Text.text = date.stringFromFormat("yyyy-MM-dd")
            self.CallForGetCarRequestsAPI()
        }
        
    }
    
    @IBAction func statusTypeBtnAction(_ sender: UIButton) {
        if vehicledropDown != nil{
            vehicledropDown
                .setLayoutCell(width: 200)
                .show(self, targetView: sender)
        }
    }
    
    
    //MARK: - SET COMPLAINT DROPDOWN  --------------
    func setVehicleSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        vehicledropDown = BKDropDown.instance()
            .bind(vehicleArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.statusTxt.text = item.title
                print("item value \(item.title)")
                self.CM_STATUS = item.title
                for item in self.vehicleDataArray {
                    let Name = item["Name"] as! String
                    if Name == self.CM_STATUS {
                        let Id = item["Id"] as! String
                        self.vehicleID = Id
                    }
                }
                self.CallForGetCarRequestsAPI()
                dropDown.hide()
            })
    }
}
//MARK: - TABLEV VIEW DATASOURCE -
extension ApproverVehicleListVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
        
        
        let endDate = dataArray[indexPath.row].CM_TRIP_ENDDT?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        
        let startDate = dataArray[indexPath.row].CM_TRIP_STARTDT?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss" , convertTo: "dd/MM/YYYY") ?? ""
        
        cell.tripDetailsBtn.tag = indexPath.row + 100
        cell.endDateText.text = "Trip Date : \(endDate) - \(startDate)"
        cell.reqIDText.text = "Request No. - \(dataArray[indexPath.row].CM_REQUESTID ?? 0)"
        cell.descText.text = dataArray[indexPath.row].CM_TRIP_REASON ?? ""
        cell.tripTypeText.text = "\(dataArray[indexPath.row].CM_TRIPTYPE ?? "")"
        
        let  CM_STATUS = dataArray[indexPath.row].CM_STATUS  ?? ""
        if CM_STATUS == "P" {
            cell.currentStatusText.text = "Submitted"
        }else if CM_STATUS == "A0" {
            cell.currentStatusText.text = "Approved By Dept"
        }else if CM_STATUS == "RJ0" {
            cell.currentStatusText.text = "Rejected By Dept"
        }else if CM_STATUS == "A1" {
            cell.currentStatusText.text = "Approved By HR"
        }else if CM_STATUS == "RJ1" {
            cell.currentStatusText.text = "Rejected By HR"
        }else if CM_STATUS == "A2" {
            cell.currentStatusText.text = "Partially Approved By HR"
        }else if CM_STATUS == "RJ2" {
            cell.currentStatusText.text = "Partially Rejected By HR"
        }
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
    
    
}


extension ApproverVehicleListVC {
    
    
    //MARK: - GetCarRequestStatus API CALLING FUNCTIONS ------------------------------------------
    func CallForGetCarRequestStatusAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let url = "\(ApiLink.HOST_URL)\(GetCarRequestStatus)"
        ServiceRequest.shared.GetCarRequestStatusApi(nil, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.vehicleArray = []
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                self.vehicleDataArray = dict?["data"] as! [[String:Any]]
                for item in self.vehicleDataArray {
                    let Name = item["Name"] as! String
                    self.vehicleArray.append(Name)
                }
                self.setVehicleSetupDropDown()
            }else if (statuscode == 401){
                
                
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
            
        })
        
    }
    
    //MARK: - GetComplaint History API CALLING FUNCTIONS ------------------------------------------
    func CallForGetCarRequestsAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let url = "\(ApiLink.HOST_URL)\(GetCarRequests)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Token ?? "")",
            "Accept": "application/json"
        ]
        let param = [
            "PageIndex": 1 ,
            "PageSize": 10,
            "CM_TRIP_STARTDT": startDate_Text.text ?? "",
            "CM_TRIP_ENDDT": endtDate_Text.text ?? "",
            "IsApprover": "true" ,
            "IsAdmin": "" ,
            "CM_STATUS" : vehicleID
        ] as [String : Any]
        
        print(param)
        print(url)
        print(headers)
        ServiceRequest.shared.GetCarRequestsApi(param, completionHandler: { isSucess, response, errorMsg in
            
            KRProgressHUD.dismiss()
            
            self.refreshControl.endRefreshing()
            
            self.dataArray = []
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                let data = dict?["data"] as! [[String:Any]]
                var Mobj = [VehicleListingModel]()
                for item in data {
                    let obj = VehicleListingModel.init(item)
                    Mobj.append(obj)
                }
                self.dataArray = Mobj
                self.CallForGetCarRequestStatusAPI()
                self.tableView.reloadData()
            }else if (statuscode == 401){
            }else {
                
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
}

