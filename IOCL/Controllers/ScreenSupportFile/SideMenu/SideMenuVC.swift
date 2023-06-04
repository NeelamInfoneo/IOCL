//
//  SideMenuVC.swift
//  IOCL
//
//  Created by infoneo on 26/12/22.
//

import UIKit

class SideMenuVC: UIViewController {

    //MARK: - VARIABLES -
    
    
   var sideMenuOptions = ["Home", "My Account", "Complaint Entry", "Vehical Requistion", "Out station", "Feedback/Survey/Quiz", "Notification" , "Logout" ]
    
 
    
    
    
    //MARK: - OUTLETS -
   
    @IBOutlet weak var tableView: UITableView!
    
  

    
    //MARK: - VIEW LIFE CYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        Log(self)
   
        setvc()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //MARK: - ACTIONS -
   
    //MARK: - FUNCTIONS -
    private func setvc() {
      
        ///connectors
        tableView.registerCell(type: ComplainHeaderTableViewCell.self)
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
extension SideMenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = HomeVC.instantiate(fromAppStoryboard: .User)
            self.navigationController?.pushViewController(vc, animated: false)
            dismiss(animated: false)
        case 1:
            let vc = ProfileVC.instantiate(fromAppStoryboard: .User)
            self.navigationController?.pushViewController(vc, animated: false)
            dismiss(animated: false)
        case 2:
            let vc = ComplaintHistoryViewController.instantiate(fromAppStoryboard: .User)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc = VehicleRequisitionHistoryVC.instantiate(fromAppStoryboard: .User)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = OutstationLeaveHistoryVC.instantiate(fromAppStoryboard: .User)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = FeedbackOptionVC.instantiate(fromAppStoryboard: .User)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 6:
            let vc = NotificationVC.instantiate(fromAppStoryboard: .User)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 7:
            self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kLogoutMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
                
            }, btnTwoTitle: "Logout") {_ in
                kUserDefaults.resetUserDefault()
                kUserDefaults.saveBool(false, forKey: .isLoggedIn)
                kAppDelegate.setAppRootVC()
            }
            break
            
        default:
            break
        }
        
    }
           
}
//MARK: - TABLEV VIEW DATASOURCE -
extension SideMenuVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
            return self.sideMenuOptions.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueCell(withType: ComplainHeaderTableViewCell.self, for: indexPath) as? ComplainHeaderTableViewCell else {
            fatalError("ComplainHeaderTableViewCell is not initialize...")
        }
     
            cell.headingLbl.text = self.sideMenuOptions[indexPath.row]

        return cell
    }
    
   
    
}

