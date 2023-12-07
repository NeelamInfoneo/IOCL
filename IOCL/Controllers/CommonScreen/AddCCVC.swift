//
//  AddCCVC.swift
//  IOCL
//
//  Created by neelam  on 06/03/23.
//

import UIKit

protocol CCDataPass{
    func ccDataPassing(CC_MAIL :String)
}
class AddCCVC: UIViewController {

    @IBOutlet weak var ccText: UITextField!

    var CCDataDelagte : CCDataPass!
    var  CC_MAIL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitBtnAction(_ sender: UIButton) {
        let updateCCText = "\(CC_MAIL),\(ccText.text ?? "")"
        CCDataDelagte.ccDataPassing(CC_MAIL: updateCCText)
        dismiss(animated: true)
    }
    
    @IBAction func exitBtnAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
}
