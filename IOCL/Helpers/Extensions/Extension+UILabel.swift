//
//  Extension+UILabel.swift
//  Betcha
//
//  Created by admin on 30/03/21.
//

import Foundation
import UIKit

extension UILabel {
    
    public func setAppFontColor(_ color:  UIColor, font: UIFont) {
        self.textColor = color//UIColor.appColor(.almostBlack)
        self.font = font//UIFont.ProductSans(.medium, size: 17)
    }
    
    //MARK: - LINE SPACING IN LABEL TEXT -
    func setLineSpacing(lineSpacing: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}

//calculate maximum number of lines
extension UILabel {
    func calculateMaxLines(actualWidth: CGFloat?) -> Int {
        var width = frame.size.width
        if let actualWidth = actualWidth {
            width = actualWidth
        }
        let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font as Any], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    
   
}


