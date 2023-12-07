//
//  HomeVC.swift
//  IOCL
//  Created by infoneo on 20/12/22.
//

import UIKit
import SideMenu
import Alamofire
import KRProgressHUD


class HomeVC: UIViewController {

    //MARK: - VARIABLES -
    //MARK: - OUTLETS -
   
    @IBOutlet weak var tableOuterView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profile_img: UIImageView!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var empCode_lbl: UILabel!
    @IBOutlet weak var designation_lbl: UILabel!
    var EMPNO = UserDefaults.standard.value(forKey: "EMPNO") as? String
    var outStationData = Bool()

    //MARK: - VIEW LIFE CYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
       let intValue = 9876543211.0
        Log(self)
        setvc()
        print(UIDevice.current.getIP())
        name_lbl.text = "Wellcome : \(kUserDefaults.retriveString(.FIRST_NAME))"
        designation_lbl.text = "Designation : \(kUserDefaults.retriveString(.DESIGNATION))"
        empCode_lbl.text = "Emp Number : \(kUserDefaults.retriveString(.EMPNO))"
       CallForCheckOutstationApproverAPI()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profile_img.layer.cornerRadius = 40
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //MARK: - ACTIONS -
    @IBAction func tapOnNotificationBtn(_ sender: Any) {
     
        let vc = NotificationVC.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapOnEditProfileBtn(_ sender: Any) {
        let vc = ProfileVC.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: false)
        dismiss(animated: false)
    }
    
    @IBAction func tapOnSideMenuBtn(_ sender: Any) {
        let sidemenu = SideMenuVC.instantiate(fromAppStoryboard: .User)
        let menu = SideMenuNavigationController(rootViewController: sidemenu)
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        present(menu, animated: true, completion: nil)
        //   self.createAlert(title: kAppName, message: kComingSoon)
    }
    
    //MARK: - FUNCTIONS -
    private func setvc() {
      
        tableOuterView.roundCornerUp(40)
        let nibName = UINib(nibName: "HomeHeaderView", bundle: nil)
        self.tableView.register(nibName, forHeaderFooterViewReuseIdentifier: "HomeHeaderView")
        ///connectors
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.makeRoundCorner(12)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - TABLE VIEW DELEGATE -
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 550
    }
}
//MARK: - TABLEV VIEW DATASOURCE -
extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeHeaderView")  as! HomeHeaderView
        let IsCarRequestAdmin = UserDefaults.standard.value(forKey: "IsCarRequestAdmin") as? Bool
        let IsApproverAdmin = UserDefaults.standard.value(forKey: "IsApproverAdmin") as? Bool
        let IsHRSurveyAdmin = UserDefaults.standard.value(forKey: "IsHRSurveyAdmin") as? Bool
        let IsComplaintAdmin = UserDefaults.standard.value(forKey: "IsComplaintAdmin") as? Bool
        if IsCarRequestAdmin == false && IsApproverAdmin == false && IsHRSurveyAdmin == false && IsComplaintAdmin == false {
            view.adminView.constant = 0
            view.haderTitleLbl.isHidden = true
        }
        view.vehcleRegistrationAdminView.isHidden = !(IsCarRequestAdmin ?? true)
        view.outStationAdminView.isHidden = !(IsApproverAdmin ?? true)
        view.feedbackAdminview.isHidden = !(IsHRSurveyAdmin ?? true)
        view.complaintAdminView.isHidden = !(IsComplaintAdmin ?? true)
        view.outStationAdminView.isHidden = !self.outStationData 
        
        view.callBack = { value in
            switch value {
            case 1:  ///for Complaint
                print("tap On Home Complaint btn")
                let vc = ComplaintHistoryViewController.instantiate(fromAppStoryboard: .User)
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:  ///for Vehcle Registration
                print("tap On Home Vehcle Registration btn")
                let vc = VehicleRequisitionHistoryVC.instantiate(fromAppStoryboard: .User)
                self.navigationController?.pushViewController(vc, animated: true)
                //self.createAlert(title: kAppName, message: kComingSoon)
            case 3: ///for Leave Application
                print("tap On Home Leave Application btn")
                let vc = OutstationLeaveHistoryVC.instantiate(fromAppStoryboard: .User)
                self.navigationController?.pushViewController(vc, animated: true)
            case 4:  ///for Feedback
                print("tap On Home Leave Application btn")
                let vc = FeedbackOptionVC.instantiate(fromAppStoryboard: .User)
                self.navigationController?.pushViewController(vc, animated: true)
            case 5:  ///for banner
                print("tap On Home banner btn")
                self.createAlert(title: kAppName, message: kComingSoon)
            case 6:  ///for Complaint
                print("tap On Home Complaint btn")
                let vc = ComplaintReqestListVC.instantiate(fromAppStoryboard: .HrAdmin)
                self.navigationController?.pushViewController(vc, animated: true)
            case 7:  ///for Vehcle Registration
                print("tap On Home Vehcle Registration btn")
                let vc = ApproverApprovedVehiclelIstVC.instantiate(fromAppStoryboard: .HrAdmin)
                self.navigationController?.pushViewController(vc, animated: true)
                //self.createAlert(title: kAppName, message: kComingSoon)
            case 8: ///for Leave Application
                print("tap On Home Leave Application btn")
                let vc = ApproverOptionVC.instantiate(fromAppStoryboard: .User)
                self.navigationController?.pushViewController(vc, animated: true)
            case 9:  ///for Feedback
                print("tap On Home Leave Application btn")
                let vc = ServeyListingViewController.instantiate(fromAppStoryboard: .User)
                vc.userType = "SurveyAdmin"
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 10:  ///for Feedback
                print("tap On Home Leave Application btn")
                let vc = PatientViewController.instantiate(fromAppStoryboard: .HMS)
                self.navigationController?.pushViewController(vc, animated: true)
                
                default:
                print("tap not found")
            }
            
        }
        return view
       
    }
    

}
//MARK: - ORDER LIST API -
extension HomeVC {

    //MARK: - CheckOutstationApprover History API CALLING FUNCTIONS ------------------------------------------
    
    func CallForCheckOutstationApproverAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        ServiceRequest.shared.GetCheckOutstationApprover(nil, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            if response != nil{
                let dict = response
                print("JSON: \(response)")
            }else{
                KRProgressHUD.dismiss()
            }
           // self.outStationData = (dict?["data"] as! Bool)
        })
    }
    
   
    
}

extension UIDevice {
    
    /**
     Returns device ip address. Nil if connected via celluar.
     */
    func getIP() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
    if getifaddrs(&ifaddr) == 0 {
            
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next } // memory has been renamed to pointee in swift 3 so changed memory to pointee
                
                guard let interface = ptr?.pointee else {
                    return nil
                }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    guard let ifa_name = interface.ifa_name else {
                        return nil
                    }
                    let name: String = String(cString: ifa_name)
                    
                    if name == "en0" {  // String.fromCString() is deprecated in Swift 3. So use the following code inorder to get the exact IP Address.
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                    
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
    
}
