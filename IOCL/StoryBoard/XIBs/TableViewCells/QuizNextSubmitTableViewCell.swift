//
//  QuizNextSubmitTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 21/03/23.
//

import UIKit

class QuizNextSubmitTableViewCell: UITableViewCell {

    //MARK: -VARIABLES-
    var backBtnCallBack : (()->())?
    var nextBtnCallBack : (()->())?
    var submitBtnCallback : (()->())?
    //MARK: -OUTLETS-
    @IBOutlet weak var QuestionCountLbl: UILabel!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var outerView: UIView!
    //MARK: -CELL LIFE CYCLE-
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    //MARK: -FUNCTIONS-
    private func setCell() {
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        selectionStyle = .none
        prevBtn.setAppFontColor(.appColor(.themeLight), font: .Inter(.semiBold, size: .oneFour))
        prevBtn.makeRoundCornerwithborder(8, bordercolor: .appColor(.themeLight), borderwidth: 1.0)
        nextBtn.setAppFontColor(.appColor(.appGreen), font: .Inter(.semiBold, size: .oneFour))
        nextBtn.makeRoundCornerwithborder(8, bordercolor: .appColor(.appGreen), borderwidth: 1.0)
        submitBtn.setAppFontColor(.appColor(.white), font: .Inter(.semiBold, size: .oneFour))
        submitBtn.makeRoundCornerwithborder(8, bordercolor: .appColor(.white), borderwidth: 1.0)
        submitBtn.backgroundColor = .appColor(.appOrange)
        QuestionCountLbl.setAppFontColor(.appColor(.appTextColor), font: .Inter(.bold, size: .oneFour))
        outerView.dropShadow(shadowColor: .appColor(.grayLight,alpha: 0.6))
       
        prevBtn.isHidden = true
        

    }
    
    @IBAction func tapOnBackBtn(_ sender: Any) {
        if let action = self.backBtnCallBack {
            action()
        }
        
    }
    @IBAction func tapOnNextBtn(_ sender: Any) {
        if let action = self.nextBtnCallBack {
            action()
        }
    }
    
    @IBAction func tapOnSubmitBtn(_ sender: Any) {
        if let action = self.submitBtnCallback {
            action()
        }
    }
    
   
 
}
