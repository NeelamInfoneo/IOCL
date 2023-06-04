//
//  QuizVC.swift
//  IOCL
//
//  Created by neelam  on 19/03/23.
//

import UIKit
import KRProgressHUD
import Alamofire

class QuizVC: UIViewController {

    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var QuizData : QuizModelData?
    var TotalQuestions : Int = 0
    var currentQuestionNo : Int = 0
    //MARK: -OUTLETS-
   
    @IBOutlet weak var tableview: UITableView!
 
    //MARK: -VIEW LIFE CYCLE-
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectors()
        CallForGetQuizAPI()
      
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       
    }
  
    //MARK: -FUNCTIONS-
    @IBAction func backbtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    private func connectors() {
        
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        //register Cells
        tableview.registerCell(type: QBQuestionableViewCell.self)
        tableview.registerCell(type: QBOptionsTableViewCell.self)
        tableview.registerCell(type: QuizNextSubmitTableViewCell.self)
        
       
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
extension QuizVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let OptionId = self.QuizData?.QuestionList?[self.currentQuestionNo].OptionList?[indexPath.row].OPTION_ID
        
        self.QuizData?.QuestionList?[self.currentQuestionNo].SelectedOption = OptionId ?? -1
        self.tableview.reloadData()
        
    }
    
}
//MARK: -FUNCTIONS-
extension QuizVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return section == 1 ? self.QuizData?.QuestionList?[self.currentQuestionNo].OptionList?.count ?? 0 : 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return questionCell(tableView, cellForRowAt: indexPath)
        case 1:
            return answerCell(tableView, cellForRowAt: indexPath)
        case 2:
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


// tableView  cells functions
extension QuizVC {
    
    private func questionCell(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueCell(withType: QBQuestionableViewCell.self, for: indexPath) as? QBQuestionableViewCell else {
            fatalError("QBQuestionableViewCell is not initialize...")
        }
        
        cell.quesTxtView.text = self.QuizData?.QuestionList?[self.currentQuestionNo].QUESTIONS
     
        return cell
    }
    
    private func answerCell(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueCell(withType: QBOptionsTableViewCell.self, for: indexPath) as? QBOptionsTableViewCell else {
            fatalError("QBOptionsTableViewCell is not initialize...")
        }
        let data = self.QuizData?.QuestionList?[self.currentQuestionNo].OptionList?[indexPath.row]
        
        cell.optionLbl.text = data?.OPTION_TEXT
        
      
        if self.QuizData?.QuestionList?[self.currentQuestionNo].SelectedOption == data?.OPTION_ID {
            cell.setSelectedCell()
        }else {
            cell.setNormalCell()
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
        
        cell.nextBtnCallBack = {
            self.currentQuestionNo += 1
            if self.currentQuestionNo >= self.TotalQuestions {
                self.createAlert(title: kAppName, message: "Quiz ended")
            }else {
                tableview.reloadData()
            }
        }
        
        cell.backBtnCallBack = {
            self.currentQuestionNo -= 1
            tableview.reloadData()
        }
        
        cell.submitBtnCallback = {
            self.presentAlertViewWithTwoButtons(alertTitle: kAppName, alertMessage: "Are you sure! Want to Exit", btnOneTitle: "Yes", btnOneTapped: { ok in
                self.backPreviousPage()
            }, btnTwoTitle: "No") { no in
                print("do nothing")
            }
        }
        
        return cell
    }
    
}

extension QuizVC {
    
    //MARK: - CallForGetOutstationAPI History API CALLING FUNCTIONS ------------------------------------------
    
    func CallForGetQuizAPI() {
     
        var param: [String: Any] = [:]
        param["QUIZNO"] = 1
        
        ServiceRequest.shared.GetQuizFullDetailApi(param, completionHandler: { isSucess, response, errorMsg in
           let dict = response
                print("JSON: \(dict)")
                 let statuscode = dict?["statuscode"] as? Int
            let message = dict?["message"] as? String
                if (statuscode == 200){
                   let data = dict?["data"] as! [String:Any]
                    let obj = QuizModelData.init(data)
                    self.QuizData = obj
                    self.TotalQuestions = self.QuizData?.QuestionList?.count ?? 0
                    self.tableview.reloadData()
                }else if (statuscode == 401){
                }else {
               
                self.createAlert(title: kAppName, message: message ?? "")
            }
        })
    }

    
    //MARK: - CallForGetOutstationAPI History API CALLING FUNCTIONS ------------------------------------------
    
 
}




