//
//  Storyboard.swift
//  ThailandFood
//
//  Created by Neelam on 10/23/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func instance(_ storyboard : Storyboard = .authentication) -> UIViewController {
        let storyborad = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let identifire = NSStringFromClass(self).components(separatedBy: ".").last!
        return storyborad.instantiateViewController(withIdentifier: identifire)
    }
}

enum Storyboard: String {
    case authentication = "Main"
  
}
