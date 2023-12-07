//
//  ComplainHistoryBtnTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 21/12/22.
//

import UIKit

class ComplainHistoryBtnTableViewCell: UITableViewCell {

    //MARK: -VARIABLES-
    var historyBtnCallBack: (()->())?
    //MARK: -OUTLETS-
   
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var outerview: UIView!
    //MARK: -CELL LIFE CYCLE-
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    //MARK: -ACTIONS-
   
    @IBAction func tapOnHistoryBtn(_ sender: Any) {
        if let action = historyBtnCallBack {
            action()
        }
    }
    //MARK: -FUNCTIONS-
    private func setCell() {
        
        self.backgroundColor = .clear
        selectionStyle = .none
        outerview.backgroundColor = .clear
        historyBtn.setTitle(kCOMPLAINTHISTORY, for: .normal)
        historyBtn.setAppFontColor(.appColor(.appOrange), font: .Inter(.semiBold, size: .oneSix))
        historyBtn.backgroundColor = .appColor(.white)
        historyBtn.makeRoundCornerwithborder(8, bordercolor: .appColor(.appOrange), borderwidth: 1.0)

        historyBtn.layer.shadowColor = UIColor.appColor(.black, alpha: 0.08).cgColor
        historyBtn.layer.shadowRadius = 3.0
        historyBtn.layer.shadowOpacity = 1.0
        historyBtn.layer.shadowOffset = CGSize(width: 4, height: 4)
        historyBtn.layer.masksToBounds = false
    }

}
