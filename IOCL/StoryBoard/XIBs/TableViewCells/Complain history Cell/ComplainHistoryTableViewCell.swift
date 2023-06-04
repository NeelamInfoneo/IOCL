//
//  ComplainHistoryTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 22/12/22.
//

import UIKit

class ComplainHistoryTableViewCell: UITableViewCell {

    //MARK: -VARIABLES-
   
    //MARK: -OUTLETS-
   
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var complaintNoLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var complaintDetailLbl: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var typeSeperator: UIView!
    @IBOutlet weak var feedbackBtn: UIButton!
    @IBOutlet weak var feedBackLbl: UILabel!
    
    //MARK: -CELL LIFE CYCLE-
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    //MARK: -ACTIONS-
   
    @IBAction func tapOnStatusBtn(_ sender: Any) {
    }
    @IBAction func tapOnTypeBtn(_ sender: Any) {
    }
    @IBAction func tapOnFeedBackBtn(_ sender: Any) {
    }
    //MARK: -FUNCTIONS-
    private func setCell() {
        
        self.backgroundColor = .clear
        selectionStyle = .none
       
        outerView.makeRoundCornerwithborder(10, bordercolor: .appColor(.appOrange), borderwidth: 1.0)
        outerView.layer.shadowColor = UIColor.appColor(.black, alpha: 0.08).cgColor
        outerView.layer.shadowRadius = 3.0
        outerView.layer.shadowOpacity = 1.0
        outerView.layer.shadowOffset = CGSize(width: 4, height: 4)
        outerView.layer.masksToBounds = false
        complaintNoLbl.setAppFontColor(.appColor(.darkPurple), font: .Inter(.medium, size: .oneFive))
        complaintNoLbl.text = "MN0120221027021"
//        dateLbl.roundCornerAccross(19)
        dateLbl.setAppFontColor(.appColor(.white), font: .Inter(.medium, size: .oneTwo))
        dateLbl.text = "27-10-22"
//        dateLbl.backgroundColor = .appColor(.appOrange)
        
        
        
        complaintDetailLbl.setAppFontColor(.appColor(.textGray), font: .Inter(.regular, size: .oneOne))
        complaintDetailLbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ut purus in metus mollis luctus eu dapibus diam. Curabitur in vehicula risus, ut tempor elit."
        statusBtn.setAppFontColor(.appColor(.darkPurple), font: .Inter(.medium, size: .oneFour))
        statusBtn.makeRoundCornerwithborder(5, bordercolor: .appColor(.appOrange), borderwidth: 1.0)
        statusBtn.setTitle(kStatus, for: .normal)
        typeBtn.setAppFontColor(.appColor(.darkPurple), font: .Inter(.medium, size: .oneFour))
        typeBtn.makeRoundCornerwithborder(5, bordercolor: .appColor(.appOrange), borderwidth: 1.0)
        typeBtn.setTitle(kType, for: .normal)
        feedbackBtn.setAppFontColor(.appColor(.darkPurple), font: .Inter(.medium, size: .oneFour))
        feedbackBtn.makeRoundCornerwithborder(5, bordercolor: .appColor(.appOrange), borderwidth: 1.0)
        feedbackBtn.setTitle(kFeedback, for: .normal)
        
        statusLbl.setAppFontColor(.appColor(.appGreen), font: .Inter(.medium, size: .oneThree))
        statusLbl.text = kCompleted
        typeLbl.setAppFontColor(.appColor(.appLightBlack), font: .Inter(.medium, size: .oneThree))
        typeLbl.text = kPlumbing
        feedBackLbl.setAppFontColor(.appColor(.appLightRed), font: .Inter(.medium, size: .oneThree))
        feedBackLbl.text = kPending
        
        seperatorView.backgroundColor = .appColor(.grayLight)
        typeSeperator.backgroundColor = .appColor(.grayLight)
        
        
        
    }

}
