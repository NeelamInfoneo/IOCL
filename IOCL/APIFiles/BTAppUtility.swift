//
//  BTAppUtility.swift
//  BeanThere
//
//  Created by Priya Sharma on 11/11/16.
//  Copyright © 2016 Priya Sharma. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - Short Terms

@available(iOS 13.0, *)
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
let kAppName = "IOCL BR"
let Window_Width = UIScreen.main.bounds.size.width
let Window_Height = UIScreen.main.bounds.size.height
let appColor = UIColor(red: 61/255.0, green:
                        9.0/255.0, blue: 114.0/255.0, alpha: 1.0)

let freeColor = UIColor(red: 237/255.0, green:
                        227.0/255.0, blue: 222.0/255.0, alpha: 1.0)
let defaults = UserDefaults.standard

// MARK: - Helper functions
//func RGBA(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
//    return UIColor(red: (r/255.0), green: (g/255.0), blue: (b/255.0), alpha: a)
//}

func getViewWithTag(_ tag:NSInteger, view:UIView) -> UIView {
    return view.viewWithTag(tag)!
}

func getStoryboardName() -> String {
    if let langVal = UserDefaults.standard.value(forKey: ""){
        if((langVal as! String) == "2"){
            return "Arabic"
        }else{
            return "English"
        }
    }else{
        return "English"
    }
    
}

func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    
    return label.frame.height
}

func getCurrentViewController() -> UIViewController? {
    
    if let rootController = UIApplication.shared.keyWindow?.rootViewController {
        var currentController: UIViewController! = rootController
        while( currentController.presentedViewController != nil ) {
            currentController = currentController.presentedViewController
        }
        return currentController
    }
    return nil
    
}

//MARK: Helper Method

//Convert UIImage to BASE64ENCODEDSTRING
func convertToBase64EncodedString(image : UIImage) -> String
{
    let image = image
    if let imageData = image.jpegData(compressionQuality: 0.5) {
        let dataString = imageData.base64EncodedString(options: .lineLength64Characters)
        return dataString
    }
    return ""
}


