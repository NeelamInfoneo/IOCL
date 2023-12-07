//
//  EmployeDetailTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 21/12/22.
//

import UIKit

class EmployeDetailTableViewCell: UITableViewCell {

    //MARK: -VARIABLES-
   
    //MARK: -OUTLETS-
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var empNameLbl: UILabel!
    @IBOutlet weak var empNoheadingLbl: UILabel!
    @IBOutlet weak var empNoLbl: UILabel!
    @IBOutlet weak var outerviewTop: NSLayoutConstraint!
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
        empNoheadingLbl.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneSix))
        empNoheadingLbl.text = kEmpNo + ":"
        NameLbl.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneSix))
        NameLbl.text = kName + ":"
        empNoLbl.setAppFontColor(.appColor(.appDarkRed), font: .Inter(.semiBold, size: .oneSix))
        empNameLbl.setAppFontColor(.appColor(.darkPurple), font: .Inter(.semiBold, size: .oneSix))
       
    }

}
