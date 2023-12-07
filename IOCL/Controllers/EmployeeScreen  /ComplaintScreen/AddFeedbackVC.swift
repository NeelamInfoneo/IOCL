//
//  AddFeedbackVC.swift
//  IOCL
//
//  Created by InfoneoMacMini on 23/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD
import Cosmos

class AddFeedbackVC: UIViewController {
    
    let searchBtn = UIButton()
    //MARK: - OUTLETS -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var complaintIDText: UITextField!
    @IBOutlet weak var compalintStatusText: UITextField!
    @IBOutlet weak var complaintDateText: UITextField!
    @IBOutlet weak var quaterNoText: UITextField!
    @IBOutlet weak var complaintDesText: UILabel!
    @IBOutlet weak var feedbackText: UITextView!
    @IBOutlet weak var ratingView: CosmosView!
    var COMP_ID = Int()
    var compalintStatusValue = String()
    var complaintDateValue = String()
    var complaintDesValue  = String()
    var compalintedDateValue = String()
    var feedbackCode = String()
    var quaterNo = String()
    var ratingValue = String()
    var remarkValue = String()
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    
    //MARK: - VIEW LIFE CYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        complaintIDText.text = "\(COMP_ID)"
        ratingView.didTouchCosmos = didTouchCosmos
        feedbackText.text = remarkValue
        quaterNoText.text = quaterNo
        compalintStatusText.text = compalintStatusValue
        complaintDateText.text = complaintDateValue
        complaintDesText.text = complaintDesValue
        quaterNoText.setLeftPaddingPoints(10)
        compalintStatusText.setLeftPaddingPoints(10)
        complaintDateText.setLeftPaddingPoints(10)
        quaterNoText.setLeftPaddingPoints(10)
        complaintIDText.setLeftPaddingPoints(10)
        ratingView.settings.fillMode = .full
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRating(requiredRating: Double(ratingValue))
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //MARK: - ACTIONS -
    
    @IBAction func tapOnBackBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func tapOnSaveBtn(_ sender: UIButton) {
        if remarkValue != "" {
            self.createAlert(title: kAppName, message: kfeedbackMessage)
        }else{
            CallForAddComplaintFeedbackAPI()
        }
        
    }
    
    private func updateRating(requiredRating: Double?) {
        var newRatingValue: Double = 0
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        }
        ratingView.rating = newRatingValue
        ratingValue =  AddFeedbackVC.formatValue(newRatingValue)
        print("Rating \(ratingValue)")
    }
    
    private func didTouchCosmos(_ rating: Double) {
        updateRating(requiredRating: rating)
        CallForGetFeedbackCodeAPI()
    }
    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.0f", value)
    }
    //MARK: - FUNCTIONS -
    
    //MARK: - ADD COMPLAINT FEEDBACKAPI CALLING FUNCTIONS ------------------------------------------
    func CallForAddComplaintFeedbackAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
     
        var params = [String:Any]()
        params  = [
            "COMP_ID" : COMP_ID ,
            "FEEDBACK_CODE" :  self.ratingValue ,
            "FEEDBACK_TEXT" : feedbackText.text ?? ""
        ]
        
        ServiceRequest.shared.ComplaintFeedbackApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            
            let message = dict?["message"] as? String
            if (statuscode == 200){
                self.presentAlertViewWithOneButton(alertTitle: kAppName, alertMessage: message ?? "", btnOneTitle: "Ok") {_ in
                    self.dismiss(animated: true)
                }
            }else if (statuscode == 401){
                
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
        
    }
    
    func CallForGetFeedbackCodeAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        ServiceRequest.shared.GetFeedbackCodeApi(nil, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            
            let message = dict?["message"] as? String
            if (statuscode == 200){
                let dataUser = dict?["data"] as! [[String:Any]]
                for (i, item) in dataUser.enumerated() {
                    let Name = item["FEEDBACK_CODE"] as! String
                    if Name == self.ratingValue {
                        self.ratingValue = Name
                    }
                }
            }else if (statuscode == 401){
                
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: message ?? "")
            }
        })
        
    }
    
    
}

//MARK: - TABLE VIEW DELEGATE -
extension AddFeedbackVC: UITableViewDelegate {
    
    
}
//MARK: - TABLEV VIEW DATASOURCE -
extension AddFeedbackVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
        
        return cell
        
    }
    
    
}


