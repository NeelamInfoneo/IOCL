//
//  SurveyModel.swift
//  IOCL
//
//  Created by neelam  on 24/04/23.
//

import UIKit


struct SurveyModelData {
    var RowNum ,  QID : Int?
    var Question, HighlySatisfied, Satisfied, NeedImprovement ,DisSatisfied , HighlyDisSatisfied, WeightedScore  : String?

init(_ data : [String : Any]) {
    
    if let RowNum = data["RowNum"] as? Int {
        self.RowNum = RowNum
    }
    
    if let QID = data["QID"] as? Int {
        self.QID = QID
    }
    if let Question = data["Question"] as? String {
        self.Question = Question
    }
    if let HighlySatisfied = data["HighlySatisfied"] as? String {
        self.HighlySatisfied = HighlySatisfied
    }
    if let Satisfied = data["Satisfied"] as? String {
        self.Satisfied = Satisfied
    }
    if let NeedImprovement = data["NeedImprovement"] as? String {
        self.NeedImprovement = NeedImprovement
    }
    if let DisSatisfied = data["DisSatisfied"] as? String {
        self.DisSatisfied = DisSatisfied
    }
    if let HighlyDisSatisfied = data["HighlyDisSatisfied"] as? String {
        self.HighlyDisSatisfied = HighlyDisSatisfied
    }
    if let WeightedScore = data["WeightedScore"] as? String {
        self.WeightedScore = WeightedScore
    }
    
  }
}

