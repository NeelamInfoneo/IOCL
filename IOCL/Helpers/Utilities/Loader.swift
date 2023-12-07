//
//  Loader.swift
//  IOCL
//
//  Created by infoneo on 19/12/22.
//

import KRProgressHUD
import UIKit

class Loader {
    
    static func isLoader(show flag: Bool, compleation: (()-> Void)? = nil ) {
        if flag {
           
            DispatchQueue.main.async { KRProgressHUD.show() }
            
        } else {
            //DispatchQueue.main.async { KRProgressHUD.dismiss() }
            let queue = DispatchQueue(label: "TestQueue")
            DispatchWorkItem.run(on: queue, waitfor: .seconds(1)) {
                DispatchQueue.main.async { KRProgressHUD.dismiss() }
                }.notify(queue: DispatchQueue.main) {
                    print("Tasks are done, Update UI")
                    compleation?()
            }
        }
    }
}


public typealias DispatchBlock = () -> Swift.Void

public extension DispatchWorkItem {
    
    @discardableResult static func run(on queue: DispatchQueue? = nil, waitfor interval: DispatchTimeInterval? = nil, execute: @escaping DispatchBlock) -> DispatchWorkItem {
        let w = DispatchWorkItem(block: execute)
        if let waitInterval = interval { w.wait(waitInterval) }
        if let q = queue {
            q.async(execute: w)
        }else {
            w.perform()
        }
        return w
    }
    
    private func wait(_ interval: DispatchTimeInterval) {
        let _ =  self.wait(timeout: DispatchTime.now() + interval)
    }
}
