//
//  WellcomeScreenVC.swift
//  IOCL
//
//  Created by InfoneoMacMini on 19/01/23.
//

import UIKit

class WellcomeScreenVC: UIViewController {

    @IBOutlet weak var topView: UIView!
      override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      }
      @IBAction func LoginWithLDapBtnAction(_ sender: UIButton) {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
          viewController.userType = "LDAP Login"
            self.navigationController?.pushViewController(viewController, animated: true)
      }
      @IBAction func employeeLoginBtnAction(_ sender: UIButton) {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
          viewController.userType = "Employee Login"
            self.navigationController?.pushViewController(viewController, animated: true)
      }
    }
