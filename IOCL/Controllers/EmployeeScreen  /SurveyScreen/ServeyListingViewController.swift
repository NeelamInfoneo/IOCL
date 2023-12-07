//
//  ServeyListingViewController.swift
//  IOCL
//
//  Created by infoneo on 19/04/23.
//

import UIKit
import KRProgressHUD
import Alamofire

class ServeyListingViewController: UIViewController {

    //MARK: -VARIABLES-
   var Token = UserDefaults.standard.value(forKey: "Token") as? String
 
   var TotalQuestions : Int = 0
   var currentQuestionNo : Int = 0
    var surveyList : [SurveyListData]?
    var userType = String()
    //MARK: -OUTLETS-
   
    @IBOutlet weak var tableview: UITableView!
   
    //MARK: -VIEW LIFE CYCLE-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectors()
        CallForGetSurveyAPI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       
    }
    
    //MARK: -FUNCTIONS-
    
    private func connectors() {
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        //register Cells
        tableview.registerCell(type: SurveyListCell.self)
    
    }
   @IBAction func backBtnAction(_ sender: UIButton) {
       navigationController?.popViewController(animated: true)
   }
   
   //MARK: -MULTIPLE FONT SET FOR NAME LABEL-
   func multipleFontText(str1: String, str2: String) -> NSMutableAttributedString{
       let attrs1 = [NSAttributedString.Key.font : UIFont.Inter(.bold, size: .oneFour), NSAttributedString.Key.foregroundColor :UIColor.appColor(.appOrange)]
       let attrs2 = [NSAttributedString.Key.font : UIFont.Inter(.medium, size: .oneFour), NSAttributedString.Key.foregroundColor : UIColor .appColor(.appTextColor)]
       let attributedString1 = NSMutableAttributedString(string:"\(str1)", attributes:attrs1 as [NSAttributedString.Key : Any])
       let attributedString2 = NSMutableAttributedString(string:"\(str2)", attributes:attrs2 as [NSAttributedString.Key : Any])
       attributedString1.append(attributedString2)
       return attributedString1
   }
    
}
//MARK: -FUNCTIONS-
extension ServeyListingViewController : UITableViewDataSource {
   
   func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return self.surveyList?.count ?? 0
       
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return questionCell(tableView, cellForRowAt: indexPath)
      
   }
   
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      return nil
   }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
              return 0.10
   }
}

//MARK: -FUNCTIONS-
extension ServeyListingViewController : UITableViewDelegate {
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if userType == "SurveyAdmin" {
           let vc = PieChartViewController.instantiate(fromAppStoryboard: .SurveyAdmin)
           self.navigationController?.pushViewController(vc, animated: true)
           
       }else{
           let vc = SurveyVC.instantiate(fromAppStoryboard: .User)
           vc.TotalQuestions = self.surveyList?.count ?? 0
           vc.listData = self.surveyList?[indexPath.row]
           
           self.navigationController?.pushViewController(vc, animated: true)
       }
       
    
   }
   
}


// tableView  cells functions
extension ServeyListingViewController {
   
   private func questionCell(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableview.dequeueCell(withType: SurveyListCell.self, for: indexPath) as? SurveyListCell else {
           fatalError("QBQuestionableViewCell is not initialize...")
       }
       cell.questionLbl.text = self.surveyList?[indexPath.row].SURVEY_DESC ?? ""
       cell.topicLbl.text = self.surveyList?[indexPath.row].TOPIC_DESC ?? ""
       return cell
   }
 
}

extension ServeyListingViewController {
    
    //MARK: - CallForGetOutstationAPI History API CALLING FUNCTIONS ------------------------------------------
    
    func CallForGetSurveyAPI() {
      
        ServiceRequest.shared.GetSurveyListApi(nil, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
                let dict = response
                print("JSON: \(dict)")
                 let statuscode = dict?["statuscode"] as? Int
                if (statuscode == 200){
                   let data =  dict?["data"] as! [[String:Any]]
                    var val = [SurveyListData]()
                    for item in data {
                        let obj = SurveyListData.init(item)
                        val.append(obj)
                    }
                    self.surveyList = val
                    self.tableview.reloadData()
                }else if (statuscode == 401){
                }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
}







