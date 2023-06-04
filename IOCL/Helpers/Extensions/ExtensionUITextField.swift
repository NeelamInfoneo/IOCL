//
//  ExtensionUITextField.swift
//  Betcha
//
//  Created by Gaurav_kumar on 07/06/21.
//

import Foundation
import UIKit

//TEXT FIELD MARGIN
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    // TEXT FIELF ICONS
    func setRightViewIcon(icon: UIImage) {
        let btnView = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btnView.backgroundColor = .blue
        btnView.setImage(icon, for: .normal)
        btnView.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        self.rightViewMode = .always
        self.rightView = btnView
    }
    
    public func setAppFontColor(_ color:  UIColor, font: UIFont) {
        self.textColor = color
        self.font = font
    }
    public func setAttibuttedString(font: UIFont, font2: UIFont, color : UIColor, Color2: UIColor, str1 : String, str2: String) -> NSMutableAttributedString {
        let attrs1 = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor :color]
        let attrs2 = [NSAttributedString.Key.font : font2, NSAttributedString.Key.foregroundColor : Color2]
        let attStr1 = NSMutableAttributedString(string:"\(str1)", attributes:attrs1 as [NSAttributedString.Key : Any])
        let attStr2 = NSMutableAttributedString(string:"\(str2)", attributes:attrs2 as [NSAttributedString.Key : Any])
        attStr1.append(attStr2)
        return attStr1
    }
}

