//
//  ExtensionUIView.swift
//  Betcha
//
//  Created by Gaurav_kumar on 07/06/21.
//

import Foundation

import Foundation
import UIKit
import ObjectiveC


// MARK: - Extension of UIView For giving the round shape to any UIView.
extension UIView {
    
    func    setGradientBackground(topR:Double,topG:Double,topB:Double,bottomR:Double,bottomG:Double,bottomB:Double,alphaTop:Double,alphaBottom:Double)
    {
        let colorTop = UIColor(red: CGFloat(topR/255.0), green: CGFloat(topG)/255.0, blue: CGFloat(topB)/255.0, alpha: CGFloat(alphaTop)).cgColor
        let colorBottom = UIColor(red: CGFloat(bottomR)/255.0, green: CGFloat(bottomG)/255.0, blue: CGFloat(bottomB)/255.0, alpha: CGFloat(alphaBottom)).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func roundLowerBothCorner(cornerRadius : Double)
    {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundLower_onboard(cornerRadius : Double)
    {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundLoweroneside(cornerRadius : Double)
    {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    func roundCorners_update(_ corners: UIRectCorner, radius: CGFloat)
    {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    /// This method is used to giving the round shape to any UIView
    func roundView() {
        self.layer.cornerRadius = (self.CViewHeight/2.0)
        self.layer.masksToBounds = true
    }
    func makeRounded() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
    func makeRoundCorner(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func roundCornerBottom(_ radius:CGFloat)
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    func roundCornerUp(_ radius:CGFloat)
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func roundCornerAccross(_ radius:CGFloat)
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [ .layerMinXMaxYCorner,.layerMaxXMinYCorner]
    }
    
    func makeRoundCornerwithborder(_ radius:CGFloat, bordercolor :UIColor, borderwidth : CGFloat)
    {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderwidth
        self.layer.borderColor = bordercolor.cgColor
        self.clipsToBounds = true
    }
    
    func makeRoundCornerwithborder_update(bordercolor :UIColor, borderwidth : CGFloat)
    {
        self.layer.borderWidth = borderwidth
        self.layer.borderColor = bordercolor.cgColor
        self.clipsToBounds = true
    }
    
    func dropShadow(shadowColor: UIColor = UIColor.lightGray, borderColor: UIColor = UIColor.white , opacity: Float = 0.3, offSet: CGSize = CGSize(width: 0, height: 0), radius: CGFloat = 5, scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func dropShadowCustom(shadowColor: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), borderColor: UIColor = UIColor.white , opacity: Float = 0.4, offSet: CGSize = CGSize(width: 0, height: 0), radius: CGFloat = 6, scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        //    self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadowCustomlistit(shadowColor: UIColor = #colorLiteral(red: 0.2980392157, green: 0.6666666667, blue: 0.3137254902, alpha: 1), borderColor: UIColor = UIColor.white , opacity: Float = 0.5, offSet: CGSize = CGSize(width: 0, height: 0), radius: CGFloat = 3, scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        //    self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadowCustommain(shadowColor: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), borderColor: UIColor = UIColor.white , opacity: Float = 0.3, offSet: CGSize = CGSize(width: 0, height: 0), radius: CGFloat = 3, scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        //    self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    func roundCornerRadius(cornerRadius: Double)
    {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner]
    }
    
}


//extension UIView{
//
//    func circleProfileView(borderWidth: CGFloat,borderColor: UIColor){
//        self.layer.cornerRadius = (self.frame.size.width) / 2
//        self.clipsToBounds = true
//        self.layer.borderWidth = borderWidth
//        self.layer.borderColor = borderColor.cgColor
//    }
//
//    func dropShadowsInBottomBlue(shadowColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), borderColor: UIColor = UIColor.white , opacity: Float = 0.5, offSet:
//                                 CGSize = CGSize(width: 0, height: 8), radius: CGFloat = 5, scale: Bool = true) {
//        self.layer.masksToBounds = false
//        self.layer.borderColor = borderColor.cgColor
//        self.layer.shadowColor = shadowColor.cgColor
//        self.layer.shadowOpacity = opacity
//        self.layer.shadowOffset = offSet
//        self.layer.shadowRadius = radius
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//
//
//
//    static var nib: UINib {
//        return UINib(nibName: String(describing: self), bundle: nil)
//    }
//
//    static func instantiate(autolayout: Bool = true) -> Self {
//        func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
//            let view = self.nib.instantiate() as! T
//            view.translatesAutoresizingMaskIntoConstraints = !autolayout
//            return view
//        }
//        return instantiateUsingNib(autolayout: autolayout)
//    }
//
//    func roundUpperBothCorner(cornerRadius : Double){
//        self.layer.cornerRadius = CGFloat(cornerRadius)
//        self.clipsToBounds = true
//        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//    }
//
//    func roundParticularCorners(cornerRadius: Double)
//    {
//        self.layer.cornerRadius = CGFloat(cornerRadius)
//        self.clipsToBounds = true
//        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//    }
//
//    func roundCornerRadius(cornerRadius: Double)
//    {
//        self.layer.cornerRadius = CGFloat(cornerRadius)
//        self.clipsToBounds = true
//        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner]
//    }
//
//
//    func makeRounded() {
//        self.layer.cornerRadius = self.frame.size.width/2
//        self.clipsToBounds = true
//    }
//
//    func makeRoundCorner(_ radius:CGFloat) {
//        self.layer.cornerRadius = radius
//        self.clipsToBounds = true
//    }
//
//    func roundCornerBottom(_ radius:CGFloat)
//    {
//        self.clipsToBounds = true
//        self.layer.cornerRadius = radius
//        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//    }
//    func roundCornerUp(_ radius:CGFloat)
//    {
//        self.clipsToBounds = true
//        self.layer.cornerRadius = radius
//        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//    }
//
//    func makeRoundCornerwithborder(_ radius:CGFloat, bordercolor :UIColor, borderwidth : CGFloat)
//    {
//        self.layer.cornerRadius = radius
//        self.layer.borderWidth = borderwidth
//        self.layer.borderColor = bordercolor.cgColor
//        self.clipsToBounds = true
//    }
//
//
//
//    func dropShadow(shadowColor: UIColor = UIColor.lightGray, borderColor: UIColor = UIColor.white , opacity: Float = 0.5, offSet:
//                    CGSize = CGSize(width: 0, height: 0), radius: CGFloat = 5, scale: Bool = true) {
//        self.layer.masksToBounds = false
//        self.layer.borderColor = borderColor.cgColor
//        self.layer.shadowColor = shadowColor.cgColor
//        self.layer.shadowOpacity = opacity
//        self.layer.shadowOffset = offSet
//        self.layer.shadowRadius = radius
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//
//    func dropFieldShadow(){
//        //Basic texfield Setup
//        self.backgroundColor = UIColor.white
//        //To apply Shadow
//        self.layer.shadowOpacity = 0.05
//        self.layer.shadowRadius = 1.0
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0) // Use any CGSize
//        self.layer.shadowColor = UIColor(hexString: "#000000")?.cgColor
//    }
//
//    func dropShadowblue() {
//        self.layer.shadowColor = UIColor.blue.cgColor
//        self.layer.shadowOpacity = 0.1
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.layer.shadowRadius = 10
//    }
//
//    func randomPoint(forView : UIView) -> CGPoint {
//
//        return CGPoint(x:178.0, y:52.0)
//    }
//
//    func delay(interval: TimeInterval, closure: @escaping () -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
//            closure()
//        }
//    }
//
//
//    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
//        clipsToBounds = true
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
//        gradientLayer.frame = self.bounds
//        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
//        print(gradientLayer.frame)
//        self.layer.insertSublayer(gradientLayer, at: 0)
//    }
//    func applyGradient(colorOne: UIColor, ColorTwo: UIColor) {
//        let gradient = CAGradientLayer()
//        gradient.frame = bounds
//        gradient.colors = [colorOne.cgColor, ColorTwo.cgColor]
//        gradient.locations = [0.0, 1.0]
//        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
//        layer.insertSublayer(gradient, at: 0)
//    }
//
//
//
//    func getFrameInView(containerViewFrame : CGRect, index : Int, totalcount : Int) -> CGRect{
//
//        if totalcount == 1{
//            return CGRect(x:  10, y: 10, width: (containerViewFrame.size.width) - 10, height: (containerViewFrame.size.height) - 10)
//        }else if totalcount == 2{
//            switch index {
//            case 0:
//                return CGRect(x:  10, y:10, width: (containerViewFrame.size.width/2 ) - 20, height: (containerViewFrame.size.height) - 20)
//
//            case 1:
//                return CGRect(x: (containerViewFrame.size.width/2 ) + 10, y: 10, width: (containerViewFrame.size.width/2 ) - 20, height: (containerViewFrame.size.height ) - 20)
//            default:
//                return containerViewFrame
//            }
//        }else if totalcount == 3{
//            switch index {
//            case 0:
//                return CGRect(x:  10, y:10, width: (containerViewFrame.size.width/2 ) - 20, height: (containerViewFrame.size.height) - 20)
//
//            case 1:
//                return CGRect(x: (containerViewFrame.size.width/2 ) + 10, y: 10, width: (containerViewFrame.size.width/2 ) - 20, height: (containerViewFrame.size.height/2 ) - 20)
//            case 2:
//                return CGRect(x: (containerViewFrame.size.width/2 ) + 10, y: (containerViewFrame.size.height/2 ) + 10, width: (containerViewFrame.size.width/2 ) - 20, height: (containerViewFrame.size.height/2 ) - 20)
//
//            default:
//                return containerViewFrame
//            }
//        }else if totalcount == 4{
//            switch index {
//            case 0:
//                return CGRect(x:  10, y:10, width: (containerViewFrame.size.width/2 ) - 20, height: (containerViewFrame.size.height/2 ) - 20)
//
//            case 1:
//                return CGRect(x: (containerViewFrame.size.width/2 ) + 10, y: 10, width: (containerViewFrame.size.width/2 ) - 20, height: (containerViewFrame.size.height/2 ) - 20)
//            case 2:
//                return CGRect(x:  10, y: (containerViewFrame.size.height/2 ) + 10, width: (containerViewFrame.size.width/2 ) - 20, height: (containerViewFrame.size.height/2 ) - 20)
//            case 3:
//                return CGRect(x: (containerViewFrame.size.width/2 ) + 10, y: (containerViewFrame.size.height/2 ) + 10, width: (containerViewFrame.size.width/2 ) - 20, height: (containerViewFrame.size.height/2 ) - 20)
//            default:
//                return containerViewFrame
//            }
//        }
//
//        else if totalcount == 5{
//            switch index {
//            case 0:
//                return CGRect(x:  10, y:10, width: (containerViewFrame.size.width) - 20, height: (containerViewFrame.size.height/2 ) - 20)
//
//            case 1:
//                return CGRect(x: 10, y: (containerViewFrame.size.height/2 ) + 10, width: (containerViewFrame.size.width/4 ) - 10, height: (containerViewFrame.size.height/2 ) - 20)
//            case 2:
//                return CGRect(x: (containerViewFrame.size.width/4 ) + 10, y: (containerViewFrame.size.height/2 ) + 10, width: (containerViewFrame.size.width/4 ) - 15, height: (containerViewFrame.size.height/2 ) - 20)
//            case 3:
//                return CGRect(x: ((containerViewFrame.size.width/4 ) * 2) + 10, y: (containerViewFrame.size.height/2 ) + 10, width: (containerViewFrame.size.width/4 ) - 15, height: (containerViewFrame.size.height/2 ) - 20)
//            case 4:
//                return CGRect(x: ((containerViewFrame.size.width/4 ) * 3) + 10, y: (containerViewFrame.size.height/2 ) + 10, width: (containerViewFrame.size.width/4 ) - 20, height: (containerViewFrame.size.height/2 ) - 20)
//
//            default:
//                return containerViewFrame
//            }
//        }
//        return containerViewFrame
//    }
//
//    func dropShadowGreen(shadowColor: UIColor = #colorLiteral(red: 0.1333333333, green: 0.6117647059, blue: 0.6156862974, alpha: 0.3103863442), borderColor: UIColor = UIColor.white , opacity: Float = 0.5, offSet:
//                         CGSize = CGSize(width: 0, height: 8), radius: CGFloat = 5, scale: Bool = true) {
//        self.layer.masksToBounds = false
//        self.layer.borderColor = borderColor.cgColor
//        self.layer.shadowColor = shadowColor.cgColor
//        self.layer.shadowOpacity = opacity
//        self.layer.shadowOffset = offSet
//        self.layer.shadowRadius = radius
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//
//}


// MARK: - Extension of UIView For getting any UIView from XIB.
extension UIView {
    
    /// This static Computed property is used to getting any UIView from XIB. This Computed property returns UIView? , it means this method return nil value also , while using this method please use if let. If you are not using if let and if this method returns nil and when you are trying to unwrapped this value("UIView!") then application will crash.
    //    static var viewFromXib:UIView? {
    //        return self.viewWithNibName(strViewName: "\(self)")
    //    }
    
    /// This static method is used to getting any UIView with specific name.
    ///
    /// - Parameter strViewName: A String Value of UIView.
    /// - Returns: This Method returns UIView? , it means this method return nil value also , while using this method please use if let. If you are not using if let and if this method returns nil and when you are trying to unwrapped this value("UIView!") then application will crash.
    //    static func viewWithNibName(strViewName:String) -> UIView? {
    //
    //        guard let view = CMainBundle.loadNibNamed(strViewName, owner: self, options: nil)?[0] as? UIView else { return nil }
    //
    //        return view
    //    }
    
}

// MARK: - Extension of UIView For removing all the subviews of UIView.
extension UIView {
    
    /// This method is used for removing all the subviews of UIView.
    func removeAllSubviews() {
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    /// This method is used for removing all the subviews from InterfaceBuilder for perticular tag.
    ///
    /// - Parameter tag: Pass the tag value of UIView , and that UIView and its all subviews will remove from InterfaceBuilder.
    func removeAllSubviewsOfTag(tag:Int) {
        
        for subview in self.subviews {
            
            if subview.tag == tag {
                subview.removeFromSuperview()
            }
        }
    }
    
}

// MARK: - Extension of UIView For draw a shadowView of it.
extension UIView {
    
    /// This method is used to draw a shadowView for perticular UIView.
    ///
    /// - Parameters:
    ///   - color: Pass the UIColor that you want to see as shadowColor.
    ///   - shadowOffset: Pass the CGSize value for how much far you want shadowView from parentView.
    ///   - shadowRadius: Pass the CGFloat value for how much length(Blur Spreadness) you want in shadowView.
    func shadow(color:UIColor , shadowOffset:CGSize , shadowRadius:CGFloat) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
        self.layer.shouldRasterize = true
        //        self.layer.rasterizationScale = CMainScreen.scale
    }
}

// MARK: - Extension of UIView For adding the border to UIView at any position.
extension UIView {
    
    /// A Enum UIPosition Describes the Different Postions.
    ///
    /// - top: Will add border at top of The UIView.
    /// - left: Will add border at left of The UIView.
    /// - bottom: Will add border at bottom of The UIView.
    /// - right: Will add border at right of The UIView.
    enum UIPosition {
        case top
        case left
        case bottom
        case right
    }
    
    /// This method is used to add the border to perticular UIView at any position.
    ///
    /// - Parameters:
    ///   - position: Pass the enum value of UIPosition , according to the enum value it will add the border for that position.
    ///   - color: Pass the UIColor which you want to see in a border.
    ///   - width: CGFloat value - (Optional - if you are passing nil then method will automatically set this value same as Parent's width) OR pass how much width you want for border. For top and bottom UIPosition you can pass nil.
    ///   - height: CGFloat value - (Optional - if you are passing nil then method will automatically set this value same as Parent's height) OR pass how much height you want for border. For left and right UIPosition you can pass nil.
    func addBorder(position:UIPosition , color:UIColor , width:CGFloat? , height:CGFloat?) {
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor = color.cgColor
        
        switch position {
            
        case .top:
            
            borderLayer.frame = CGRect(origin: .zero, size: CGSize(width: (width ?? self.CViewWidth), height: (height ?? 0.0)))
            
        case .left:
            
            borderLayer.frame = CGRect(origin: .zero, size: CGSize(width: (width ?? 0.0), height: (height ?? self.CViewHeight)))
            
        case .bottom:
            
            borderLayer.frame = CGRect(origin: CGPoint(x: 0.0, y: (self.CViewHeight - (height ?? 0.0))), size: CGSize(width: (width ?? self.CViewWidth), height: (height ?? 0.0)))
            
        case .right:
            
            borderLayer.frame = CGRect(origin: CGPoint(x: (self.CViewWidth - (width ?? 0.0)), y: 0.0), size: CGSize(width: (width ?? 0.0), height: (height ?? self.CViewHeight)))
            
        }
        
        self.layer.addSublayer(borderLayer)
    }
    
}

typealias tapInsideViewHandler = (() -> ())

extension UIView {
    
    private struct AssociatedObjectKey {
        static var tapInsideViewHandler = "tapInsideViewHandler"
    }
    
    func tapInsideViewHandler(tapInsideViewHandler:@escaping tapInsideViewHandler) {
        
        self.isUserInteractionEnabled = true
        
        if let tapGesture = self.gestureRecognizers?.first(where: {$0.isEqual(UITapGestureRecognizer.self)}) as? UITapGestureRecognizer {
            
            tapGesture.addTarget(self, action: #selector(handleTapGesture(sender:)))
            
        } else {
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:))))
        }
        
        objc_setAssociatedObject(self, &AssociatedObjectKey.tapInsideViewHandler, tapInsideViewHandler, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc private func handleTapGesture(sender:UITapGestureRecognizer) {
        
        if let tapInsideViewHandler = objc_getAssociatedObject(self, &AssociatedObjectKey.tapInsideViewHandler) as? tapInsideViewHandler {
            
            tapInsideViewHandler()
        }
    }
    
}

extension UIView {
    
    var snapshotImage : UIImage? {
        
        var snapShotImage:UIImage?
        
        UIGraphicsBeginImageContext(self.CViewSize)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            self.layer.render(in: context)
            
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                snapShotImage = image
            }
        }
        return snapShotImage
    }
}

extension UIView {
    
    var CViewSize:CGSize {
        return self.frame.size
    }
    
    var CViewOrigin:CGPoint {
        return self.frame.origin
    }
    
    var CViewWidth:CGFloat {
        return self.CViewSize.width
    }
    
    var CViewHeight:CGFloat {
        return self.CViewSize.height
    }
    
    var CViewX:CGFloat {
        return self.CViewOrigin.x
    }
    
    var CViewY:CGFloat {
        return self.CViewOrigin.y
    }
    
    var CViewCenter:CGPoint {
        return CGPoint(x: self.CViewWidth/2.0, y: self.CViewHeight/2.0)
    }
    
    var CViewCenterX:CGFloat {
        return CViewCenter.x
    }
    
    var CViewCenterY:CGFloat {
        return CViewCenter.y
    }
    
}

extension UIView {
    
    func CViewSetSize(width:CGFloat , height:CGFloat) {
        CViewSetWidth(width: width)
        CViewSetHeight(height: height)
    }
    
    func CViewSetOrigin(x:CGFloat , y:CGFloat) {
        CViewSetX(x: x)
        CViewSetY(y: y)
    }
    
    func CViewSetWidth(width:CGFloat) {
        self.frame.size.width = width
    }
    
    func CViewSetHeight(height:CGFloat) {
        self.frame.size.height = height
    }
    
    func CViewSetX(x:CGFloat) {
        self.frame.origin.x = x
    }
    
    func CViewSetY(y:CGFloat) {
        self.frame.origin.y = y
    }
    
    func CViewSetCenter(x:CGFloat , y:CGFloat) {
        CViewSetCenterX(x: x)
        CViewSetCenterY(y: y)
    }
    
    func CViewSetCenterX(x:CGFloat) {
        self.center.x = x
    }
    
    func CViewSetCenterY(y:CGFloat) {
        self.center.y = y
    }
    
}


extension UIView {
    
    func addSubview(_ view:UIView?, marginInsets:UIEdgeInsets) {
        if let view = view {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: marginInsets.top))
            
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: marginInsets.left))
            
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: marginInsets.bottom))
            
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: marginInsets.right))
        }
    }
}


typealias TapToRetryHandler = (() -> ())

enum StatusType:Int {
    case noResultFound1
    case noResultFound2
    case noResultFound3
    case noInternet
    case other
}


extension UIView{
    func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
}
extension UIView{
    func addDashBorder(color : UIColor) {
        //          let color = UIColor.white.cgColor
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [4,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 6).cgPath
        self.layer.masksToBounds = false
        //        self.layer.insertSublayer(shapeLayer, at: 0)
        self.layer.addSublayer(shapeLayer)
    }
    
    
    func applyGradient(colorOne: UIColor, ColorTwo: UIColor)
    {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [colorOne.cgColor, ColorTwo.cgColor]
        gradient.locations = [0.0, 0.1,1.1,1.0]
        //gradient.startPoint = CGPoint(x: 0.3, y: 0.2)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        // gradient.endPoint = CGPoint(x: 0.4, y: 0.9)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
        // gradient.cornerRadius = 10
        layer.insertSublayer(gradient, at: 0)
        self.clipsToBounds = true
        //self.layer.masksToBounds = false
    }
    
}


class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 131.0 / 255.0, green: 216.0 / 255.0, blue: 216.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 76.0 / 255.0, green: 175.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}


extension UIView {
    func addDashedBorderButton(cornerRadius : CGFloat) {
        //    let color = color
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width , height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor// UIColor.appColor(.themeLight, alpha: 0.4).cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4,2]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIView
{
    func setup_gradiant_button(target:UIView)
    {
        // View to hold the CAGradientLayer.
        // let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 320))
        
        // Initialize gradient layer.
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        // Set frame of gradient layer.
        gradientLayer.frame = target.bounds
        
        // Color at the top of the gradient.
        let topColor: CGColor = #colorLiteral(red: 0.1333333333, green: 0.4509803922, blue: 0.8705882353, alpha: 1)
        
        // Color at the bottom of the gradient.
        let bottomColor: CGColor = #colorLiteral(red: 0.1333333333, green: 0.6, blue: 0.8705882353, alpha: 1)
        
        // Set colors.
        gradientLayer.colors = [topColor, bottomColor]
        
        // Set start point.
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        
        // Set end point.
        gradientLayer.endPoint = CGPoint(x: 1.4, y: 0.5)
        
        // Insert gradient layer into view's layer heirarchy.
        target.layer.insertSublayer(gradientLayer, at: 0)
        target.roundLowerBothCorner(cornerRadius: 7)
    }
    
    func setGradientBackground_button(colorTop: UIColor, colorBottom: UIColor,target:UIView)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.frame.size = target.frame.size
        target.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension UIView {
    
    var safeAreaBottom: CGFloat {
        if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.bottom
            }
        }
        return 0
    }
    
    var safeAreaTop: CGFloat {
        if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.top
            }
        }
        return 0
    }
}

extension UIApplication {
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIView
{
    func constraint(byIdentifier identifier: String) -> NSLayoutConstraint?
    {
        return constraints.first(where: { $0.identifier == identifier })
    }
}

extension UIView {
    func viewCenter(usePresentationLayerIfPossible: Bool) -> CGPoint {
        if usePresentationLayerIfPossible, let presentationLayer = layer.presentation() {
            return presentationLayer.position
        }
        return center
    }
}

extension UIView {
func addBottomShadow() {
   
    layer.shadowRadius = 1
    layer.shadowOpacity = 0.4
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOffset = CGSize(width: 0 , height: 0.5)
    layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                 y: bounds.maxY - layer.shadowRadius,
                                                 width: bounds.width,
                                                 height: layer.shadowRadius)).cgPath
    layer.masksToBounds = false
    
    layer.shouldRasterize = true
}
}

