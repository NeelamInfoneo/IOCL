//
//  FeedbackOptionVC.swift
//  IOCL
//
//  Created by neelam  on 19/03/23.
//

import UIKit

class FeedbackOptionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapOnFeedbackBtn(_ sender: Any) {
//        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
//        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func tapOnQuizBtn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "QuizVC") as! QuizVC
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    @IBAction func tapOnSurveyBtn(_ sender: Any) {
//        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "SurveyVC") as! SurveyVC
//        self.navigationController?.pushViewController(viewController, animated: true)
        
        let vc = ServeyListingViewController.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
