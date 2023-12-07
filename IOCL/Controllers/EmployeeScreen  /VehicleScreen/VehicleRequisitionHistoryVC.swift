//
//  VehicleRequisitionHistoryVC.swift
//  IOCL
//
//  Created by neelam  on 09/01/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class VehicleRequisitionHistoryVC: UIViewController , WWCalendarTimeSelectorProtocol , vehicleDataPass{
    func vehicleDataPassing(Status: String) {
       CallForGetCarRequestStatusAPI()
    }
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var startDate_Text: UITextField!
    @IBOutlet weak var endtDate_Text: UITextField!
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    @IBOutlet weak var statusTxt: UITextField!
    let refreshControl = UIRefreshControl()
    var selectType = String()
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var dataArray = [VehicleListingModel]()
    var CM_STATUS = String()
    var vehicleArray = [String]()
    var vehicleID = String()
    var vehicleDataArray = [[String:Any]]()
    var vehicledropDown:BKDropDown!

    override func viewDidLoad() {
        super.viewDidLoad()
        startDate_Text.isUserInteractionEnabled = false
        endtDate_Text.isUserInteractionEnabled = false
        statusTxt.isUserInteractionEnabled = false
        setvc()
        startDate_Text.setLeftPaddingPoints(10)
        endtDate_Text.setLeftPaddingPoints(10)
        statusTxt.setLeftPaddingPoints(10)
        CallForGetCarRequestsAPI()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
     }
    
    @objc func refresh(_ sender: AnyObject) {
        CallForGetCarRequestsAPI()
    }
    
    //MARK: - FUNCTIONS -
    private func setvc() {
      ///  setVehicleSetupDropDown()
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func vehicleDetailsBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VehicleRequestDetailsVC") as! VehicleRequestDetailsVC
        viewController.CM_REQUESTID = dataArray[sender.tag - 100].CM_REQUESTID ?? 0
        viewController.modalPresentationStyle = .custom
        self.navigationController?.present(viewController, animated: false)

    }
    
    
    @IBAction func editBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditVehicleRequestVC") as! EditVehicleRequestVC
        viewController.CM_REQUESTID = dataArray[sender.tag - 1000].CM_REQUESTID ?? 0
        self.navigationController?.pushViewController(viewController, animated: true)


    }
    @IBAction func tapOnNotificationBtn(_ sender: Any) {
        let vc = NotificationVC.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapToAddBtntn(_ sender: Any) {
        let vc = VehicleRequisitionVC.instantiate(fromAppStoryboard: .User)
        vc.delegate = self
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
            self.tableView.reloadData()
        }else if selectType == "SelectEndDate" {
            self.endtDate_Text.text = date.stringFromFormat("yyyy-MM-dd")
            self.CallForGetCarRequestsAPI()
            self.tableView.reloadData()
        }
       
    }
    
    @IBAction func statusTypeBtnAction(_ sender: UIButton) {
        if vehicledropDown != nil{
            vehicledropDown
                .setLayoutCell(width: 220)
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
extension VehicleRequisitionHistoryVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
        let endDate = dataArray[indexPath.row].CM_TRIP_ENDDT?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        let startDate = dataArray[indexPath.row].CM_TRIP_STARTDT?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss" , convertTo: "dd/MM/YYYY") ?? ""
        cell.tripDetailsBtn.tag = indexPath.row + 100
        cell.editIconBtn.tag = indexPath.row + 1000
        cell.endDateText.text = "Trip Date : \(startDate) - \(endDate)"
        cell.reqIDText.text = "Request No. - \(dataArray[indexPath.row].CM_REQUESTID ?? 0)"
        cell.descText.text = dataArray[indexPath.row].CM_TRIP_REASON ?? ""
        let  CM_STATUS = dataArray[indexPath.row].CM_STATUS  ?? ""
        if CM_STATUS == "P" {
            cell.editIconBtn.isHidden = false
            cell.currentStatusText.text = "Submitted"
        }else if CM_STATUS == "A0" {
            cell.editIconBtn.isHidden = true
            cell.currentStatusText.text = "Approved By Dept"
        }else if CM_STATUS == "RJ0" {
            cell.editIconBtn.isHidden = true
            cell.currentStatusText.text = "Rejected By Dept"
            cell.currentStatusText.textColor = .appColor(.appRed)
        }else if CM_STATUS == "A1" {
            cell.editIconBtn.isHidden = true
            cell.currentStatusText.text = "Approved By HR"
        }else if CM_STATUS == "RJ1" {
            cell.editIconBtn.isHidden = true
            cell.currentStatusText.text = "Rejected By HR"
            cell.currentStatusText.textColor = .appColor(.appRed)
        }else if CM_STATUS == "A2" {
            cell.editIconBtn.isHidden = true
            cell.currentStatusText.text = "Partially Approved By HR"
        }else if CM_STATUS == "RJ2" {
            cell.editIconBtn.isHidden = true
            cell.currentStatusText.text = "Partially Rejected By HR"
        }
        cell.tripTypeText.text = "\(dataArray[indexPath.row].CM_TRIPTYPE ?? "")"
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
    
    
}


extension VehicleRequisitionHistoryVC {
    
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
        let param = [
            "PageIndex": 1 ,
            "PageSize": 10,
            "CM_TRIP_STARTDT": startDate_Text.text ?? "",
            "CM_TRIP_ENDDT": endtDate_Text.text ?? "",
            "IsApprover": "" ,
            "IsAdmin": "" ,
            "CM_STATUS" : vehicleID
        ] as [String : Any]
        
        print(param)
  
        ServiceRequest.shared.GetCarRequestsApi(param, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
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
                self.tableView.reloadData()
                self.CallForGetCarRequestStatusAPI()
            }else if (statuscode == 401){
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
}
