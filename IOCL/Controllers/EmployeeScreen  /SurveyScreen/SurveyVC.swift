//
//  SurveyVC.swift
//  IOCL
//
//  Created by neelam  on 19/03/23.
//

import UIKit
import SideMenu
import Alamofire
import KRProgressHUD

class SurveyVC: UIViewController {

    
    //MARK: -VARIABLES-
   var Token = UserDefaults.standard.value(forKey: "Token") as? String
   var listData : SurveyListData?
   var TotalQuestions : Int = 0
   var currentQuestionNo : Int = 0
   
    //MARK: -OUTLETS-
   
    @IBOutlet weak var tableview: UITableView!
   
    //MARK: -VIEW LIFE CYCLE-
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectors()
      
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
        tableview.registerCell(type: RemarkSurveyTableViewCell.self)
        tableview.registerCell(type: QBQuestionableViewCell.self)
        tableview.registerCell(type: QBOptionsTableViewCell.self)
        tableview.registerCell(type: QuizNextSubmitTableViewCell.self)
    
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
extension SurveyVC : UITableViewDataSource {
   
   func numberOfSections(in tableView: UITableView) -> Int {
       return 4
   }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       switch section {
       case 0 :
           return 1
       case 1:
           return (listData?.listQuestions?[self.currentQuestionNo].OptionList?.count ?? 0) + 1
       case 2:
           return listData?.listQuestions?[self.currentQuestionNo].showRemark == true ? 1 : 0
       case 3:
           return 1
       default :
           return 0
       }
       
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       switch indexPath.section {
       case 0:
           return questionCell(tableView, cellForRowAt: indexPath)
       case 1:
           return answerCell(tableView, cellForRowAt: indexPath)
       case 2:
           return remarkCell(tableView, cellForRowAt: indexPath)
       case 3:
           return nextSubmitCell(tableView, cellForRowAt: indexPath)
       default :
           return UITableViewCell()
       }
   }
   
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      return nil
   }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 0.10
   }
}

//MARK: -FUNCTIONS-
extension SurveyVC : UITableViewDelegate {
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if indexPath.section == 1 {
           if indexPath.row == self.listData?.listQuestions?[self.currentQuestionNo].OptionList?.count {
               self.listData?.listQuestions?[self.currentQuestionNo].SelectedOption = "N/A"
           }else {
               let OptionId =  self.listData?.listQuestions?[self.currentQuestionNo].OptionList?[indexPath.row].Option
               self.listData?.listQuestions?[self.currentQuestionNo].SelectedOption = OptionId ?? "-1"
           }
        if indexPath.row == 0 || indexPath.row == self.listData?.listQuestions?   [self.currentQuestionNo].OptionList?.count {
               self.listData?.listQuestions?[self.currentQuestionNo].showRemark = true
           }else {
               self.listData?.listQuestions?[self.currentQuestionNo].showRemark = false
           }
           self.tableview.reloadData()
       }
    }
}


// tableView  cells functions
extension SurveyVC {
   
   private func questionCell(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableview.dequeueCell(withType: QBQuestionableViewCell.self, for: indexPath) as? QBQuestionableViewCell else {
           fatalError("QBQuestionableViewCell is not initialize...")
       }
      
       cell.quesTxtView.text = self.listData?.listQuestions?[self.currentQuestionNo].QUES
    
       return cell
   }
   
   private func answerCell(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableview.dequeueCell(withType: QBOptionsTableViewCell.self, for: indexPath) as? QBOptionsTableViewCell else {
           fatalError("QBOptionsTableViewCell is not initialize...")
       }
      
       
       
       if indexPath.row == self.listData?.listQuestions?[self.currentQuestionNo].OptionList?.count {
           cell.optionLbl.text = "N/A"
           
           if self.listData?.listQuestions?[self.currentQuestionNo].SelectedOption == "N/A" {
               cell.setSelectedCell()
           }else {
               cell.setNormalCell()
           }
           
       }else {
           let data = self.listData?.listQuestions?[self.currentQuestionNo].OptionList?[indexPath.row]
           
           cell.optionLbl.text = data?.Option
           if self.listData?.listQuestions?[self.currentQuestionNo].SelectedOption == data?.Option {
               cell.setSelectedCell()
           }else {
               cell.setNormalCell()
           }
       }
       
       
       return cell
   }
   
   private func remarkCell(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableview.dequeueCell(withType: RemarkSurveyTableViewCell.self, for: indexPath) as? RemarkSurveyTableViewCell else {
           fatalError("RemarkSurveyTableViewCell is not initialize...")
       }
       cell.remarktextView.text = self.listData?.listQuestions?[self.currentQuestionNo].Remark
       
       cell.remarkCallBack = { text in
           self.listData?.listQuestions?[self.currentQuestionNo].Remark = text
       }
       
       return cell
   }
   
   private func nextSubmitCell(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableview.dequeueCell(withType: QuizNextSubmitTableViewCell.self, for: indexPath) as? QuizNextSubmitTableViewCell else {
           fatalError("QuizNextSubmitTableViewCell is not initialize...")
       }
       
       cell.QuestionCountLbl.attributedText = self.multipleFontText(str1: "\(self.currentQuestionNo + 1)", str2: kSpace + kOf + kSpace + "\(self.TotalQuestions)")
       if self.currentQuestionNo == 0 {
           cell.prevBtn.isHidden = true
       }else {
           cell.prevBtn.isHidden = false
       }
       
//        if self.currentQuestionNo + 1 == self.TotalQuestions {
//            cell.nextBtn.isHidden = true
//        }else {
//            cell.nextBtn.isHidden = false
//        }
       
       cell.nextBtnCallBack = {
           self.view.endEditing(true)
           self.currentQuestionNo += 1
           if self.currentQuestionNo >= self.TotalQuestions {
               self.createAlert(title: kAppName, message: "Quiz ended")
           }else {
               tableview.reloadData()
           }
       }
       
       cell.backBtnCallBack = {
           self.view.endEditing(true)
           self.currentQuestionNo -= 1
           tableview.reloadData()
       }
       
       cell.submitBtnCallback = {
           self.view.endEditing(true)
           
           self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: "Are you sure! Want to Exit", btnOneTitle: "Yes", btnOneTapped: { ok in
               self.CallForSurveySubmitAPI()
           }, btnTwoTitle: "No") { no in
               print("do nothing")
           }
       }
       
       return cell
   }
   
}

extension SurveyVC {
   
   //MARK: - CallForSurveySubmit History API CALLING FUNCTIONS ------------------------------------------
   func CallForSurveySubmitAPI() {
    
       var param : [String: Any] = [:]
    
       
       var jsonStirng : [[String: Any]] = []
       
       for i in 0..<(listData?.listQuestions?.count ?? 1) {
           let ques = ["QID" : listData?.listQuestions?[i].QUES_ID ?? 0 ,
                       "ANSWER" : listData?.listQuestions?[i].SelectedOption ?? "" ,
                       "REMARKS" : listData?.listQuestions?[i].Remark ?? ""] as [String : Any]
           jsonStirng.append(ques)
           print(ques)
       }
       param = ["SURVEY_ID" : listData?.SURVEY_ID ?? 0 ,
                "JsonString" : jsonStirng.toJSONString()]
       print(param)
       ServiceRequest.shared.ParticipateInSurveyApi(param, completionHandler: { isSucess, response, errorMsg in
           KRProgressHUD.dismiss()
               let dict = response
               print("JSON: \(dict)")
                let statuscode = dict?["statuscode"] as? Int
           let message = dict?["message"] as? String
               if (statuscode == 200){
                   self.backPreviousPage()
               }else if (statuscode == 401){
                   
               }else if (statuscode == 300) {
                   
               self.createAlert(title: kAppName, message: message ?? "")
           }
       })
   }
}







