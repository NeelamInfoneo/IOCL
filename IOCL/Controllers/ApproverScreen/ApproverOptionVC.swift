//
//  ApproverOptionVC.swift
//  IOCL
//
//  Created by neelam  on 10/04/23.
//

import UIKit

class ApproverOptionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func tapOnVehicleRequestBtn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Approver", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ApproverVehicleListVC") as! ApproverVehicleListVC
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    @IBAction func tapOnOutstatiojnRequestBtn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Approver", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ApproverOutStationListVC") as! ApproverOutStationListVC
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

}
