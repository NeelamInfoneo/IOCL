//
//  CustomTabbar.swift
//  IOCL
//
//  Created by infoneo on 20/12/22.
//

import UIKit


class CustomTabbar: UITabBar {
    
    private var shapeLayer: CALayer?
    private var gradientlayer: CAGradientLayer?
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.fillColor = UIColor.appColor(.themeColor).cgColor
        // uncomment below if wants to add a line
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.5
        
        //The below 4 lines are for shadow above the bar. you can skip them if you do not want a shadow
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 20
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.5
        
        
        let gradientlayer = CAGradientLayer()
            gradientlayer.frame = bounds
        gradientlayer.colors = [UIColor.appColor(.themeColor).cgColor, UIColor.appColor(.themeColor).cgColor]
            gradientlayer.locations = [0, 1]

        
        
        if let oldGradientLayer = self.gradientlayer {
            self.layer.replaceSublayer(oldGradientLayer, with: gradientlayer)
        } else {
            self.layer.insertSublayer(gradientlayer, at: 0)
        }
        

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.gradientlayer = gradientlayer
        self.shapeLayer = shapeLayer
    }
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    
    func createPath() -> CGPath {
        let height: CGFloat = 25.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - height * 4), y: 0))

        path.addCurve(to: CGPoint(x: centerWidth, y: -height),
        controlPoint1: CGPoint(x: (centerWidth - 60), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: -height))

        path.addCurve(to: CGPoint(x: (centerWidth + height * 4), y: 0),
        controlPoint1: CGPoint(x: centerWidth + 35, y: -height), controlPoint2: CGPoint(x: (centerWidth + 60), y: 0))

        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
            for member in subviews.reversed() {
                let subPoint = member.convert(point, from: self)
                guard let result = member.hitTest(subPoint, with: event) else { continue }
                return result
            }
            return nil
        }
}
