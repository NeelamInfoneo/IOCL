//
//  Extension+UIInt.swift
//  Betcha
//
//  Created by Gaurav_kumar on 16/06/21.
//

import Foundation
import UIKit

///extension for seconds to time and return sting
extension Int {
    func secondsToTime() -> String {
        let s = (self % 3600) % 60
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        return " \(s_string) "
    }
}
// MARK: - Extension of Int For Converting it TO String.
extension Int {
    /// A Computed Property (only getter) of String For getting the String value from Int.
    var toString:String {
        return "\(self)"
    }
    var toDouble:Double {
        return Double(self)
    }
}
extension Double {
    var toInt:Int? {
        return Int(self)
    }
    var toFloat:Float? {
        return Float(self)
    }
    var toString:String {
        return "\(self)"
    }
    func rounded(toPlaces places:Int) -> String {
        //Use like this:
        //1.403843.rounded(toPlaces: 2) >> "1.40"
        let divisor = pow(10.0, Double(places))
        var returnValue = "\((self * divisor).rounded() / divisor)"
        if(returnValue.split(separator: ".")[1].count == 1 && places > 1) {
            returnValue += "0"
        }
        return returnValue
    }
}
