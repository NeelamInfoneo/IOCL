//
//  OnboardingModel.swift
//  Furpics
//
//  Created by Codenicely  on 26/03/23.
//

import Foundation

struct OnbordingModelData {
    var ID : Int?
    var FILEURL, DESCRIPTION, ISACTIVE, FROMDATE ,TODATE : String?

init(_ data : [String : Any]) {
    
    if let ID = data["ID"] as? Int {
        self.ID = ID
    }
    if let FILEURL = data["FILEURL"] as? String {
        self.FILEURL = FILEURL
    }
    if let DESCRIPTION = data["DESCRIPTION"] as? String {
        self.DESCRIPTION = DESCRIPTION
    }
    if let ISACTIVE = data["ISACTIVE"] as? String {
        self.ISACTIVE = ISACTIVE
    }
    if let TODATE = data["TODATE"] as? String {
        self.TODATE = TODATE
    }
  }
}

