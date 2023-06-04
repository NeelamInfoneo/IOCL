//
//  QBOptionsTableViewCell.swift
//  DBMCI
//
//  Created by Gaurav_kumar_MaC on 13/10/22.
//  Copyright © 2022 RipenApps. All rights reserved.
//

import UIKit

class QBOptionsTableViewCell: UITableViewCell {

    //MARK: -VARIABLES-
    
    //MARK: -OUTLETS-
    @IBOutlet weak var optionOuterView: UIView!
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var optionInnerView: UIView!
    @IBOutlet weak var optionLbl: UILabel!
//    var tapAction : (()->())?
    
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
        
       optionOuterView.roundCornerRadius(cornerRadius: 7)
        optionOuterView.borderWidth = 1
        circularView.makeRounded()
        circularView.borderWidth = 1
        circularView.backgroundColor = .clear
        optionOuterView.backgroundColor = .appColor(.white)
        optionOuterView.borderColor = .appColor(.qbNormalBorderGray, alpha: 0.3)
        circularView.borderColor = .appColor(.qbBlack)
        optionLbl.textColor = .appColor(.qbBlack)
        optionInnerView.makeRounded()
        

    }
    
    
    func setNormalCell(){
        optionInnerView.backgroundColor = .appColor(.white)
    }
    
    func setSelectedCell(){
        optionInnerView.backgroundColor = .appColor(.qbBlack)
    }
 
}
