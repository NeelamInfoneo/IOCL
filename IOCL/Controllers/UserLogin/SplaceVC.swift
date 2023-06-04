//
//  SplaceVC.swift
//  IOCL
//
//  Created by InfoneoMacMini on 14/02/23.
//

import UIKit
import SwiftyGif

class SplaceVC: UIViewController {

    @IBOutlet weak var gifImage: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.loadGif(name: "iocl")
        let animated_image =   UIImage.gif(name: "iocl")
        gifImage.animationImages = animated_image?.images
        gifImage.animationDuration   = 2
        
        if  gifImage.animationRepeatCount == 5 {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        gifImage.startAnimating()
       
        
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(callback), userInfo: nil, repeats: false)
     
    }
    
    @objc func callback() {
        print("done")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WellcomeScreenVC") as! WellcomeScreenVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }


}






