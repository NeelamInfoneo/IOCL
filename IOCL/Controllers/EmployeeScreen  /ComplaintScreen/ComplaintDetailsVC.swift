//
//  ComplaintDetailsVC.swift
//  IOCL
//
//  Created by neelam  on 18/04/23.
//

import UIKit
import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD
class ComplaintDetailsVC: UIViewController {

        
        @IBOutlet weak var tableView: UITableView!
   
        @IBOutlet weak var empNOLbl: UILabel!
        @IBOutlet weak var empNameLbl: UILabel!
        @IBOutlet weak var designationLbl: UILabel!
        @IBOutlet weak var companyCategoryLbl: UILabel!
        @IBOutlet weak var companySubCategoryLbl: UILabel!
        @IBOutlet weak var companySubSubCategoryLbl: UILabel!
        @IBOutlet weak var officeLocationLbl: UILabel!
        @IBOutlet weak var qtrNoLbl: UILabel!
        @IBOutlet weak var desText: UITextView!
        var Token = UserDefaults.standard.value(forKey: "Token") as? String

        var  selectType = String()
  
        var complaintID = Int()
        var empNOValue = Int()
        var empNameValue = String()
        var designationValue = String()
        var companyCategoryValue = String()
        var companySubCategoryValue = String()
        var companySubSubCategoryValue = String()
        var officeLocationValue = String()
        var complaintStatus = String()
        var complaintStatusID = Int()
        var QTRNO = String()
        var Remark = String()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            empNOLbl.text = "Emplopyee No.\(empNOValue)"
            empNameLbl.text = empNameValue
            designationLbl.text = designationValue
            companyCategoryLbl.text = companyCategoryValue
            companySubCategoryLbl.text = companySubCategoryValue
            companySubSubCategoryLbl.text = companySubSubCategoryValue
            officeLocationLbl.text = officeLocationValue
            qtrNoLbl.text = QTRNO
            desText.text =  Remark
        
        }
   
        @IBAction func backBtnAction(_ sender: UIButton) {
            dismiss(animated: true)
            
        }
   
    
        
    }
    //MARK: - TABLEV VIEW DATASOURCE -
    extension ComplaintDetailsVC: UITableViewDataSource , UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
            
            
            return cell
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 0
            
        }
        
        
    }
