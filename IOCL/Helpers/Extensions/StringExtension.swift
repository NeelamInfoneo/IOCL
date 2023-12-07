//
//  StringExtension.swift
//  IOCL
//
//  Created by InfoneoMacMini on 23/01/23.
//

import Foundation
import UIKit

extension String {
func convertToDateFormate(current: String, convertTo: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = current
    guard let date = dateFormatter.date(from: self) else {
        return self
    }
    dateFormatter.dateFormat = convertTo
    return  dateFormatter.string(from: date)
}
}
class UILabelPadding: UILabel {

    let padding = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }



}
