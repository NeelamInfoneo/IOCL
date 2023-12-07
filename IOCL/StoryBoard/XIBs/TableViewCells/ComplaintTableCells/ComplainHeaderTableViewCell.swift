//
//  ComplainHeaderTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 21/12/22.
//

import UIKit

class ComplainHeaderTableViewCell: UITableViewCell {

    //MARK: -VARIABLES-
   
    //MARK: -OUTLETS-
   
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var headingLbl: UILabel!
  
    
    //MARK: -CELL LIFE CYCLE-
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    //MARK: -ACTIONS-
   
    //MARK: -FUNCTIONS-
    private func setCell() {
        
//        self.backgroundColor = .clear
//        selectionStyle = .none
//        outerView.backgroundColor = .appColor(.darkPurple)
//        outerView.roundCornerUp(10.0)
//        headingLbl.setAppFontColor(.appColor(.white), font: .Inter(.medium, size: .oneFour))
        
    }

}
