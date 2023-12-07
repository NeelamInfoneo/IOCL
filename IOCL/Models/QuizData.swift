//
//  QuizData.swift
//  IOCL
//
//  Created by infoneo on 21/03/23.
//

import Foundation


struct QuizModelData {
    var QUIZNO, TOTAL_QUESTION, TOTAL_TIME_IN_MIN , TOTAL_QUES_INONE_SCREEN, COMPANY_CODE : Int?
    var TITLE, START_DATETIME, END_DATETIME, STATUS, TYPE : String?
    var ORGANIZING_DEPT : String?
    var QuestionList : [QuestionListData]?
           

init(_ data : [String : Any]) {
    
    
    if let QUIZNO = data["QUIZNO"] as? Int {
        self.QUIZNO = QUIZNO
    }
   
    if let TOTAL_QUESTION = data["TOTAL_QUESTION"] as? Int {
        self.TOTAL_QUESTION = TOTAL_QUESTION
    }
    if let TOTAL_TIME_IN_MIN = data["TOTAL_TIME_IN_MIN"] as? Int {
        self.TOTAL_TIME_IN_MIN = TOTAL_TIME_IN_MIN
    }
    
    if let TOTAL_QUES_INONE_SCREEN = data["TOTAL_QUES_INONE_SCREEN"] as? Int {
        self.TOTAL_QUES_INONE_SCREEN = TOTAL_QUES_INONE_SCREEN
    }
    if let COMPANY_CODE = data["COMPANY_CODE"] as? Int {
        self.COMPANY_CODE = COMPANY_CODE
    }
   
    
    if let ORGANIZING_DEPT = data["ORGANIZING_DEPT"] as? String {
        self.ORGANIZING_DEPT = ORGANIZING_DEPT
    }
    if let TITLE = data["TITLE"] as? String {
        self.TITLE = TITLE
    }
    if let START_DATETIME = data["START_DATETIME"] as? String {
        self.START_DATETIME = START_DATETIME
    }
    if let END_DATETIME = data["END_DATETIME"] as? String {
        self.END_DATETIME = END_DATETIME
    }
    if let STATUS = data["STATUS"] as? String {
        self.STATUS = STATUS
    }
    if let TYPE = data["TYPE"] as? String {
        self.TYPE = TYPE
    }
    
    if let QuestionList = data["QuestionList"] as? [[String: Any]]{
        var val = [QuestionListData]()
        for item in QuestionList {
            let obj = QuestionListData.init(item)
            val.append(obj)
        }
        self.QuestionList = val
    }
    
  }
}


struct QuestionListData {
    var QID, QUIZNO : Int?
    var QUESTIONS, QUESTION_OPTION_TYPE : String?
    var OptionList : [OptionListData]?
    var SelectedOption : Int = -1
    
    
    init(_ data : [String : Any]) {
        
        if let QID = data["QID"] as? Int {
            self.QID = QID
        }
        if let QUIZNO = data["QUIZNO"] as? Int {
            self.QUIZNO = QUIZNO
        }
        
        if let QUESTIONS = data["QUESTIONS"] as? String {
            self.QUESTIONS = QUESTIONS
        }
        if let QUESTION_OPTION_TYPE = data["QUESTION_OPTION_TYPE"] as? String {
            self.QUESTION_OPTION_TYPE = QUESTION_OPTION_TYPE
        }
        
        if let OptionList = data["OptionList"] as? [[String: Any]]{
            var val = [OptionListData]()
            for item in OptionList {
                let obj = OptionListData.init(item)
                val.append(obj)
            }
            self.OptionList = val
        }
        
    }
        
}

struct OptionListData {
    var QID, OPTION_ID, QUIZNO : Int?
    var OPTION_TEXT : String?
    
    
    init(_ data : [String : Any]) {
        
        if let QID = data["QID"] as? Int {
            self.QID = QID
        }
        if let QUIZNO = data["QUIZNO"] as? Int {
            self.QUIZNO = QUIZNO
        }
        
        if let OPTION_ID = data["OPTION_ID"] as? Int {
            self.OPTION_ID = OPTION_ID
        }
        if let OPTION_TEXT = data["OPTION_TEXT"] as? String {
            self.OPTION_TEXT = OPTION_TEXT
        }
        
    }
}

