//
//  ExtensionUIColor.swift
//  Betcha
//
//  Created by Gaurav_kumar on 14/06/21.
//

import Foundation
import UIKit

enum AssetsColor: String {
    case white //FFFFFF
    case black //000000
    case grayText //6A6A6A
    case themeLight //F37022
    case themeColor //CE4D00
    case grayBorder //CDCDCD
    case darkPurple //#02164F
    case appOrange //#F37022
    case grayLightText //#828282
    case appTextColor //#252525
    case appDarkRed //#B90B00
    case appRed //#EF0000
    case textGray //#696969
    case appGreen //#00A811
    case appLightBlack //#353535
    case appLightRed //#F60000
    case grayLight //#AAAAAA
    case qbNormalBorderGray //#3644461A
    case qbBlack //#4D565D
    case highlySatisfy //478728
    case satisfy //B3F48F
    case needImprovement //FFFD54
    case disatisfy//F6BD4F
    case highlyDisatify // EE6B60
  
}

extension UIColor {
    
    static func appColor(_ name: AssetsColor, alpha: CGFloat = 1.0) -> UIColor {
        
        switch name {
        case .white:
            return UIColor(rgb: 0xFFFFFF).withAlphaComponent(alpha)
        case .black:
            return UIColor(rgb: 0x000000).withAlphaComponent(alpha)
        case .grayText:
            return UIColor(rgb: 0x6A6A6A).withAlphaComponent(alpha)
        case .themeLight:
            return UIColor(rgb: 0xF37022).withAlphaComponent(alpha)
        case .themeColor:
            return UIColor(rgb: 0x02103F).withAlphaComponent(alpha)
        case .grayBorder:
            return UIColor(rgb: 0xCDCDCD).withAlphaComponent(alpha)
        case .darkPurple:
            return UIColor(rgb: 0x02164F).withAlphaComponent(alpha)
        case .appOrange:
            return UIColor(rgb: 0xF37022).withAlphaComponent(alpha)
        case .grayLightText:
            return UIColor(rgb: 0x828282).withAlphaComponent(alpha)
        case .appTextColor:
            return UIColor(rgb: 0x252525).withAlphaComponent(alpha)
        case .appDarkRed:
            return UIColor(rgb: 0xB90B00).withAlphaComponent(alpha)
        case .appRed:
            return UIColor(rgb: 0xEF0000).withAlphaComponent(alpha)
        case .textGray:
            return UIColor(rgb: 0x696969).withAlphaComponent(alpha)
        case .appGreen:
            return UIColor(rgb: 0x00A811).withAlphaComponent(alpha)
        case .appLightBlack:
            return UIColor(rgb: 0x353535).withAlphaComponent(alpha)
        case .appLightRed:
            return UIColor(rgb: 0xF60000).withAlphaComponent(alpha)
        case .grayLight:
            return UIColor(rgb: 0xAAAAAA).withAlphaComponent(alpha)
        case .qbNormalBorderGray  :
            return UIColor(rgb: 0x3644461A).withAlphaComponent(alpha)
        case .qbBlack:
            return UIColor(rgb: 0x4D565D).withAlphaComponent(alpha)
            
        case .highlySatisfy: //478728
            return UIColor(rgb: 0x478728).withAlphaComponent(alpha)
        case .satisfy: //B3F48F
            return UIColor(rgb: 0xB3F48F).withAlphaComponent(alpha)
        case .needImprovement: //FFFD54
            return UIColor(rgb: 0xFFFD54).withAlphaComponent(alpha)
        case .disatisfy://F6BD4F
            return UIColor(rgb: 0xF6BD4F).withAlphaComponent(alpha)
        case .highlyDisatify :// EE6B60
            return UIColor(rgb: 0xEE6B60).withAlphaComponent(alpha)
        }
    }
}

//USE
//UIColor.appColor(.lightTeal)

extension UIColor {
    
    //How To use
    //let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
    //let color2 = UIColor(rgb: 0xFFFFFF)
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
