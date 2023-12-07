//
//  Common.swift
//  Door2Door
//
//  Created by Komal Gupta on 18/11/20.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

@available(iOS 13.0, *)
func showAlertView(strMessage : String) {
    
    let alertMessage = UIAlertController(title:"", message: strMessage, preferredStyle: UIAlertController.Style.alert)
    alertMessage.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil))
    
   
  
        let delegate = UIApplication.shared.delegate as! AppDelegate
    
  
//    if let vc = delegate.window?.rootViewController {
//
//        vc.present(alertMessage, animated: true, completion: nil)
//    }
}









