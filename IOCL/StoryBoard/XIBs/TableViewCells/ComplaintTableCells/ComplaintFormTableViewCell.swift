//
//  ComplaintFormTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 21/12/22.
//

import UIKit

class ComplaintFormTableViewCell: UITableViewCell {
    //MARK: -VARIABLES-
    var callBackDropDown : (()->())?
    let dropDownbtn = UIButton()
    var txtCallBack : ((String)-> Void)?
    
    //MARK: -OUTLETS-
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var typeTxt: UITextField!
    
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var outerviewtop: NSLayoutConstraint!
    @IBOutlet weak var outerViewBottom: NSLayoutConstraint!
    //MARK: -CELL LIFE CYCLE-
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    //MARK: -ACTIONS-
   
    //MARK: -FUNCTIONS-
    private func setCell() {
        
        self.backgroundColor = .clear
        selectionStyle = .none
        outerView.roundCornerBottom(10)
        outerView.layer.borderWidth = 1.0
        outerView.layer.borderColor = UIColor.appColor(.appOrange).cgColor
        headingLbl.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneSix))
        
        typeTxt.setAppFontColor(.appColor(.darkPurple), font: .Inter(.semiBold, size: .oneSix))
        typeTxt.makeRoundCornerwithborder(8.0, bordercolor: .appColor(.grayBorder), borderwidth: 1.0)
        typeTxt.backgroundColor = .appColor(.white)
       
        self.typeTxt.rightView = nil
        dropDownBtn.isHidden = true
    }

    @IBAction func tapOnDropDownBtn(_ sender: Any) {
        if let action = callBackDropDown {
            action()
        }
    }
    
    func setCellforDropDown() {
        
        dropDownbtn.setNormalImage(normalImgName: kArrowDownOrangeIcon)
        dropDownbtn.frame = CGRect(x: 0, y: 0, width: 30, height: 15)
        dropDownbtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        dropDownbtn.contentMode = .scaleAspectFit
        self.typeTxt.rightView = dropDownbtn
        self.typeTxt.rightViewMode = .always
        
        dropDownBtn.isHidden = false
    }
    func setCellforTextField() {
        
        self.typeTxt.rightView = nil
        typeTxt.delegate = self
        dropDownBtn.isHidden = true
    }
}

extension ComplaintFormTableViewCell : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let call = self.txtCallBack {
            call(typeTxt.text!)
        }
       
    }
}

