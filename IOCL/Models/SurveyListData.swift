//
//  SurveyListData.swift
//  IOCL
//
//  Created by infoneo on 19/04/23.
//

import Foundation

struct SurveyListData {
 
    
    var SURVEY_ID, TOPIC_ID, CAT_ID, COMPANY_CODE : Int?
    var SURVEY_DESC, TOPIC_DESC, CAT_DESC, CAT_DESC_HINDI : String?
    
    var listQuestions : [SurveyQuestionListData]?
           

init(_ data : [String : Any]) {
    
    
    if let SURVEY_ID = data["SURVEY_ID"] as? Int {
        self.SURVEY_ID = SURVEY_ID
    }
   
    if let TOPIC_ID = data["TOPIC_ID"] as? Int {
        self.TOPIC_ID = TOPIC_ID
    }
    if let CAT_ID = data["CAT_ID"] as? Int {
        self.CAT_ID = CAT_ID
    }
    
    if let COMPANY_CODE = data["COMPANY_CODE"] as? Int {
        self.COMPANY_CODE = COMPANY_CODE
    }
   
    
    if let SURVEY_DESC = data["SURVEY_DESC"] as? String {
        self.SURVEY_DESC = SURVEY_DESC
    }
    if let TOPIC_DESC = data["TOPIC_DESC"] as? String {
        self.TOPIC_DESC = TOPIC_DESC
    }
    if let CAT_DESC = data["CAT_DESC"] as? String {
        self.CAT_DESC = CAT_DESC
    }
    if let CAT_DESC_HINDI = data["CAT_DESC_HINDI"] as? String {
        self.CAT_DESC_HINDI = CAT_DESC_HINDI
    }
   
    
    if let listQuestions = data["listQuestions"] as? [[String: Any]]{
        var val = [SurveyQuestionListData]()
        for item in listQuestions {
            let obj = SurveyQuestionListData.init(item)
            val.append(obj)
        }
        self.listQuestions = val
    }
    
  }
}


struct SurveyQuestionListData {
    var TOPIC_ID, QUES_ID, SURVEY_ID, OPTIONS_COUNT, CAT_ID : Int?
    var QUES, ANS : String?
    var SelectedOption : String = "-1"
    var showRemark : Bool = false
    var Remark : String = ""
    var OptionList : [SurveyOptionListData]?
   
   
    
    
    init(_ data : [String : Any]) {
        
        if let TOPIC_ID = data["TOPIC_ID"] as? Int {
            self.TOPIC_ID = TOPIC_ID
        }
        if let QUES_ID = data["QUES_ID"] as? Int {
            self.QUES_ID = QUES_ID
        }
        
        if let SURVEY_ID = data["SURVEY_ID"] as? Int {
            self.SURVEY_ID = SURVEY_ID
        }
       
        if let OPTIONS_COUNT = data["OPTIONS_COUNT"] as? Int {
            self.OPTIONS_COUNT = OPTIONS_COUNT
        }
        if let CAT_ID = data["CAT_ID"] as? Int {
            self.CAT_ID = CAT_ID
        }
        if let QUES = data["QUES"] as? String {
            self.QUES = QUES
        }
        if let ANS = data["ANS"] as? String {
            self.ANS = ANS
        }
        
        if let OptionList = data["OptionList"] as? [[String: Any]]{
            var val = [SurveyOptionListData]()
            for item in OptionList {
                let obj = SurveyOptionListData.init(item)
                val.append(obj)
            }
            self.OptionList = val
        }
        
    }
        
}

struct SurveyOptionListData {
    var QUES_ID, Survey_Id : Int?
    var Option : String?
    
    
    init(_ data : [String : Any]) {
        
        if let QUES_ID = data["QUES_ID"] as? Int {
            self.QUES_ID = QUES_ID
        }
        if let Survey_Id = data["Survey_Id"] as? Int {
            self.Survey_Id = Survey_Id
        }
      
        if let Option = data["Option"] as? String {
            self.Option = Option
        }
        
    }
}

