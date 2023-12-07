//
//  PatientDetailsViewController.swift
//  IOCL
//
//  Created by neelam  on 15/05/23.
//

import UIKit

class PatientDetailsViewController: UIViewController {
    var selectType = String()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ApproveBtnAction(_ sender: UIButton) {
        
        self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kApproveMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
            
        }, btnTwoTitle: "Approve") {_ in
            self.selectType = "Approved"
            
        }
        
        
    }
    
         @IBAction func backBtnAction(_ sender: UIButton) {
             dismiss(animated: true)
             
         }
    @IBAction func rejectBtnAction(_ sender: UIButton) {
        
        self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: kApproveMessage, btnOneTitle: "Cancel", btnOneTapped: {_ in
            
        }, btnTwoTitle: "Rejected") {_ in
            self.selectType = "Rejected"
           // self.CallForOutstationRequestApproveByApproverAPI(selectType: self.selectType)
        }
        
    }
    

}
//MARK: - TABLE VIEW DELEGATE -
extension PatientDetailsViewController: UITableViewDelegate {
    
}

//MARK: - TABLEV VIEW DATASOURCE -
extension PatientDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
    
        return cell
    }
}
