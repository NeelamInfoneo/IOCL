//
//  AllQuizListingVC.swift
//  IOCL
//
//  Created by neelam  on 24/03/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class AllQuizListingVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
  
    @IBOutlet weak var topView: UIView!

    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var UserType = UserDefaults.standard.value(forKey: "UserType") as? Int
    var QuizData : [QuizModelData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CallForGetQuizListAPI()
        setvc()
    }
    
    private func setvc() {
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
      
       }
    //------ All Button Action-------//
 
    @IBAction func backbtnAction(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        
    }
  
    @IBAction func tapOnStartQuizBtn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "QuizVC") as! QuizVC
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    //------TableView Delegate and DataSource-------//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuizData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
        cell.titletext.text = QuizData?[indexPath.row].TITLE
        cell.destext.text = QuizData?[indexPath.row].ORGANIZING_DEPT

        cell.startDateLbl.text = QuizData?[indexPath.row].START_DATETIME?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss" , convertTo: "dd/MM/YYYY") ?? ""
        cell.endDateLbl.text = QuizData?[indexPath.row].END_DATETIME?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss" , convertTo: "dd/MM/YYYY") ?? ""
        
        cell.totalTimeLbl.text = "\(QuizData?[indexPath.row].TOTAL_TIME_IN_MIN ?? 0)"
        cell.totalQuestionLbl.text = "\(QuizData?[indexPath.row].TOTAL_QUESTION ?? 0)"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        
        
    }
    
  
    
    func CallForGetQuizListAPI(){
        ServiceRequest.shared.GetQuizListApi(nil, completionHandler: { isSucess, response, errorMsg in
                let dict = response
                print("JSON: \(dict)")
                let statuscode = dict?["statuscode"] as? Int
                let message = dict?["message"] as? String
                if (statuscode == 200){
                    let userData = dict?["data"] as! [[String:Any]]
                    var Mobj = [QuizModelData]()
                    for item in userData {
                        let obj = QuizModelData.init(item)
                        Mobj.append(obj)
                    }
                    self.QuizData = Mobj
                    self.tableView.reloadData()
                }else{
                 KRProgressHUD.dismiss()
                  self.createAlert(title: kAppName, message: message ?? "")
            }

        })
    }
}

