//
//  AppUtility.swift
//  EJACK
//
//  Created by lion on 29/09/20.
//  Copyright © 2020 lion. All rights reserved.
//

import UIKit
import Foundation

import CoreLocation


//let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
//let Window_Width = UIScreen.main.bounds.size.width
//let Window_Height = UIScreen.main.bounds.size.height

let RegistrationStoryboard = UIStoryboard(name: "Registration", bundle: nil)
let HomeStoryboard = UIStoryboard(name: "Home", bundle: nil)

let WIP = "Work in progress..."


// MARK: - Helper functions
func RGBA(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: (r/255.0), green: (g/255.0), blue: (b/255.0), alpha: a)
}

func AppMediumFont(_ size :CGFloat) -> UIFont {
    return UIFont(name:"JosefinSans-SemiBold", size: size)!
}

func AppRegularFont(_ size :CGFloat) -> UIFont {
    return UIFont(name:"QUESTRIAL-REGULAR", size: size)!
}

func getUserDefaultValue(_ forKey :String) -> String {
    if let string = UserDefaults.standard.value(forKey: forKey) as? String {
        return string
    }
    return ""
}

func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

func convert24HrsTimeTo12HrsTime(str: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let date = dateFormatter.date(from: str)
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "hh:mm a"
    let timeStr = dateFormatterGet.string(from: date!)
    return timeStr
}

func setAttributedText(button : UIButton, priceString: String, tenure : String) -> NSMutableAttributedString {
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.numberOfLines = 3
    let finalStr : NSMutableAttributedString = NSMutableAttributedString()
    let priceOfPlan = NSMutableAttributedString.init(string: priceString, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 28), NSAttributedString.Key.foregroundColor : UIColor.white])
    let tenuStr = "\n\(tenure)"
    let tenure = NSMutableAttributedString.init(string: tenuStr, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white])
    
    finalStr.append(priceOfPlan)
    finalStr.append(tenure)
    return finalStr
    
}

func convertToDate(time: String, format: String) -> String {
    if time.isEmpty {
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: time)// dateFormatter.date(from: time)
    if date == nil {
        return ""
    }
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = format
    let timeStr = dateFormatterGet.string(from: date!)
    return timeStr
}

func convertToDate(date: Date, format: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = format
    let timeStr = dateFormatterGet.string(from: date)
    return timeStr
}

func setPlaceholder(placeholder:String, color : UIColor = .white) -> NSAttributedString? {
    let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor:color])
    return attributedPlaceholder
}


class AppUtilities: NSObject {
    
    class func printFontFamily() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
    
    class func JSONFromFile(path :String)-> Array<Any> {
        
        let path : String = Bundle.main.path(forResource: path, ofType: "json")!
        
        let data =  NSData( contentsOfFile: path )
        
        return [try! JSONSerialization.jsonObject(with: data! as Data, options:[]) ]
        
    }
    
    
    class func addToolBarOnView(_ controller: UIViewController ) -> UIToolbar {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: Window_Width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: controller, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        return doneToolbar
    }
    
    @objc func doneButtonAction() {
    }
    
    
}


// Location Helper methods
extension AppUtilities {
    
    
   
}

// MARK:- UIView Extensions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
extension UIView {
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
 
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    
  
   
    
   
    

    
    func setBorder(color:UIColor, borderWidth:CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
    
    func generateImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    
    
    
    func aroundShadow(_ color: UIColor = UIColor.lightGray) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
    }
    
}

extension UIViewController {

    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIDevice {
    /// Returns `true` if the device has a notch
    var hasNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}


extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

extension UIImage {

func resized(withPercentage percentage: CGFloat) -> UIImage? {
    let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
    UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
    defer { UIGraphicsEndImageContext() }
    draw(in: CGRect(origin: .zero, size: canvasSize))
    return UIGraphicsGetImageFromCurrentImageContext()
}

func resizedTo1MB() -> UIImage? {
    guard let imageData = self.pngData() else { return nil }

    var resizingImage = self
    var imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB

    while imageSizeKB > 1000 { // ! Or use 1024 if you need KB but not kB
        guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
            let imageData = resizedImage.pngData()
            else { return nil }

        resizingImage = resizedImage
        imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
    }

    return resizingImage
}
}

@available(iOS 13.0, *)
class View: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    func addShadows(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.borderColor = CGColor(red: 243/255.0, green:
                                        236.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
           if #available(iOS 11, *) {
               var cornerMask = CACornerMask()
               if(corners.contains(.topLeft)){
                   cornerMask.insert(.layerMinXMinYCorner)
               }
               if(corners.contains(.topRight)){
                   cornerMask.insert(.layerMaxXMinYCorner)
               }
               if(corners.contains(.bottomLeft)){
                   cornerMask.insert(.layerMinXMaxYCorner)
               }
               if(corners.contains(.bottomRight)){
                   cornerMask.insert(.layerMaxXMaxYCorner)
               }
               self.layer.cornerRadius = radius
               self.layer.maskedCorners = cornerMask

           } else {
               let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
               let mask = CAShapeLayer()
               mask.path = path.cgPath
               self.layer.mask = mask
           }
       }
    
  
}
extension UISwitch {

    func set(width: CGFloat, height: CGFloat) {

        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
