//
//  CommonCell.swift
//  Athlete
//
//  Created by Neelam on 3/6/22.
//

import UIKit

class CommonCell: UITableViewCell {
    @IBOutlet weak var titletext: UILabel!
    @IBOutlet weak var complaintNotext: UILabel!
    @IBOutlet weak var datetext: UILabel!
    @IBOutlet weak var descriptiontext: UILabel!
    @IBOutlet weak var statustext: UILabel!
    @IBOutlet weak var complaintTypetext: UILabel!
    @IBOutlet weak var complaintFeedBacktext: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var feedbackBtn: UIButton!
    @IBOutlet weak var startDatetext: UITextField!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var FeedBackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var FeedBackViewWidth: NSLayoutConstraint!

    @IBOutlet weak var requestNotext: UILabel!
    @IBOutlet weak var destinationtext: UILabel!
    @IBOutlet weak var approvertext: UILabel!
    @IBOutlet weak var destext: UILabel!
    @IBOutlet weak var leaveTypetext: UILabel!
    
    
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var endDateLbl: UILabel!
    @IBOutlet weak var totalTimeLbl: UILabel!
    @IBOutlet weak var totalQuestionLbl: UILabel!
    @IBOutlet weak var completeMarkBtn: UIButton!
    
    
    @IBOutlet weak var highlySatisfiedLbl: UILabel!
    @IBOutlet weak var satisfiedLbl: UILabel!
    @IBOutlet weak var needsImprovementLbl: UILabel!
    @IBOutlet weak var dissatisfiedLbl: UILabel!
    @IBOutlet weak var highlyDissatisfedLbl: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
            self.backgroundColor = .clear
            selectionStyle = .none
 
//            outerView.makeRoundCornerwithborder(10, bordercolor: .appColor(.appOrange), borderwidth: 1.0)
//            outerView.layer.shadowColor = UIColor.appColor(.black, alpha: 0.08).cgColor
//            outerView.layer.shadowRadius = 3.0
//            outerView.layer.shadowOpacity = 1.0
//            outerView.layer.shadowOffset = CGSize(width: 4, height: 4)
//            outerView.layer.masksToBounds = false
        // Initialization code
    }
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

