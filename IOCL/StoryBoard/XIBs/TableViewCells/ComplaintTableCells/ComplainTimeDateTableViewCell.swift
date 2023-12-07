//
//  ComplainTimeDateTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 21/12/22.
//

import UIKit

class ComplainTimeDateTableViewCell: UITableViewCell {

    var openDropDownCallBack: (()->())?
    var openCalendarCallBack: (()->())?
    
    //MARK: -VARIABLES-
    let dropDownbtn = UIButton()
    let calendarBtn = UIButton()
    //MARK: -OUTLETS-
    @IBOutlet weak var outerviewTop: NSLayoutConstraint!
    
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var preferTxt: UITextField!
    @IBOutlet weak var preferredTimeLbl: UILabel!
    @IBOutlet weak var outerviewBottom: NSLayoutConstraint!
    @IBOutlet weak var outerView: UIView!
    //MARK: -CELL LIFE CYCLE-
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    //MARK: -ACTIONS-
   
    @IBAction func tapOnpreferBtn(_ sender: Any) {
        if let action = openDropDownCallBack {
            action()
        }
    }
    @IBAction func tapOnCalendarbtn(_ sender: Any) {
        if let action = openCalendarCallBack {
            action()
        }
    }
    //MARK: -FUNCTIONS-
    private func setCell() {
        
        self.backgroundColor = .clear
        selectionStyle = .none
        outerView.roundCornerBottom(10)
        outerView.layer.borderWidth = 1.0
        outerView.layer.borderColor = UIColor.appColor(.appOrange).cgColor
        DateLbl.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneSix))
        DateLbl.text = KComplaintDate
        preferredTimeLbl.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneSix))
        preferredTimeLbl.text = kPrefrredTime
        
        preferTxt.setAppFontColor(.appColor(.darkPurple), font: .Inter(.semiBold, size: .oneSix))
        dateTxt.setAppFontColor(.appColor(.darkPurple), font: .Inter(.semiBold, size: .oneSix))
        preferTxt.placeholder = "Select"
        
        
        dropDownbtn.setNormalImage(normalImgName: kArrowDownOrangeIcon)
        dropDownbtn.frame = CGRect(x: 0, y: 0, width: 30, height: 15)
        dropDownbtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        dropDownbtn.contentMode = .scaleAspectFit
        self.preferTxt.rightView = dropDownbtn
        self.preferTxt.rightViewMode = .always
        
        calendarBtn.setNormalImage(normalImgName: kArrowDownOrangeIcon)
        calendarBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 15)
        calendarBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        calendarBtn.contentMode = .scaleAspectFit
        self.dateTxt.rightView = calendarBtn
        self.dateTxt.rightViewMode = .always
        
        
        
    }

}
