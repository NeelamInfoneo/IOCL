//
//  AppConstants.swift
//  IOCL
//
//  Created by infoneo on 19/12/22.
//

import Foundation
import UIKit

let kSharedApplication = UIApplication.shared
//let kAppDelegate = kSharedApplication.delegate as? AppDelegate
let kUserDefaults = UserDefaults.standard
let kMainScreen = UIScreen.main
let kBounds = kMainScreen.bounds
let kScreenSize = kBounds.size
let kScreenWidth = kScreenSize.width
let kScreenHeight = kScreenSize.height



public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
    guard let object = object else { return }
    print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
    #endif
}
