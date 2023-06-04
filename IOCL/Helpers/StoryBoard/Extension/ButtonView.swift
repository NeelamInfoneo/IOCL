//
//  ButtonView.swift
//  Meet&Bond
//
//  Created by OS on 01/08/21.
//

import Foundation
import UIKit

class ButtonGradient : UIButton {
      override func layoutSubviews() {

          let layer : CAGradientLayer = CAGradientLayer()
          layer.frame.size = self.frame.size
          layer.frame.origin = CGPoint(x: 0, y: 0)

          //   layer.cornerRadius = CGFloat(frame.width / 20)
          let color0 = UIColor(red:174/255, green:57/255, blue:162/255, alpha:1.0).cgColor
          let color1 = UIColor(red:245/255, green:48/255, blue: 118/255, alpha:1.0).cgColor
//          let color2 = UIColor(red:250/255, green:98/255, blue: 44/255, alpha:1.0).cgColor
          layer.locations = [0.5, 1.0]
        layer.startPoint = CGPoint(x: 0.0, y: 0.9)
          layer.endPoint = CGPoint(x: 0.8, y: 0.6)
          layer.colors = [color0,color1]
        layer.cornerRadius = 10
        
               

          self.layer.insertSublayer(layer, at: 0)
      }
  }

class GradientLabel: UILabel {
    
    // MARK: - Colors to create gradient from
    @IBInspectable open var gradientFrom: UIColor?
    @IBInspectable open var gradientTo: UIColor?
    
    override func draw(_ rect: CGRect) {
        // begin new image context to let the superclass draw the text in (so we can use it as a mask)
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        do {
            // get your image context
            guard let ctx = UIGraphicsGetCurrentContext() else { super.draw(rect); return }
            // flip context
            ctx.scaleBy(x: 1, y: -1)
            ctx.translateBy(x: 0, y: -bounds.size.height)
            // get the superclass to draw text
            super.draw(rect)
        }
        // get image and end context
        guard let img = UIGraphicsGetImageFromCurrentImageContext(), img.cgImage != nil else { return }
        UIGraphicsEndImageContext()
        // get drawRect context
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        // clip context to image
        ctx.clip(to: bounds, mask: img.cgImage!)
        // define your colors and locations
        let color0 = UIColor(red:174/255, green:57/255, blue:162/255, alpha:1.0).cgColor
        let color1 = UIColor(red:245/255, green:48/255, blue: 118/255, alpha:1.0).cgColor
        let colors: [CGColor] = [color0,color1,color0,color1]
        let locs: [CGFloat] = [0.0, 0.3, 0.6, 1.0]
        // create your gradient
        guard let grad = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locs) else { return }
        // draw gradient
        ctx.drawLinearGradient(grad, start: CGPoint(x: 0, y: bounds.size.height*0.5), end: CGPoint(x:bounds.size.width, y: bounds.size.height*0.5), options: CGGradientDrawingOptions(rawValue: 0))
    }
}
class ViewGradient : UIView {
      override func layoutSubviews() {

          let layer : CAGradientLayer = CAGradientLayer()
          layer.frame.size = self.frame.size
          layer.frame.origin = CGPoint(x: 0, y: 0)

          //   layer.cornerRadius = CGFloat(frame.width / 20)
          let color0 = UIColor(red:174/255, green:57/255, blue:162/255, alpha:1.0).cgColor
          let color1 = UIColor(red:245/255, green:48/255, blue: 118/255, alpha:1.0).cgColor
//          let color2 = UIColor(red:250/255, green:98/255, blue: 44/255, alpha:1.0).cgColor
          layer.locations = [0.5, 1.0]
        layer.startPoint = CGPoint(x: 0.0, y: 0.9)
          layer.endPoint = CGPoint(x: 0.8, y: 0.6)
          layer.colors = [color0,color1]
     //   layer.cornerRadius = 10
        
          self.layer.insertSublayer(layer, at: 0)
      }
  }
class TwoGradientLabel: UILabel {
    
    // MARK: - Colors to create gradient from
    @IBInspectable open var gradientFrom: UIColor?
    @IBInspectable open var gradientTo: UIColor?
    
    override func draw(_ rect: CGRect) {
        // begin new image context to let the superclass draw the text in (so we can use it as a mask)
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        do {
            // get your image context
            guard let ctx = UIGraphicsGetCurrentContext() else { super.draw(rect); return }
            // flip context
            ctx.scaleBy(x: 1, y: -1)
            ctx.translateBy(x: 0, y: -bounds.size.height)
            // get the superclass to draw text
            super.draw(rect)
        }
        // get image and end context
        guard let img = UIGraphicsGetImageFromCurrentImageContext(), img.cgImage != nil else { return }
        UIGraphicsEndImageContext()
        // get drawRect context
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        // clip context to image
        ctx.clip(to: bounds, mask: img.cgImage!)
        // define your colors and locations
        let color0 = UIColor(red:174/255, green:57/255, blue:162/255, alpha:1.0).cgColor
        let color1 = UIColor(red:245/255, green:48/255, blue: 118/255, alpha:1.0).cgColor
        let colors: [CGColor] = [color1,color0]
        let locs: [CGFloat] = [0.0, 0.3, 0.6, 1.0]
        // create your gradient
        guard let grad = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locs) else { return }
        // draw gradient
        ctx.drawLinearGradient(grad, start: CGPoint(x: 0, y: bounds.size.height*0.5), end: CGPoint(x:bounds.size.width, y: bounds.size.height*0.5), options: CGGradientDrawingOptions(rawValue: 0))
    }
}
class RoundedButtonWithShadow: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
    }
}
class ViewWithRoundedcornersAndShadow: UIView {
    private var theShadowLayer: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()

        if self.theShadowLayer == nil {
            let rounding = CGFloat.init(22.0)

            let shadowLayer = CAShapeLayer.init()
            self.theShadowLayer = shadowLayer
            shadowLayer.path = UIBezierPath.init(roundedRect: bounds, cornerRadius: rounding).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor

            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowRadius = CGFloat.init(3.0)
            shadowLayer.shadowOpacity = Float.init(0.2)
            shadowLayer.shadowOffset = CGSize.init(width: 0.0, height: 4.0)

            self.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
@available(iOS 13.0, *)
class ButtonWithShadow: UIButton {

    override func draw(_ rect: CGRect) {
        updateLayerProperties()
    }

    func updateLayerProperties() {
        self.layer.shadowColor = UIColor(red: 243/255.0, green:
                                            236.0/255.0, blue: 250.0/255.0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 11.0
        self.layer.cornerRadius = 30
        self.layer.borderColor = CGColor(red: 243/255.0, green:
                                            236.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        self.layer.masksToBounds = false
    }

}

extension UIView {

    func addShadowValue(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float, bordercolor: UIColor) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.borderColor = bordercolor.cgColor
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
        
    }
}
class ShadowView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // corner radius
        self.layer.cornerRadius = 11

        // border
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.purple.cgColor

        // shadow
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }

}
