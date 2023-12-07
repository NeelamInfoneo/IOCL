//
//  AddOutstationLeaveVC.swift
//  IOCL
//
//  Created by neelam  on 09/01/23.
//

import UIKit
import KRProgressHUD
import Alamofire
import iOSDropDown

class AddOutstationLeaveVC: UIViewController , WWCalendarTimeSelectorProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    @IBOutlet weak var leaveTypeText: UITextField!
    @IBOutlet weak var outStationNOText: UITextField!
    @IBOutlet weak var startTimeText: UITextField!
    @IBOutlet weak var endTimeText: UITextField!
    @IBOutlet weak var startdateText: UITextField!
    @IBOutlet weak var enddateText: UITextField!
    @IBOutlet weak var destinationText: UITextField!
    @IBOutlet weak var purposeText: UITextField!
    @IBOutlet weak var approverText: UITextField!
    @IBOutlet weak var functionalResponsibiltyText: UITextField!
    @IBOutlet weak var jobIncharge1DropDown: DropDown!
    //   @IBOutlet weak var jobIncharge1Text: UITextField!
    @IBOutlet weak var assignedRole1Text: UITextField!
    @IBOutlet weak var jobIncharge2Text: DropDown!
    @IBOutlet weak var assignedRole2Text: UITextField!
    @IBOutlet weak var jobIncharge3Text: DropDown!
    @IBOutlet weak var assignedRole3Text: UITextField!
    @IBOutlet weak var jobIncharge4Text: DropDown!
    @IBOutlet weak var assignedRole4Text: UITextField!
    @IBOutlet weak var disterRoleText: UITextField!
    @IBOutlet weak var otherRemarkText: UITextView!
    @IBOutlet weak var jobIncharge1View: UIView!
    @IBOutlet weak var assignedRole1View: UIView!
    @IBOutlet weak var jobIncharge2View: UIView!
    @IBOutlet weak var assignedRole2View: UIView!
    @IBOutlet weak var jobIncharge3View: UIView!
    @IBOutlet weak var assignedRole3View: UIView!
    @IBOutlet weak var jobIncharge4View: UIView!
    @IBOutlet weak var assignedRole4View: UIView!
    @IBOutlet weak var stacView1: UIStackView!
    @IBOutlet weak var stacView2: UIStackView!
    @IBOutlet weak var stacView3: UIStackView!
    @IBOutlet weak var stacView4: UIStackView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainHeightView: NSLayoutConstraint!
    @IBOutlet weak var stackHeightView: NSLayoutConstraint!
    
    @IBOutlet weak var desTextCount: UILabel!
    let regularFont = UIFont.systemFont(ofSize: 16)
    let boldFont = UIFont.boldSystemFont(ofSize: 16)
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var GRADE = UserDefaults.standard.value(forKey: "GRADE") as? String
    var IsOutstationDisasterCoordinator = UserDefaults.standard.value(forKey: "IsOutstationDisasterCoordinator") as? Bool
    @IBOutlet weak var administRativeResponsibiltyText: UITextField!
    
    var selectType = String()
    var administRativeResponsibiltyValue =  String()
    //MARK: - LEAVE SUB VARIABLES -
    var leaveArray = [String]()
    var leaveID = Int()
    var leaveDataArray = [[String:Any]]()
    var leavedropDown:BKDropDown!
    //MARK: - YOUR APPROVER SUB VARIABLES -
    var administRativeResponsibiltyArray = [String]()
    var administRativeResponsibiltyID = Int()
    var administRativeResponsibiltyDataArray = [[String:Any]]()
    var administRativeResponsibiltydropDown:BKDropDown!
    
    
    //MARK: - APPROVER SUB VARIABLES -
    var ApproverArray = [String]()
    var ApproverID = Int()
    var ApproverDataArray = [[String:Any]]()
    var ApproverdropDown:BKDropDown!
    
    //MARK: - APPROVER SUB VARIABLES -
    var jobInCharge_1_Array = [String]()
    var jobInCharge_1_IDArray = [Int]()
    var jobInCharge_1_ID = String()
    var jobInCharge_2_ID = String()
    var jobInCharge_3_ID = String()
    var jobInCharge_4_ID = String()
    var jobInCharge1IDArray = [String]()
    var jobInCharge2IDArray = [String]()
    
    var jobInCharge3IDArray = [String]()
    
    var jobInCharge4IDArray = [String]()
    
    var jobInCharge_1_DataArray = [[String:Any]]()
    var jobInCharge_1_dropDown:BKDropDown!
    var jobInChargeValue = String()
    //MARK: - FUNCTIONAL RESPONSBILTY SUB VARIABLES -
    var functionalResponsbiltyArray = [String]()
    var functionalResponsbiltyID = Int()
    var functionalResponsbiltyDataArray = [[String:Any]]()
    var functionalResponsbiltyDropDown:BKDropDown!
    
    //MARK: - DISASTER SUB VARIABLES -
    var disasterArray = [String]()
    var disasterID = Int()
    var disasterDataArray = [[String:Any]]()
    var disasterDropDown:BKDropDown!
    
    
    var startTime = String()
    var startDate = String()
    var startTimeAm_Pm = String()
    var endTime = String()
    var endDate = String()
    var endTimeAm_Pm = String()
    var jonInchargeSelectType = String()
    var functionalResponsibiltyId = String()
    var disterValue = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if IsOutstationDisasterCoordinator == false {
            disterRoleText.text = "Not Applicable"
            disterRoleText.isUserInteractionEnabled = false
        }else {
            disterRoleText.text = ""
            disterRoleText.isUserInteractionEnabled = true
        }
        self.OutstationLeaveTypeApiAPI()
        self.CallForGetOutstationApproverStatusAPI()
        setLeaveTypeSetupDropDown()
        setFunctionaltyResponsbiltySetupDropDown()
        setvc()
        CallForGetOutstationJobInchargeAPI(textValue: "", textField: jobIncharge1DropDown)
        // Do any additional setup after loading the view.
    }
    
    func JonInchargeDropDown(){
        jobIncharge1DropDown.optionArray = self.jobInCharge_1_Array
        //        jobIncharge1DropDown.an
        
        jobIncharge1DropDown.checkMarkEnabled = false
        //   jobIncharge1DropDown.semanticContentAttribute = .forceRightToLeft
        jobIncharge1DropDown.textColor = .appColor(.qbBlack)
        jobIncharge1DropDown.textAlignment = .left
        jobIncharge1DropDown.didSelect { selectedText, index, id in
            self.jobIncharge1DropDown.text = selectedText
            for item in self.jobInCharge_1_DataArray {
                let Name = item["Name"] as? String
                let EmpNoId = item["EMPNO"] as! String
                let Designation = item["Designation"] as? String
                let Grade = item["Grade"] as? String
                let finalName = (Name ?? "") + " "  + (Designation ?? "") + " : "  + (Grade ?? "")
                if finalName == selectedText{
                    self.jobInCharge_1_ID = EmpNoId
                    print("jobInCharge_1_ID \(self.jobInCharge_1_ID)")
                }
            }
            //  " \(selectedText) \n index: \(index) \n Id: \(id)"
        }
        
        
        jobIncharge2Text.optionArray = self.jobInCharge_1_Array
        //        jobIncharge1DropDown.an
        
        jobIncharge2Text.checkMarkEnabled = false
        //   jobIncharge1DropDown.semanticContentAttribute = .forceRightToLeft
        jobIncharge2Text.textColor = .appColor(.qbBlack)
        jobIncharge2Text.textAlignment = .left
        jobIncharge2Text.didSelect { selectedText, index, id in
            self.jobIncharge2Text.text = selectedText
            for item in self.jobInCharge_1_DataArray {
                let Name = item["Name"] as? String
                let EmpNoId = item["EMPNO"] as! String
                let Designation = item["Designation"] as? String
                let Grade = item["Grade"] as? String
                let finalName = (Name ?? "") + " "  + (Designation ?? "") + " : "  + (Grade ?? "")
                if finalName == selectedText{
                    self.jobInCharge_2_ID = EmpNoId
                    print("jobInCharge_2_ID \(self.jobInCharge_2_ID)")
                }
            }
            //  " \(selectedText) \n index: \(index) \n Id: \(id)"
        }
        
        jobIncharge3Text.optionArray = self.jobInCharge_1_Array
        //        jobIncharge1DropDown.an
        
        jobIncharge3Text.checkMarkEnabled = false
        //   jobIncharge1DropDown.semanticContentAttribute = .forceRightToLeft
        jobIncharge3Text.textColor = .appColor(.qbBlack)
        jobIncharge3Text.textAlignment = .left
        jobIncharge3Text.didSelect { selectedText, index, id in
            self.jobIncharge3Text.text = selectedText
            for item in self.jobInCharge_1_DataArray {
                let Name = item["Name"] as? String
                let EmpNoId = item["EMPNO"] as! String
                let Designation = item["Designation"] as? String
                let Grade = item["Grade"] as? String
                let finalName = (Name ?? "") + " "  + (Designation ?? "") + " : "  + (Grade ?? "")
                if finalName == selectedText{
                    self.jobInCharge_3_ID = EmpNoId
                    print("jobInCharge_3_ID \(self.jobInCharge_3_ID)")
                }
            }
            //  " \(selectedText) \n index: \(index) \n Id: \(id)"
        }
        
        jobIncharge4Text.optionArray = self.jobInCharge_1_Array
        //        jobIncharge1DropDown.an
        jobIncharge4Text.checkMarkEnabled = false
        //   jobIncharge1DropDown.semanticContentAttribute = .forceRightToLeft
        jobIncharge4Text.textColor = .appColor(.qbBlack)
        jobIncharge4Text.textAlignment = .left
        jobIncharge4Text.didSelect { selectedText, index, id in
            self.jobIncharge4Text.text = selectedText
            for item in self.jobInCharge_1_DataArray {
                let Name = item["Name"] as? String
                let EmpNoId = item["EMPNO"] as! String
                let Designation = item["Designation"] as? String
                let Grade = item["Grade"] as? String
                let finalName = (Name ?? "") + " "  + (Designation ?? "") + " : "  + (Grade ?? "")
                if finalName == selectedText{
                    self.jobInCharge_4_ID = EmpNoId
                    print("jobInCharge_4_ID \(self.jobInCharge_4_ID)")
                }
            }
            
            //  " \(selectedText) \n index: \(index) \n Id: \(id)"
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - FUNCTIONS -
    private func setvc() {
        self.otherRemarkText.delegate = self
        self.mainHeightView.constant = 1070
        self.stackHeightView.constant = 0
        self.stacView1.isHidden = true
        self.stacView2.isHidden = true
        self.stacView3.isHidden = true
        self.stacView4.isHidden = true
        self.jobIncharge1View.isHidden = true
        self.jobIncharge2View.isHidden = true
        self.jobIncharge3View.isHidden = true
        self.jobIncharge4View.isHidden = true
        self.assignedRole1View.isHidden = true
        self.assignedRole2View.isHidden = true
        self.assignedRole3View.isHidden = true
        self.assignedRole4View.isHidden = true
        leaveTypeText.isUserInteractionEnabled = false
        functionalResponsibiltyText.isUserInteractionEnabled = false
        approverText.isUserInteractionEnabled = false
        administRativeResponsibiltyText.isUserInteractionEnabled = false
        disterRoleText.isUserInteractionEnabled = false
        
        startTimeText.setLeftPaddingPoints(10)
        endTimeText.setLeftPaddingPoints(10)
        
        leaveTypeText.setLeftPaddingPoints(10)
        administRativeResponsibiltyText.setLeftPaddingPoints(10)
        startdateText.setLeftPaddingPoints(10)
        enddateText.setLeftPaddingPoints(10)
        destinationText.setLeftPaddingPoints(10)
        purposeText.setLeftPaddingPoints(10)
        approverText.setLeftPaddingPoints(10)
        functionalResponsibiltyText.setLeftPaddingPoints(10)
        // jobIncharge1Text.setLeftPaddingPoints(10)
        assignedRole1Text.setLeftPaddingPoints(10)
        jobIncharge2Text.setLeftPaddingPoints(10)
        assignedRole2Text.setLeftPaddingPoints(10)
        jobIncharge3Text.setLeftPaddingPoints(10)
        assignedRole3Text.setLeftPaddingPoints(10)
        jobIncharge4Text.setLeftPaddingPoints(10)
        assignedRole4Text.setLeftPaddingPoints(10)
        disterRoleText.setLeftPaddingPoints(10)
        // jobIncharge1Text.delegate = self
        
        
        if GRADE == "F" || GRADE == "G" || GRADE == "H" || GRADE == "I" {
            administRativeResponsibiltyText.text = ""
            administRativeResponsibiltyText.isUserInteractionEnabled = true
        }else {
            self.administRativeResponsibiltyValue  = ""
            administRativeResponsibiltyText.text = "Not Applicable"
            administRativeResponsibiltyText.isUserInteractionEnabled = false
        }
        
        
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
    
    @IBAction func tapHistoryBtn(_ sender: Any) {
        
        let vc = OutstationLeaveHistoryVC.instantiate(fromAppStoryboard: .User)
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
        if startdateText.text == "" {
            self.createAlert(title: kAppName, message: kStartDate)
            
        }else{
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
    }
    
    @IBAction func tapOnEndTimeBtn(_ sender: Any) {
        if enddateText.text == "" {
            self.createAlert(title: kAppName, message: kEnddate)
            
        }else{
            selectType = "SelectEndDateTime"
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
    
    @IBAction func tapOnStartTimeBtn(_ sender: Any) {
        if startdateText.text == "" {
            self.createAlert(title: kAppName, message: kStartDate)
            
        }else{
            selectType = "SelectStartDateTime"
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
    
    
    @IBAction func tapOnSubmitBtn(_ sender: UIButton) {
        
        CallAddOutstationAPI()
    }
    
    @IBAction func tapOnleaveTypeBtn(_ sender: UIButton) {
        if leavedropDown != nil{
            leavedropDown
                .setLayoutCell(width:220)
                .show(self, targetView: sender)
        }
    }
    @IBAction func tapOnYourApproverBtn(_ sender: UIButton) {
        if administRativeResponsibiltydropDown != nil{
            administRativeResponsibiltydropDown
                .setLayoutCell(width: sender.frame.width)
                .show(self, targetView: sender)
        }
    }
    @IBAction func tapOnApproverBtn(_ sender: UIButton) {
        if ApproverdropDown != nil{
            ApproverdropDown
                .setLayoutCell(width: sender.frame.width)
                .show(self, targetView: sender)
        }
    }
    @IBAction func tapOnFunctionalltyBtn(_ sender: UIButton) {
        
        if functionalResponsbiltyDropDown != nil{
            functionalResponsbiltyDropDown
                .setLayoutCell(width:220)
                .show(self, targetView: sender)
        }
        
    }
    
    @IBAction func tapOnDisterRoleBtn(_ sender: UIButton) {
        if IsOutstationDisasterCoordinator == false {
            sender.isUserInteractionEnabled = false
        }else if disasterDropDown != nil{
            sender.isUserInteractionEnabled = true
            
            disasterDropDown
                .setLayoutCell(width:220)
                .show(self, targetView: sender)
            
            
        }
    }
    
    
    
    //MARK: - SELECT TIME -
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        print("Selected \n\(date)\n---")
        singleDate = date
        if selectType == "SelectStartDate" {
            self.startDate = date.stringFromFormat("yyyy-MM-dd")
            self.startdateText.text
            = date.stringFromFormat("yyyy-MM-dd")
            
        }else if selectType == "SelectEndDate" {
            self.enddateText.text = date.stringFromFormat("yyyy-MM-dd")
            self.endDate = date.stringFromFormat("yyyy-MM-dd")
            
            
            if GRADE == "F" || GRADE == "G" || GRADE == "H" || GRADE == "I" {
                self.CallForGetOutstationAdministrativeResponsibilityStatusAPI()
            }else {
                self.administRativeResponsibiltyValue  = ""
                administRativeResponsibiltyText.text = "Not Applicable"
                administRativeResponsibiltyText.isUserInteractionEnabled = false
            }
            
        }else if selectType == "SelectStartDateTime"{
            self.startTimeText.text = date.stringFromFormat("hh:mm")
            self.startTime = date.stringFromFormat("hh:mm")
            self.startTimeAm_Pm = date.stringFromFormat("a")
            
        }else  if selectType == "SelectEndDateTime" {
            self.endTimeText.text = date.stringFromFormat(" hh:mm")
            self.endTime = date.stringFromFormat(" hh:mm")
            self.endTimeAm_Pm = date.stringFromFormat("a")
        }
        
    }
    
    //MARK: - SET LEAVE TYPE  DROPDOWN  --------------
    func setLeaveTypeSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        leavedropDown = BKDropDown.instance()
            .bind(leaveArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.leaveTypeText.text = item.title
                print("item value \(item.title)")
                dropDown.hide()
            })
    }
    
    //MARK: - SET COMPLAINT SUB SUB DROPDOWN  --------------
    func setFunctionaltyResponsbiltySetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        functionalResponsbiltyDropDown = BKDropDown.instance()
            .bind(["Single Officers", "Two Officers" , "Three Officers", "Four Officers" ])
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.functionalResponsibiltyText.text = item.title
                print("item value \(item.title)")
                var officeValue = String()
                
                if item.title == "Single Officers" {
                    self.functionalResponsibiltyId = "ONE"
                    officeValue = "First Officers"
                    self.disasterArray.append(officeValue)
                }else  if item.title == "Two Officers" {
                    self.functionalResponsibiltyId = "TWO"
                    officeValue = "Second Officers"
                    self.disasterArray.append(officeValue)
                }else  if item.title == "Three Officers" {
                    self.functionalResponsibiltyId = "THREE"
                    officeValue = "Third Officers"
                    self.disasterArray.append(officeValue)
                }else  if item.title == "Four Officers" {
                    self.functionalResponsibiltyId =  "FOUR"
                    officeValue = "Fourth Officers"
                    self.disasterArray.append(officeValue)
                }
                
                if self.functionalResponsibiltyText.text == "Single Officers" {
                    self.stacView1.isHidden = false
                    self.stacView2.isHidden = true
                    self.stacView3.isHidden = true
                    self.stacView4.isHidden = true
                    self.jobIncharge1View.isHidden = false
                    self.jobIncharge2View.isHidden = true
                    self.jobIncharge3View.isHidden = true
                    self.jobIncharge4View.isHidden = true
                    self.assignedRole1View.isHidden = false
                    self.assignedRole2View.isHidden = true
                    self.assignedRole3View.isHidden = true
                    self.assignedRole4View.isHidden = true
                    self.mainHeightView.constant = 1190
                    self.stackHeightView.constant = 160
                    
                }else  if self.functionalResponsibiltyText.text == "Two Officers" {
                    self.stacView1.isHidden = false
                    self.stacView2.isHidden = false
                    self.stacView3.isHidden = true
                    self.stacView4.isHidden = true
                    self.jobIncharge1View.isHidden = false
                    self.jobIncharge2View.isHidden = false
                    self.jobIncharge3View.isHidden = true
                    self.jobIncharge4View.isHidden = true
                    self.assignedRole1View.isHidden = false
                    self.assignedRole2View.isHidden = false
                    self.assignedRole3View.isHidden = true
                    self.assignedRole4View.isHidden = true
                    self.mainHeightView.constant = 1390
                    self.stackHeightView.constant = 320
                    
                } else  if self.functionalResponsibiltyText.text == "Three Officers" {
                    self.stacView1.isHidden = false
                    self.stacView2.isHidden = false
                    self.stacView3.isHidden = false
                    self.stacView4.isHidden = true
                    self.jobIncharge1View.isHidden = false
                    self.jobIncharge2View.isHidden = false
                    self.jobIncharge3View.isHidden = false
                    self.jobIncharge4View.isHidden = true
                    
                    self.assignedRole1View.isHidden = false
                    self.assignedRole2View.isHidden = false
                    self.assignedRole3View.isHidden = false
                    self.assignedRole4View.isHidden = true
                    self.mainHeightView.constant = 1460
                    self.stackHeightView.constant = 480
                }else  if self.functionalResponsibiltyText.text == "Four Officers" {
                    self.stacView1.isHidden = false
                    self.stacView2.isHidden = false
                    self.stacView3.isHidden = false
                    self.stacView4.isHidden = false
                    self.jobIncharge1View.isHidden = false
                    self.jobIncharge2View.isHidden = false
                    self.jobIncharge3View.isHidden = false
                    self.jobIncharge4View.isHidden = false
                    self.assignedRole1View.isHidden = false
                    self.assignedRole2View.isHidden = false
                    self.assignedRole3View.isHidden = false
                    self.assignedRole4View.isHidden = false
                    self.mainHeightView.constant = 1640
                    self.stackHeightView.constant = 640
                }
                self.setDisterRoleSetupDropDown()
                dropDown.hide()
            })
    }
    
    
    //MARK: - SET COMPLAINT SUB SUB DROPDOWN  --------------
    func setApproverSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        ApproverdropDown = BKDropDown.instance()
            .bind(ApproverArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.approverText.text = item.title
                print("item value \(item.title)")
                for item in self.ApproverDataArray {
                    let Name = item["FIRST_NAME"] as? String
                    let LAST_NAME = item["LAST_NAME"] as? String
                    let DESIGNATION = item["DESIGNATION"] as? String
                    let finalName = (Name ?? "") + " "  + (LAST_NAME ?? "") + " : "  + (DESIGNATION ?? "")
                    if finalName == self.approverText.text {
                        let Id = item["EMPNO"] as! String
                        self.ApproverID = Int(Id) ?? 0
                    }
                }
                dropDown.hide()
            })
    }
    
    //MARK: - SET COMPLAINT SUB SUB DROPDOWN  --------------
    func setDisterRoleSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        disasterDropDown = BKDropDown.instance()
            .bind(disasterArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.disterRoleText.text = item.title
                print("item value \(item.title)")
                
                if item.title == "First Officers" {
                    self.disterValue = "FIRST"
                }else  if item.title == "Second Officers" {
                    self.disterValue = "SECOND"
                }else  if item.title == "Third Officers" {
                    self.disterValue = "THIRD"
                }else  if item.title == "Fourth Officers" {
                    self.disterValue =  "FOURTH"
                }
                dropDown.hide()
            })
    }
    
    
    func setadministRativeResponsibiltySetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        administRativeResponsibiltydropDown = BKDropDown.instance()
            .bind(administRativeResponsibiltyArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.administRativeResponsibiltyText.text = item.title
                self.administRativeResponsibiltyValue = item.title
                print("item value \(item.title)")
                for item in self.administRativeResponsibiltyDataArray {
                    let Name = item["FIRST_NAME"] as? String
                    let LAST_NAME = item["LAST_NAME"] as? String
                    let DESIGNATION = item["DESIGNATION"] as? String
                    let finalName = (Name ?? "") + " "  + (LAST_NAME ?? "") + " : "  + (DESIGNATION ?? "")
                    print(finalName)
                    if  finalName == (self.administRativeResponsibiltyText.text ?? "") {
                        self.administRativeResponsibiltyID = item["EMPNO"] as? Int ?? 0
                        print(self.administRativeResponsibiltyID ?? 0)
                    }
                }
                dropDown.hide()
            })
    }
    
}

extension AddOutstationLeaveVC  : UITextFieldDelegate  ,UITextViewDelegate{
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        if textField ==  self.jobIncharge1DropDown {
    //            self.CallForGetOutstationJobInchargeAPI(textValue: "", textField: self.jobIncharge1DropDown)
    //            //            CallForGetOutstationJobInchargeAPI(textValue: self.jobIncharge1Text.text ?? "", textField: textField)
    //            //            self.setJobInChargeSetupDropDown()
    //            //            self.jonInchargeSelectType = "1"
    //        }
    //    }
    //        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //            if textField ==  self.jobIncharge1DropDown {
    ////                CallForGetOutstationJobInchargeAPI(textValue: self.jobIncharge1Text.text ?? "", textField: textField)
    ////                self.setJobInChargeSetupDropDown()
    ////                self.jonInchargeSelectType = "1"
    //                self.CallForGetOutstationJobInchargeAPI(textValue: "", textField: self.jobIncharge1DropDown)
    //
    //        }
    
    //            return true
    //   }
    //
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        print(newText.count)
        self.desTextCount.text = "\(newText.count)/100"
        return numberOfChars < 100    // 10 Limit Value
    }
    
}

extension AddOutstationLeaveVC {
    
    
    func OutstationLeaveTypeApiAPI() {
     
        ServiceRequest.shared.OutstationLeaveTypeApi(nil, completionHandler: { isSucess, response, errorMsg in
            
                let dict = response
                print("JSON: \(dict)")
                let statuscode = dict?["statuscode"] as? Int
                let message = dict?["message"] as? String
                if (statuscode == 200){
                self.leaveArray = dict?["data"] as! [String]
                self.setLeaveTypeSetupDropDown()
                }else if (statuscode == 401){
                    
                }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: message ?? "")
            }
        })
    }

    
    //MARK: - GetOutstationAdministrativeResponsibility API CALLING FUNCTIONS ------------------------------------------
    func CallForGetOutstationAdministrativeResponsibilityStatusAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let params = [
            "FromDate" : startdateText.text ?? "" ,
            "ToDate" : enddateText.text ?? ""
        ]
        ServiceRequest.shared.GetOutstationAdministrativeResponsibilityApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.administRativeResponsibiltyArray = []
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                self.administRativeResponsibiltyDataArray = dict?["data"] as! [[String:Any]]
                for item in self.administRativeResponsibiltyDataArray {
                    let Name = item["FIRST_NAME"] as? String
                    let LAST_NAME = item["LAST_NAME"] as? String
                    let DESIGNATION = item["DESIGNATION"] as? String
                    let finalName = (Name ?? "") + " "  + (LAST_NAME ?? "") + " : "  + (DESIGNATION ?? "")
                    self.administRativeResponsibiltyArray.append(finalName)
                }
                self.setadministRativeResponsibiltySetupDropDown()
                
            }else if (statuscode == 401){
                
                
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
            
        })
        
    }
    
    
    
    //MARK: - GetOutstationApprover API CALLING FUNCTIONS ------------------------------------------
    func CallForGetOutstationApproverStatusAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        
        ServiceRequest.shared.GetOutstationApproverApi(nil, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.ApproverArray = []
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                self.ApproverDataArray = dict?["data"] as! [[String:Any]]
                if  self.ApproverDataArray.isEmpty{
                    self.approverText.text = "Not Applicable"
                    self.approverText.isUserInteractionEnabled = false
                }else{
                    for item in self.ApproverDataArray {
                        let Name = item["FIRST_NAME"] as? String
                        let LAST_NAME = item["LAST_NAME"] as? String
                        let DESIGNATION = item["DESIGNATION"] as? String
                        let finalName = (Name ?? "") + " "  + (LAST_NAME ?? "") + " : "  + (DESIGNATION ?? "")
                        self.ApproverArray.append(finalName)
                    }
                }
                self.setApproverSetupDropDown()
                
            }else if (statuscode == 401){
                
                
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
            
        })
        
    }
    
    
    //MARK: - GetOutstationAdministrativeResponsibility API CALLING FUNCTIONS ------------------------------------------
    func CallForGetOutstationJobInchargeAPI(textValue :String, textField:UITextField ) {
        if reachability.isConnectedToNetwork() == false{
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let params = [
            "Title" :  textValue,
            "FROM_DATE" : startdateText.text ?? "" ,
            "TO_DATE" : enddateText.text ?? ""
        ]
        print(params)
        ServiceRequest.shared.GetOutstationJobInchargeApi(params, completionHandler: { isSucess, response, errorMsg in
            let dict = response
            print("JSON: \(dict)")
            self.jobInCharge_1_Array = []
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                self.jobInCharge_1_DataArray = dict?["data"] as! [[String:Any]]
                for item in self.jobInCharge_1_DataArray {
                    let Name = item["Name"] as? String
                    let Id = item["EMPNO"] as! String
                    let Designation = item["Designation"] as? String
                    let Grade = item["Grade"] as? String
                    let finalName = (Name ?? "") + " "  + (Designation ?? "") + " : "  + (Grade ?? "")
                    self.jobInCharge_1_Array.append(finalName)
                    self.jobInCharge1IDArray.append(Id)
                }
                self.JonInchargeDropDown()
                
            }else if (statuscode == 401){
                
                
            }else {
                
                self.createAlert(title: kAppName, message: kServerError)
            }
            
        })
        
    }
    
    
    //MARK: - ADD COMPLAINT API CALLING FUNCTIONS ------------------------------------------
    func CallAddOutstationAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
     
        let params : [String:Any]  = [
            "LEAVE_TYPE": leaveTypeText.text ?? "" ,
            "FROM_DATE": startDate ,
            "FROM_TIME": startTime ,
            "FROM_AMPM": startTimeAm_Pm ,
            "TO_DATE": endDate ,
            "TO_TIME": endTime ,
            "TO_AMPM": endTimeAm_Pm ,
            "PURPOSE": purposeText.text ?? "" ,
            "RESPONSIBILITY": functionalResponsibiltyId ,
            "DISASTER_CO": self.disterValue ,
            "DESTINATION": destinationText.text ?? "" ,
            "REMARKS" : otherRemarkText.text ?? "" ,
            "ADMIN_RES_EMPNO" : self.administRativeResponsibiltyID  ,
            "ADMIN_RES_NAME" : self.administRativeResponsibiltyValue  ,
            "JOB_IC_1_EMPNO" : jobInCharge_1_ID,
            "JOB_IC_1" : assignedRole1Text.text ?? "",
            "JOB_IC_2_EMPNO" : jobInCharge_2_ID,
            "JOB_IC_2" : assignedRole2Text.text ?? "",
            "JOB_IC_3_EMPNO" : jobInCharge_3_ID,
            "JOB_IC_3" : assignedRole3Text.text ?? "",
            "JOB_IC_4_EMPNO" : jobInCharge_4_ID,
            "JOB_IC_4" : assignedRole4Text.text ?? "",
            "APPROVER" : ApproverID,
        ]
        print(params)

        ServiceRequest.shared.OutstationRequestPreviewApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
                let dict = response
                print("JSON: \(dict)")
                let statuscode = dict?["statuscode"] as? Int
                let message = dict?["message"] as? String
                if (statuscode == 200){
                    let UserData = dict?["data"] as? [String:Any]
                    let  CC_MAIL = UserData?["CC_MAIL"] as? String
                    let  FROM_MAIL = UserData?["FROM_MAIL"] as? String
                    let  MAILBODY = UserData?["MAILBODY"] as? String
                    let  SUBJECT = UserData?["SUBJECT"] as? String
                    let  TO_MAIL = UserData?["TO_MAIL"] as? String
                    let storyboard = UIStoryboard.init(name: "User", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "ComposeEmailVC") as! ComposeEmailVC
                    
                    viewController.CC_MAIL = CC_MAIL ?? ""
                    viewController.FROM_MAIL = FROM_MAIL ?? ""
                    viewController.MAILBODY = MAILBODY ?? ""
                    viewController.SUBJECT = SUBJECT ?? ""
                    viewController.To_MAIL = TO_MAIL ?? ""
                    
                    viewController.LEAVE_TYPEValue = self.leaveTypeText.text ?? ""
                    viewController.FROM_DATEValue = self.startDate
                    viewController.FROM_TIMEValue = self.startTime
                    viewController.FROM_AMPMValue = self.startTimeAm_Pm
                    viewController.TO_DATEValue = self.endDate
                    viewController.TO_TIMEValue = self.endTime
                    viewController.TO_AMPMValue = self.endTimeAm_Pm
                    viewController.PURPOSEValue = self.purposeText.text ?? ""
                    viewController.RESPONSIBILITYValue = self.functionalResponsibiltyId
                    viewController.DISASTER_COValue = self.disterValue
                    viewController.DESTINATIONValue = self.destinationText.text ?? ""
                    viewController.REMARKSValue = self.otherRemarkText.text ?? ""
                    viewController.ADMIN_RES_EMPNOValue = self.administRativeResponsibiltyID
                    viewController.ADMIN_RES_NAMEValue  = self.administRativeResponsibiltyText.text ?? ""
                    viewController.JOB_IC_1_EMPNOValue = self.jobInCharge_1_ID
                    viewController.JOB_IC_1Value = self.assignedRole1Text.text ?? ""
                    viewController.JOB_IC_2_EMPNOValue =  self.jobInCharge_2_ID
                    viewController.JOB_IC_2Value = self.assignedRole2Text.text ?? ""
                    viewController.JOB_IC_3_EMPNOValue = self.jobInCharge_3_ID
                    viewController.JOB_IC_3Value = self.assignedRole3Text.text ?? ""
                    viewController.JOB_IC_4_EMPNOValue =  self.jobInCharge_4_ID
                    viewController.JOB_IC_4Value = self.assignedRole4Text.text ?? ""
                    viewController.APPROVERValue = self.ApproverID
                    self.navigationController?.pushViewController(viewController, animated: true)
                    
                }else if (statuscode == 401){
                    
                }else {
                    KRProgressHUD.dismiss()
                    self.createAlert(title: kAppName, message: message ?? "")
            }
        })
    }
    
}
//MARK: - TABLEV VIEW DATASOURCE -
extension AddOutstationLeaveVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 00
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    
}



