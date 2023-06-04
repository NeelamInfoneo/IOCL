//
//  VehicleRequisitionVC.swift
//  IOCL
//
//  Created by neelam  on 06/01/23.
//

import UIKit
import Alamofire
import KRProgressHUD

protocol vehicleDataPass {
   func vehicleDataPassing(Status:String)
}

class VehicleRequisitionVC: UIViewController , WWCalendarTimeSelectorProtocol ,UITextViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var selectTripTypeText: UITextField!
    @IBOutlet weak var TripReqNoTypeText: UITextField!
    @IBOutlet weak var startDateTypeText: UITextField!
    @IBOutlet weak var endDateTypeText: UITextField!
    @IBOutlet weak var desText: UITextView!
    @IBOutlet weak var desTextCount: UILabel!
    @IBOutlet weak var totalCountText: UILabel!
    var delegate:vehicleDataPass!
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var selectType = String()
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var vehicleArray : [[String:Any]] = []
    var index = 0
    var dateValue = String()
    var timeValue = String()
    var totalCount = 1
    //MARK: - TRIP VARIABLES -
    var tripArray = [String]()
    var tripID = Int()
    var tripDataArray = [[String:Any]]()
    var tripdropDown:BKDropDown!
    var vehicleModelAry =  [VehicleModelData]()
    var CT_DATEValue :String? = nil
    var CT_TIMEValue :String? = nil
    var CT_PLACETO_REPORTValue :String? = nil
    var CT_PLACETO_VISITValue :String? = nil
    var textValues = [String]()
   
   fileprivate var today: Date = Date()
   fileprivate var endDate : Date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        desText.delegate = self
        vehicleModelAry  = []
       // totalCountText.text = "Total No Of Records : \(totalCount)"
        setvc()
        let objvehicleMode = VehicleModelData()
        KRProgressHUD.set(activityIndicatorViewColors: [appColor])
        vehicleModelAry.append(objvehicleMode)
        selectTripTypeText.isUserInteractionEnabled = false
        selectTripTypeText.setLeftPaddingPoints(10)
        startDateTypeText.setLeftPaddingPoints(10)
        endDateTypeText.setLeftPaddingPoints(10)
        setTripSetupDropDown()
    }
    
    //MARK: - FUNCTIONS -
    private func setvc() {
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    
    
    //MARK: - SET TRIP DROPDOWN  --------------
    func setTripSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        tripdropDown = BKDropDown.instance()
            .bind(["Tour" ,"Training", "Transfer" ,"Other"])
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.selectTripTypeText.text = item.title
                print("item value \(item.title)")
                dropDown.hide()
            })
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        print(newText.count)
        self.desTextCount.text = "\(newText.count)/100"
        return numberOfChars < 100    // 10 Limit Value
    }
    //MARK: - ACTIONS -
    
    @IBAction func tripBtnAction(_ sender: UIButton) {
            if tripdropDown != nil{
                tripdropDown
                .setLayoutCell(width:220)
                .show(self, targetView: sender)
            }
    }
    
   
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func tapHistoryBtn(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tapOnNotificationBtn(_ sender: Any) {
        let vc = NotificationVC.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   @IBAction func tapToDeleteBtn(_ sender: UIButton) {
      self.vehicleModelAry.remove(at: sender.tag - 100)
      self.tableView.reloadData()
   }
    @IBAction func tapSaveBtn(_ sender: Any) {
//       let storyboard = UIStoryboard.init(name: "User", bundle: nil)
//       let viewController = storyboard.instantiateViewController(withIdentifier: "ComposeEmailVC") as! ComposeEmailVC
//       self.navigationController?.pushViewController(viewController, animated: true)
       
   
          if selectTripTypeText.text == "" {
             self.createAlert(title: kAppName, message: kVehicleType)
          }else  if startDateTypeText.text == "" {
             self.createAlert(title: kAppName, message: kStartDate)
          }else  if endDateTypeText.text == "" {
             self.createAlert(title: kAppName, message: kEnddate)
          }else  if desText.text == "" {
             self.createAlert(title: kAppName, message: kdes)
          }else {
             self.vehicleArray.removeAll()
             if vehicleModelAry[self.vehicleModelAry.count - 1].CT_DATE == "" {
                
             }else {
                for item in vehicleModelAry{
                   
                   print(item.CT_DATE)
                   print(item.CT_TIME)
                   print(item.CT_PLACETO_REPORT)
                   print(item.CT_PLACETO_VISIT)
                   let jsonData = [
                     "CT_DATE" : item.CT_DATE ,
                     "CT_TIME" : item.CT_TIME,
                     "CT_PLACETO_REPORT" : item.CT_PLACETO_REPORT ,
                     "CT_PLACETO_VISIT" : item.CT_PLACETO_VISIT
                   ]
                   self.vehicleArray.append(jsonData)
                   print("self.dataArray \(self.vehicleArray)")
                }
             }
             
             CallForvAddCarRequestAPI()
          }
       
       
    }
    
   @IBAction func tapAddBtn(_ sender: Any) {
      // totalCountText.text = "Total No Of Records : \(totalCount + 1)"
      if vehicleModelAry.count == 2 {
         self.createAlert(title: kAppName, message: "You can add only two request")
      }else{
         
         self.vehicleArray.removeAll()
         for item in vehicleModelAry{
            print(item.CT_DATE)
            print(item.CT_TIME)
            print(item.CT_PLACETO_REPORT)
            print(item.CT_PLACETO_VISIT)
            let jsonData = [
               "CT_DATE" : item.CT_DATE ,
               "CT_TIME" : item.CT_TIME,
               "CT_PLACETO_REPORT" : item.CT_PLACETO_REPORT ,
               "CT_PLACETO_VISIT" : item.CT_PLACETO_VISIT
            ]
            self.vehicleArray.append(jsonData)
            print("self.dataArray \(self.vehicleArray)")
         }
         
         
         let objVehicleMode = VehicleModelData()
         vehicleModelAry.append(objVehicleMode)
         print(vehicleModelAry)
         self.tableView.reloadData()
      }
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
    
//   func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool{
//         let order = NSCalendar.current.compare(today, to: date, toGranularity: .day)
//    
//      let endDate = NSCalendar.current.compare(endDate, to: date, toGranularity: .day)
//
//       if order == .orderedDescending{
//             //Date selection will be disabled for past days
//             return false
//       }else if endDate ==  order{
//           //Date selection will be disabled for past days
//           return false
//     }
//             //Allows to select from today
//             return true
//     
//     }

    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        print("Selected \n\(date)\n---")
        singleDate = date
        if selectType == "SelectStartDate" {
            self.startDateTypeText.text = date.stringFromFormat("yyyy-MM-dd")
         

        }else if selectType == "SelectEndDate" {
            self.endDateTypeText.text = date.stringFromFormat("yyyy-MM-dd")
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "yyyy-MM-dd"
           endDate = dateFormatter.date(from: endDateTypeText.text ?? "")!
        }else    if selectType == "SelectDate" {
           let obj =  self.vehicleModelAry[self.index]
            dateValue = date.stringFromFormat("yyyy-MM-dd")
            obj.CT_DATE = dateValue
            tableView.reloadData()
        }else if selectType == "SelectTime" {
            let obj =  self.vehicleModelAry[self.index]
            timeValue = date.stringFromFormat("hh:mm")
            obj.CT_TIME = timeValue
            tableView.reloadData()
        }
       
    }
    
    
    //MARK: - ADD CarRequest API CALLING FUNCTIONS ------------------------------------------
    func CallForvAddCarRequestAPI() {
            KRProgressHUD.show()
            if reachability.isConnectedToNetwork() == false{
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
                return
            }
        let params : [String:Any]  = [
            "JsonString" : self.vehicleArray.toJSONString() ,
            "CM_TRIP_STARTDT" : startDateTypeText.text ?? "" ,
            "CM_TRIP_ENDDT" : endDateTypeText.text ?? "" ,
            "CM_TRIP_REASON" : desText.text ?? "" ,
            "CM_TRIPTYPE"  : selectTripTypeText.text ?? "" ]
        print(params)
       ServiceRequest.shared.AddCarRequestApi(params, completionHandler: { isSucess, response, errorMsg in
                KRProgressHUD.dismiss()
                    let dict = response
                    print("JSON: \(dict)")
                     let statuscode = dict?["statuscode"] as? Int
                    let message = dict?["message"] as? String
                    if (statuscode == 200){
                        self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage: message ?? "", btnOneTitle: "Ok") {_ in
                           self.delegate.vehicleDataPassing(Status: "1")
                           self.navigationController?.popViewController(animated: true)
                        }
                    }else if (statuscode == 401){
                       
                    }else {
                       KRProgressHUD.dismiss()
                         self.createAlert(title: kAppName, message: kServerError)
                    }
            })
        }
   
}

//MARK: - TABLEV VIEW DATASOURCE -
extension VehicleRequisitionVC: UITableViewDataSource , UITableViewDelegate {
   //MARK: - TABLEV VIEW DATASOURCE -
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return vehicleModelAry.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
          
           print("Add Array \(vehicleModelAry.count)")
           let indeValue = vehicleModelAry.count
     
           totalCountText.text = "Total No Of Records : \(indeValue)"
          cell.deleteBtn.tag = indexPath.row + 100
          cell.Datetext.setLeftPaddingPoints(10)
          cell.timetext.setLeftPaddingPoints(10)
          cell.placeToVisitText.setLeftPaddingPoints(10)
          cell.reportToVisitText.setLeftPaddingPoints(10)
           cell.Datetext.delegate = self
           cell.timetext.delegate = self
           cell.placeToVisitText.delegate = self
           cell.reportToVisitText.delegate = self
           cell.Datetext.isUserInteractionEnabled = false
           cell.timetext.isUserInteractionEnabled = false
           cell.Datetext.text = vehicleModelAry[indexPath.row].CT_DATE
           cell.timetext.text =  vehicleModelAry[indexPath.row].CT_TIME
           cell.placeToVisitText.text = vehicleModelAry[indexPath.row].CT_PLACETO_VISIT
           cell.reportToVisitText.text = vehicleModelAry[indexPath.row].CT_PLACETO_REPORT
           cell.timeBtn.tag = indexPath.row
           cell.dateBtn.tag = indexPath.row
           cell.placeToVisitText.tag = indexPath.row
           cell.reportToVisitText.tag = indexPath.row
           cell.timeBtn.addTarget(self, action: #selector(selectTime), for: .touchUpInside)
           cell.dateBtn.addTarget(self, action: #selector(selectDate), for: .touchUpInside)
           cell.VisitCountText.text = "Car Request Details : \(indexPath.row + 1)"
         
           return cell
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 340
           
       }
//       @objc func deleteBtn_action(_ sender: UIButton) {
//           vehicleModelAry.remove(at: sender.tag - 100)
//           print("Delete Array \(vehicleModelAry.count)")
//
//           //totalCountText.text = "Total No Of Records : \(vehicleModelAry.count)"
//           self.tableView.reloadData()
//       }
       @objc func selectDate(sender:UIButton){
           index = sender.tag
           selectType = "SelectDate"
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
       
       @objc func selectTime(sender:UIButton){
           index = sender.tag
           selectType = "SelectTime"
           let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
           selector.delegate = self
           selector.optionCurrentDate = singleDate
           selector.optionCurrentDates = Set(multipleDates)
           selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
           selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
           selector.optionStyles.showDateMonth(false)
           selector.optionStyles.showMonth(false)
           selector.optionStyles.showYear(false)
           selector.optionStyles.showTime(true)
           present(selector, animated: true, completion: nil)
       }
   }

   extension VehicleRequisitionVC : UITextFieldDelegate {
       func textFieldDidBeginEditing(_ textField: UITextField) {
           index = textField.tag
       }
       func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
           textField.endEditing(true)
           textField.isUserInteractionEnabled = true
           let indexPath = IndexPath(item: textField.tag, section: 0)
           let cell = self.tableView?.cellForRow(at: indexPath) as? VehicleCell
           if textField == cell?.placeToVisitText {
               vehicleModelAry[indexPath.row].CT_PLACETO_VISIT = textField.text ?? ""
           }else if textField == cell?.reportToVisitText {
               vehicleModelAry[indexPath.row].CT_PLACETO_REPORT = textField.text ?? ""
           }
           print(vehicleModelAry[indexPath.row].CT_PLACETO_VISIT)
           print(vehicleModelAry[indexPath.row].CT_PLACETO_REPORT)
           
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          return  textField.resignFirstResponder()
       }
   //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
   //        return range.location < 4
   //    }
   }




