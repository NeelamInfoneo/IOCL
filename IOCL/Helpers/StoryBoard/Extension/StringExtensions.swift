//
//  StringExtensions.swift
//  Wheelz
//
//

import Foundation
import UIKit

extension String {
    
    func toBase64() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    func fromBase64() -> String? {
        guard let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    
    func trimWhiteSpace () -> String {
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        return trimmedString
    }
    
    func isValidMobileNumber() -> Bool {
        let mobileNoRegEx = "^((\\+)|(00)|(\\*)|())[0-9]{9,14}((\\#)|())$"
        let mobileNoTest = NSPredicate(format:"SELF MATCHES %@", mobileNoRegEx)
        return mobileNoTest.evaluate(with: self)
    }
    
    func isValidUserName() -> Bool {
        let nameRegEx = "^[a-zA-Z0-9\\s]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }

    func isValidPassword() -> Bool {
        let passwordRegEx = "^[A-Za-z0-9]+(?=.*?)(?=.*?[#?!@$%^&*-]).{8,16}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }

    func isEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        print(emailTest.evaluate(with: self))
        return emailTest.evaluate(with: self)
    }
    
    func containsAlphaNumericOnly() -> Bool {
        let nameRegEx = "^[a-zA-Z0-9\\s]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    func containsNumberOnly() -> Bool {
        let nameRegEx = "^[0-9]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    func containsAlphabetsOnly() -> Bool {
        let nameRegEx = "^[a-zA-Z]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        
        let nameRegEx = "^[a-zA-Z\\s]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    var length: Int {
        return self.count
    }
    
    func dateFromString(_ format:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("Unable to format date")
        }
        
        return nil
    }
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func removeSpecialCharacter(spclChar : String) -> String {
        return self.replacingOccurrences(of: spclChar, with: " ", options: [.regularExpression, .caseInsensitive])
    }

    func replaceCharacter(spclChar : String, with : String) -> String {
        return self.replacingOccurrences(of: spclChar, with: with, options: [.regularExpression, .caseInsensitive])
    }

}
extension String {
    var withoutHtmlTags: String {
      return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

extension UIView {

    func round(corners: UIRectCorner, cornerRadius: Double) {

        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
}

extension String {
    
    var trim:String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    var isBlank:Bool {
        return self.trim.isEmpty
    }
    
}
extension String {
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
//    var isValidPassword: Bool {
//        let passwordRegEx = "^.{6,}$"
//        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
//        return passwordTest.evaluate(with: self)
//    }
    
    var isValidMobileNo: Bool {
        let PHONE_REGEX = "^[7-9][0-9]{9}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
    var validateAadharCard : Bool {
              let PHONE_REGEX = "^[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}$"
              let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
              let result = phoneTest.evaluate(with: self)
              return result
          }
    
}

extension UIView {
    
    enum GradientType {
        case horizontal
        case vertical
    }
    
    func addGradient(colors: [CGColor], type: GradientType) {
        let gradeLayer = CAGradientLayer()
        gradeLayer.colors = colors//[UIColor.red.cgColor, UIColor.blue.cgColor]
        switch type {
        case .horizontal:
            gradeLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradeLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .vertical:
            gradeLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradeLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
        gradeLayer.frame = self.bounds
        self.layer.insertSublayer(gradeLayer, at: 0)
    }
    
    func addShadow() {
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 0.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.masksToBounds = false
    }
    
}

extension String {
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from { guard start < self.count else { return "" } }
        
        if let end = to { guard end >= 0 else { return "" } }
        
        if let start = from, let end = to { guard end - start >= 0 else { return "" } }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else { startIndex = self.startIndex }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else { endIndex = self.endIndex }
        
        return String(self[startIndex ..< endIndex])
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else { return "" }
        
        let end: Int
        if let start = from, start > 0 { end = start + length - 1 } else { end = length - 1 }
        
        return self.substring(from: from, to: end)
    }
    
}
extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}

extension String{
    var htmlStripped : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

extension Dictionary {
    var jsonStringRepresentaiton: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }
        return String(data: theJSONData, encoding: .ascii)
    }
}
