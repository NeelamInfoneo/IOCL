//
//  FeedbackVC.swift
//  IOCL
//
//  Created by neelam  on 19/03/23.
//

import UIKit

class FeedbackVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}
