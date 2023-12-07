//
//  ComplaintReqestListVC.swift
//  IOCL
//
//  Created by neelam  on 12/03/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class ComplaintReqestListVC: UIViewController ,WWCalendarTimeSelectorProtocol,filterdataPass ,updateComplanintrequest{
    func updateComplanintRequestDataPass(Status: String) {
        if Status == "1" {
            CallForGetComplaintsAPI()
        }
    }
    
    
    func filterDataPassing(Complaint_Category: String, Complaint_Sub_Category: String, Complaint_Sub_Sub_Category: String) {
        CallForGetComplaintsAPI()
    }
        //MARK: - VARIABLES -
        fileprivate var singleDate: Date = Date()
        fileprivate var multipleDates: [Date] = []
        var selectType = String()
        let searchBtn = UIButton()
        //MARK: - OUTLETS -
        @IBOutlet weak var topView: UIView!
        @IBOutlet weak var titleLbl: UILabel!
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var statusTxt: UITextField!
        @IBOutlet var headerView: UIView!
        @IBOutlet weak var startDate_Text: UITextField!
        var Token = UserDefaults.standard.value(forKey: "Token") as? String
        var historyDataArray = [ComplaintData]()
        var editSelect = String()
        var refreshControl = UIRefreshControl()
       var VENDOR_SERNO = Int()
        //MARK: - COMPLAINT VARIABLES -
        var complaintArray = [String]()
        var complaintID = Int()
        var complaintDataArray = [[String:Any]]()
        var complaintdropDown:BKDropDown!
        
        //MARK: - VIEW LIFE CYCLE -
        override func viewDidLoad() {
            super.viewDidLoad()
//            self.startDate_Text.setLeftPaddingPoints(10)
//            self.statusTxt.setLeftPaddingPoints(10)
            setvc()
            refreshControl.attributedTitle = NSAttributedString(string: "")
            refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            tableView.addSubview(refreshControl) // not required when using UITableViewController
         }
        
    
    private func setvc() {
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
        @objc func refresh(_ sender: AnyObject) {
            CallForGetComplaintsAPI()
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            CallForGetComplaintsAPI()
        }
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
        }
        //MARK: - ACTIONS -
        
        @IBAction func tapOnBackBtn(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
    @IBAction func tapOnFilterBtn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ComplaintFilterVC") as! ComplaintFilterVC
        viewController.delegate = self
        viewController.modalPresentationStyle = .custom
        self.navigationController?.present(viewController, animated: false)
        
    }


        @IBAction func ComplaintDetailsBtnAction(_ sender: UIButton) {
                let vc = ComplaintRequestDeatilsVC.instantiate(fromAppStoryboard: .HrAdmin)
                vc.selectType = "Job Allocated"
            vc.delagte = self
            vc.empNameValue = historyDataArray[sender.tag - 100].EmployeeName ?? ""
            vc.empNOValue = historyDataArray[sender.tag - 100].EMPNO ?? 0
            vc.designationValue =  historyDataArray[sender.tag - 100].DESIGNATION ?? ""
            vc.companyCategoryValue =   historyDataArray[sender.tag - 100].MA_COMPLAINT_CATEGORY?.COMPLAINT_CATEGORY ?? ""
            vc.companySubCategoryValue = historyDataArray[sender.tag - 100].MA_COMPLAINT_CATEGORY?.COMPLAINT_SUB_CATEGORY ?? ""
            vc.companySubSubCategoryValue = historyDataArray[sender.tag - 100].MA_COMPLAINT_CATEGORY?.COMPLAINT_SUB_SUB_CATEGORY ?? ""
            vc.officeLocationValue = historyDataArray[sender.tag - 100].OFFICE_LOCATION ?? ""
            vc.complaintID = historyDataArray[sender.tag - 100].COMP_ID ?? 0
            vc.complaintStatus = historyDataArray[sender.tag - 100].MA_COMPLAINT_STATUS?.COMPLAINT_STATUS ?? ""
            vc.QTRNO = historyDataArray[sender.tag - 100].QTR_NO ?? ""
            vc.companyDes = historyDataArray[sender.tag - 100].COMP_DESC ?? ""
            vc.Remark = historyDataArray[sender.tag - 100].REMARKS ?? ""
            vc.Vendor_Name = historyDataArray[sender.tag - 100].Vendor_Name ?? ""
            
                vc.modalPresentationStyle = .custom
                self.navigationController?.present(vc, animated: false)
           
        }
        
        @IBAction func complaintTypeBtnAction(_ sender: UIButton) {
            
            if complaintdropDown != nil{
                complaintdropDown
                    .setLayoutCell(width: 130)
                .show(self, targetView: sender)
            }
        }
        
        
        @IBAction func tapOnCompleteMarkBtn(_ sender: UIButton) {
            self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kCompleteMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
                
            }, btnTwoTitle: "Ok") {_ in
                self.CallForGetMarkAsComplaintStatusAPI(complaintID: self.historyDataArray[sender.tag - 1000].COMP_ID ?? 0, VENDOR_SERNO: self.historyDataArray[sender.tag - 1000].VENDOR_SERNO ?? 0)
            }
        }
         
//        //MARK: - SELECT TIME -
//        func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
//            print("Selected \n\(date)\n---")
//            singleDate = date
//                self.startDate_Text.text = date.stringFromFormat("yyyy-MM-dd")
//        }
//
        
        //MARK: - FUNCTIONS -
        //MARK: - SET COMPLAINT DROPDOWN  --------------
        func setComplaintSetupDropDown() {
            let cellNormal = UIColor.white
            let cellHighlight = selctedBorder
            complaintdropDown = BKDropDown.instance()
                .bind(complaintArray)
                .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
                .setLayoutTitle(normal: .black, highlight: .white)
                .setDidSelectRowAt({ (_, item, dropDown) in
                    self.statusTxt.text = item.title
                    print("item value \(item.title)")
                    dropDown.hide()
                })
        }
        
    }

    //MARK: - TABLE VIEW DELEGATE -
    extension ComplaintReqestListVC: UITableViewDelegate {
         
    }

    //MARK: - TABLEV VIEW DATASOURCE -
    extension ComplaintReqestListVC: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return historyDataArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
            let obj = historyDataArray[indexPath.row]
            cell.complaintNotext.text = "Complaint no : \(obj.COMP_ID ?? 0)"
            cell.descriptiontext.text = obj.COMP_DESC
            cell.complaintTypetext.text = obj.MA_COMPLAINT_CATEGORY?.COMPLAINT_SUB_SUB_CATEGORY
            cell.statustext.text = obj.MA_COMPLAINT_STATUS?.COMPLAINT_STATUS
            
            
            if obj.MA_COMPLAINT_STATUS?.COMPLAINT_STATUS == "Job Allocated" {
                cell.completeMarkBtn.isHidden = false
            }else if obj.MA_COMPLAINT_STATUS?.COMPLAINT_STATUS == "Rejected" {
                cell.statustext.textColor = .appColor(.appRed)
                cell.completeMarkBtn.isHidden = true
            }else {
                cell.completeMarkBtn.isHidden = true
            }
            
            VENDOR_SERNO = obj.VENDOR_SERNO ?? 0
//            cell.feedbackBtn.tag = indexPath.row + 100
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let dateString = obj.UPDATED_ON
            let convertedDate = dateString?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd-MM-YYYY HH:mm a")

            cell.datetext.text = convertedDate
            cell.detailsBtn.tag = indexPath.row + 100
            cell.completeMarkBtn.tag = indexPath.row + 1000
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 187
        }
    }

    extension ComplaintReqestListVC {
        
        //MARK: - GetComplaintCategory API CALLING FUNCTIONS ------------------------------------------
        func CallForGetComplaintCategoryAPI() {
                KRProgressHUD.show()
                if reachability.isConnectedToNetwork() == false{
                    KRProgressHUD.dismiss()
                    self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
                    return
                }
                let url = "\(ApiLink.HOST_URL)\(GetComplaintCategory)"
            ServiceRequest.shared.GetComplaintCategoryApi(nil, completionHandler: { isSucess, response, errorMsg in
                    KRProgressHUD.dismiss()
                        let dict = response
                        print("JSON: \(dict)")
                        self.complaintDataArray = []
                         let statuscode = dict?["statuscode"] as? Int

                        if (statuscode == 200){
                          
                            self.complaintDataArray = dict?["data"] as! [[String:Any]]
                            for item in self.complaintDataArray {
                                let Name = item["CATEGORY"] as! String
                                self.complaintArray.append(Name)
                            }
                            self.setComplaintSetupDropDown()
                        }else if (statuscode == 401){
                           
                              
                        }else {
                        KRProgressHUD.dismiss()
                          self.createAlert(title: kAppName, message: kServerError)
                    }

                })
                
            }
        
        //MARK: - GetComplaint History API CALLING FUNCTIONS ------------------------------------------
        
        func CallForGetComplaintsAPI() {
            KRProgressHUD.show()
            if reachability.isConnectedToNetwork() == false{
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
                return
            }
            
            let params : [String:Any]  = [
                "PageIndex" : "" ,
                "PageSize" : 50 ,
               ]
            
            ServiceRequest.shared.GetAdminComplaintsApi(params, completionHandler: { isSucess, response, errorMsg in
                KRProgressHUD.dismiss()
                let dict = response as! [String:Any]
                    print("JSON: \(dict)")
                     let statuscode = dict["statuscode"] as? Int
                    if (statuscode == 200){
                       let data = dict["data"] as! [[String:Any]]
                        var Mobj = [ComplaintData]()
                        for item in data {
                            let obj = ComplaintData.init(item)
                            Mobj.append(obj)
                        }
                        self.historyDataArray = Mobj
                        self.tableView.reloadData()
                        self.CallForGetComplaintCategoryAPI()
                    }else if (statuscode == 401){
                    }else {
                    KRProgressHUD.dismiss()
                    self.createAlert(title: kAppName, message: kServerError)
                }
            })
        }
        
        func CallForGetMarkAsComplaintStatusAPI(complaintID: Int , VENDOR_SERNO:Int) {
            let params : [String:Any]  = [
                "COMP_ID" : complaintID ,
                "COMPLAINT_STATUS_ID" : 3 ,
               "VENDOR_SERNO" : VENDOR_SERNO
            ]
            print(params)
       
            ServiceRequest.shared.UpdateComplaintStatusApi(params, completionHandler: { isSucess, response, errorMsg in
                    let dict = response
                    print("JSON: \(dict)")
                    let statuscode = dict?["statuscode"] as? Int
                    if (statuscode == 200){
                        self.CallForGetComplaintsAPI()
                    }else if (statuscode == 401){
                    }else {
                    self.createAlert(title: kAppName, message: kServerError)
                }
            })
        }
        
        
    }
