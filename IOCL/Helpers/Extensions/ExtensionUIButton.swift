//
//  ExtensionUiButton.swift
//  Betcha
//
//  Created by Gaurav_kumar on 07/06/21.
//

import Foundation
import Foundation
import UIKit

// BUTTON TITTLES
extension UIButton {
    
    func setNormalTitle(normalTitle:String?) {
        self.setTitle(normalTitle, for: .normal)
    }
    
    func setSelectedTitle(selectedTitle:String?) {
        self.setTitle(selectedTitle, for: .selected)
    }
    
    func setHighLightedTitle(highLightedTitle:String?) {
        self.setTitle(highLightedTitle, for: .highlighted)
    }
    
    func setTitles(normalTitle:String? , selectedTitle:String? , highLightedTitle:String?) {
        self.setNormalTitle(normalTitle: normalTitle)
        self.setSelectedTitle(selectedTitle: selectedTitle)
        self.setHighLightedTitle(highLightedTitle: highLightedTitle)
    }
    
    func setTitles(normalTitle:String? , selectedTitle:String?) {
        self.setNormalTitle(normalTitle: normalTitle)
        self.setSelectedTitle(selectedTitle: selectedTitle)
    }
}

//BUTTON IMAGE
extension UIButton{
    
    func setNormalImage(normalImgName:String) {
        self.setImage(UIImage(named: normalImgName), for: .normal)
    }
    
    func setSelectedImage(selectedImgName:String) {
        self.setImage(UIImage(named: selectedImgName), for: .selected)
    }
    
    func setHighLightedImage(highLightedImgName:String) {
        self.setImage(UIImage(named: highLightedImgName), for: .highlighted)
    }
    
    func setImages(normalImgName:String , selectedImgName:String , highLightedImgName:String) {
        
        self.setNormalImage(normalImgName: normalImgName)
        self.setSelectedImage(selectedImgName: selectedImgName)
        self.setHighLightedImage(highLightedImgName: highLightedImgName)
    }
    
    func setImages(normalImgName:String , selectedImgName:String) {
        self.setNormalImage(normalImgName: normalImgName)
        self.setSelectedImage(selectedImgName: selectedImgName)
    }
}

//BUTTON TITLE COLOR
extension UIButton {
    
    func setNormalTitleColor(color:UIColor?) {
        self.setTitleColor(color, for: .normal)
    }
    
    func setSelectedTitleColor(color:UIColor?) {
        self.setTitleColor(color, for: .selected)
    }
    
    func setHighLightedTitleColor(color:UIColor?) {
        self.setTitleColor(color, for: .highlighted)
    }
    
    func setTitleColors(normalColor:UIColor? , selectedColor:UIColor? , highLightedColor:UIColor?) {
        
        self.setNormalTitleColor(color: normalColor)
        self.setSelectedTitleColor(color: selectedColor)
        self.setHighLightedTitleColor(color: highLightedColor)
    }
    
    func setTitleColors(normalColor:UIColor? , selectedColor:UIColor?) {
        self.setNormalTitleColor(color: normalColor)
        self.setSelectedTitleColor(color: selectedColor)
    }
}

extension UIButton {
    
    public func setAppFontColor(_ txtColor:  UIColor, font: UIFont) {
        self.setTitleColor(txtColor, for: .normal)
        self.titleLabel?.font = font
    }
}

extension UIButton {
    
    func underlineBtn() {
        guard let text = self.currentTitle else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UIButton {
    func addDashedBorder(_ color: UIColor, withWidth width: CGFloat, cornerRadius: CGFloat, dashPattern: [NSNumber] = [3,6]) {
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width-10
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    
}
