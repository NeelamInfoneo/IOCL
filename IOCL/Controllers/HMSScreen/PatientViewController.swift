//
//  PatientViewController.swift
//  IOCL
//
//  Created by neelam  on 15/05/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class PatientViewController: UIViewController {
    
    //MARK: - VARIABLES -
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var selectType = String()
    let searchBtn = UIButton()
    var complaintArray = [String]()
    var complaintID = String()
    var complainteDataArray = [[String:Any]]()
    var complaintdropDown:BKDropDown!
    
    //MARK: - OUTLETS -
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusTxt: UITextField!
    @IBOutlet var headerView: UIView!
    let refreshControl = UIRefreshControl()
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var historyDataArray = [ComplaintData]()
    var editSelect = String()
    
    //MARK: - VIEW LIFE CYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
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
        CallForGetComplaintsAPI(Complaint_Category: "", Complaint_Sub_Category: "", Complaint_Sub_Sub_Category: "")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CallForGetComplaintsAPI(Complaint_Category: "", Complaint_Sub_Category: "", Complaint_Sub_Sub_Category: "")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //MARK: - ACTIONS -
    
    @IBAction func tapOnBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func patientDetailsBtnAction(_ sender: UIButton) {
        let vc = PatientDetailsViewController.instantiate(fromAppStoryboard: .HMS)
        vc.modalPresentationStyle = .custom
        self.navigationController?.present(vc, animated: false)
    }
    
    
    
}

//MARK: - TABLE VIEW DELEGATE -
extension PatientViewController: UITableViewDelegate {
    
}

//MARK: - TABLEV VIEW DATASOURCE -
extension PatientViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
//        let obj = historyDataArray[indexPath.row]
//        cell.complaintNotext.text = "Complaint no : \(obj.COMP_ID ?? 0)"
//        cell.descriptiontext.text = obj.COMP_DESC
//        cell.complaintTypetext.text = obj.MA_COMPLAINT_CATEGORY?.COMPLAINT_SUB_SUB_CATEGORY
//        cell.statustext.text = obj.MA_COMPLAINT_STATUS?.COMPLAINT_STATUS
//
//        cell.editBtn.tag = indexPath.row
//        cell.feedbackBtn.tag = indexPath.row + 100
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm a"
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        let dateString = obj.UPDATED_ON
//        let convertedDate = dateString?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd-MM-YYYY HH:mm a")
//        cell.detailsBtn.tag = indexPath.row + 100
//
//        if obj.MA_COMPLAINT_STATUS?.COMPLAINT_STATUS == "Registered" {
//            cell.editBtn.isHidden = false
//            cell.feedbackBtn.isHidden = true
//            cell.FeedBackViewHeight.constant = 30
//            cell.FeedBackViewWidth.constant = 30
//        }else if obj.MA_COMPLAINT_STATUS?.COMPLAINT_STATUS == "Completed" {
//            cell.editBtn.isHidden = true
//            cell.feedbackBtn.isHidden = false
//            cell.FeedBackViewHeight.constant = 30
//            cell.FeedBackViewWidth.constant = 70
//        }else if obj.MA_COMPLAINT_STATUS?.COMPLAINT_STATUS == "Job Allocated" {
//            cell.editBtn.isHidden = true
//            cell.feedbackBtn.isHidden = true
//            cell.FeedBackViewWidth.constant = 0
//        }else if obj.MA_COMPLAINT_STATUS?.COMPLAINT_STATUS == "Rejected" {
//            cell.statustext.textColor = .appColor(.appRed)
//            cell.editBtn.isHidden = true
//            cell.feedbackBtn.isHidden = true
//            cell.FeedBackViewWidth.constant = 0
//        }
//
//        //  cell.FeedBackViewHeight.constant = 0
//        cell.datetext.text = convertedDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
  
}

extension PatientViewController {
    
    //MARK: - GetComplaint History API CALLING FUNCTIONS ------------------------------------------
    
    func CallForGetComplaintsAPI(Complaint_Category :String , Complaint_Sub_Category :String ,Complaint_Sub_Sub_Category :String) {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let params : [String:Any]  = [
            "PageIndex" : 1 ,
            "PageSize" : 10 ,
            "COMP_ID": "" ,
            "COMPLAINT_CATEGORY": Complaint_Category,
            "COMPLAINT_SUB_CATEGORY": Complaint_Sub_Category ,
            "COMPLAINT_SUB_SUB_CATEGORY": Complaint_Sub_Sub_Category
        ]
        print(params)
        ServiceRequest.shared.GetComplaintsApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            self.refreshControl.endRefreshing()
            if response != nil{
                let dict = response
                print("JSON: \(dict)")
                let statuscode = dict?["statuscode"] as? Int
                if (statuscode == 200){
                    let data = dict?["data"] as! [[String:Any]]
                    var Mobj = [ComplaintData]()
                    for item in data {
                        let obj = ComplaintData.init(item)
                        Mobj.append(obj)
                    }
                    self.historyDataArray = Mobj
                    self.tableView.reloadData()
                }else if (statuscode == 401){
                    
                }else {
                    self.createAlert(title: kAppName, message: kServerError)
                }
            }else{
                KRProgressHUD.dismiss()
                self.refreshControl.endRefreshing()
            }
            
        })
    }
}

