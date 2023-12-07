//
//  PieChartViewController.swift
//  IOCL
//
//  Created by infoneo on 14/04/23.
//

import UIKit
import DropDown
import AVFoundation
import Alamofire
import SwiftyJSON
import KRProgressHUD

class PieChartViewController: UIViewController {
    //MARK: - VARIABLES -
    var pieChartUnits : [Double] = [10, 30, 10, 50, 20]
    
    let dropDown = DropDown()
    //MARK: - OUTLETS -
    
    //MARK: - SURVEY VARIABLES -
    var surveyArray = [String]()
    var surveyID = Int()
    var surveyDataArray = [[String:Any]]()
    var dataArray = [SurveyModelData]()
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var surveyText: UILabel!
    @IBOutlet weak var surveyBtn: UIButton!
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    
    //MARK: - VIEW LIFE CYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        surveyText.textAlignment = .left
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
        CallForGetSurveyDataForAdminAPI()
        // surveyText.setLeftPaddingPoints(10)
        Log(self)
        setUpVC()
    }
    
    //MARK: - ACTIONS -
    
    //MARK: - PRIVATE FUNCTION -
    private func setUpVC(){
        
        self.setBackgroundImage()
        
        tableView.registerCell(type: AllotteeDescriptionChartTableViewCell.self)
        
        tableView.registerCell(type: SurveyDetailsCell.self)
        
        ///connectors for tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        dropDown.textFont = .Inter(.medium, size: .oneThree)
        dropDown.textColor = .appColor(.black)
        
        self.dropDown.anchorView = self.surveyBtn
        self.dropDown.width = self.surveyBtn.frame.size.width
        self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
        
    }
    
    @IBAction func tapOnBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func surveyBtnAction(_ sender: UIButton) {
        
        self.dropDown.show()
        
        /// Action triggered on selection
        self.dropDown.selectionAction = {  (index: Int, item: String) in
            print(index)
            print(item)
            self.surveyText.text = item
            
            let valueDisstatis = self.surveyDataArray[index]["DisSatisfied"]
            let DisSatisfied = (valueDisstatis as! NSString).doubleValue
            
            let HighlyDisSatisfiedString = self.surveyDataArray[index]["HighlyDisSatisfied"]
            let HighlyDisSatisfied = (HighlyDisSatisfiedString as! NSString).doubleValue
            
            let HighlySatisfiedString = self.surveyDataArray[index]["HighlySatisfied"]
            let HighlySatisfied = (HighlySatisfiedString as! NSString).doubleValue
            
            let NeedImprovementString = self.surveyDataArray[index]["NeedImprovement"]
            let NeedImprovement = (NeedImprovementString as! NSString).doubleValue
            
            let SatisfiedString = self.surveyDataArray[index]["Satisfied"]
            let Satisfied = (SatisfiedString as! NSString).doubleValue
            
            self.pieChartUnits = [HighlySatisfied, Satisfied, NeedImprovement, DisSatisfied, HighlyDisSatisfied]
            //            self.pieChartUnits = [30, 30, 30, 30, 30]
            print(self.pieChartUnits)
            
            self.tableView.reloadData()
        }
        
    }
    
}

//MARK: - API CALLING FUNCTIONS -
extension PieChartViewController {
    
    //MARK: - GetComplaintCategory API CALLING FUNCTIONS ------------------------------------------
    func CallForGetSurveyDataForAdminAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
    
        let param = ["SurveyId" : "1"]
        ServiceRequest.shared.GetSurveyDataForAdminApi(param, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
                let dict = response
                print("JSON: \(dict)")
                self.surveyArray = []
                let statuscode = dict?["statuscode"] as? Int
                if (statuscode == 200){
                    let dataDic = dict?["data"] as? [String:Any]
                    self.surveyDataArray = dataDic?["list"] as? [[String:Any]] ?? []
                    for item in self.surveyDataArray {
                        let Name = item["Question"] as! String
                        self.surveyArray.append(Name)
                    }
                    var Mobj = [SurveyModelData]()
                    for item in  self.surveyDataArray {
                        let obj = SurveyModelData.init(item)
                        Mobj.append(obj)
                    }
                    self.dataArray = Mobj
                    self.dropDown.dataSource = self.surveyArray
                    self.tableView.reloadData()
                }else if (statuscode == 401){
                    
                    
                }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
            
        })
        
    }
}


//MARK: - TABLE VIEW DELEGATE -
extension PieChartViewController: UITableViewDelegate {
    
}


//MARK: - TABLEV VIEW DATASOURCE -
extension PieChartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            return 1
        case 1:
            return self.dataArray.count
            
        default :
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return descriptionChartCell(tableView, cellForRowAt: indexPath)
        case 1:
            return surveyCell(tableView, cellForRowAt: indexPath)
            
        default :
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
}


//MARK: -Private functions-
extension PieChartViewController {
    
    private func descriptionChartCell(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: AllotteeDescriptionChartTableViewCell.self, for: indexPath) as? AllotteeDescriptionChartTableViewCell else {
            fatalError("AllotteeDescriptionChartTableViewCell is not initialize...")
        }
        
        cell.setChart(dataPoints: cell.investments, values: self.pieChartUnits)
        return cell
    }
    
    
    private func  surveyCell(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let surveyCell = tableView.dequeueCell(withType: SurveyDetailsCell.self, for: indexPath) as? SurveyDetailsCell else {
            fatalError("CommonCell is not initialize...")
        }
        surveyCell.highlySatisfiedLbl.text = "\(dataArray[indexPath.row].HighlySatisfied ?? "") %"
        surveyCell.satisfiedLbl.text = "\(dataArray[indexPath.row].Satisfied ?? "")  %"
        surveyCell.needsImprovementLbl.text = "\(dataArray[indexPath.row].NeedImprovement ?? "")  %"
        surveyCell.dissatisfiedLbl.text = "\(dataArray[indexPath.row].DisSatisfied ?? "")  %"
        surveyCell.highlyDissatisfedLbl.text = "\(dataArray[indexPath.row].HighlyDisSatisfied ?? "")  %"
        surveyCell.questionLbl.text = "Q." + ("\(dataArray[indexPath.row].RowNum ?? 0) %")  +  " " + (dataArray[indexPath.row].Question ?? "") + "%"
        surveyCell.weightedScorelbl.text = "\(dataArray[indexPath.row].WeightedScore ?? "") %"
        return surveyCell
    }

    
    
}


