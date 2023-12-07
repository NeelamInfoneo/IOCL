//
//  ExtensionUIResponder.swift
//  List It
//
//  Created by apple on 20/10/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension of UIResponder For getting the ParentViewController(UIViewController) of any UIView.
extension UIResponder {
    
    /// This Property is used to getting the ParentViewController(UIViewController) of any UIView.
    var viewController:UIViewController? {
        
        if self.next is UIViewController {
            return self.next as? UIViewController
        } else {
            guard self.next != nil else { return nil }
            return self.next?.viewController
        }
    }
}
