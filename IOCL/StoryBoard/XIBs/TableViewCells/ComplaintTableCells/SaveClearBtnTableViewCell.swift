//
//  SaveClearBtnTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 21/12/22.
//

import UIKit

class SaveClearBtnTableViewCell: UITableViewCell {

    //MARK: -VARIABLES-
    var saveCallBack : (()->())?
    var clearCallBack : (()->())?
    
    //MARK: -OUTLETS-
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var clearbtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
   
   
    //MARK: -CELL LIFE CYCLE-
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    //MARK: -ACTIONS-
   
    @IBAction func tapOnClearBtn(_ sender: Any) {
        if let action = clearCallBack {
            action()
        }
    }
    @IBAction func tapOnSaveBtn(_ sender: Any) {
        if let action = saveCallBack {
            action()
        }
    }
    //MARK: -FUNCTIONS-
    private func setCell() {
        
        self.backgroundColor = .clear
        selectionStyle = .none
        outerView.backgroundColor = .clear
        saveBtn.backgroundColor = .appColor(.appOrange)
        saveBtn.setTitle(kSAVE, for: .normal)
        saveBtn.setAppFontColor(.appColor(.white), font: .Inter(.medium, size: .oneSix))
        
        saveBtn.makeRoundCorner(8)
        clearbtn.backgroundColor = .appColor(.darkPurple)
        clearbtn.setAppFontColor(.appColor(.white), font: .Inter(.medium, size: .oneSix))
        clearbtn.setTitle(kCLEAR, for: .normal)
        clearbtn.makeRoundCorner(8)
        
      
    }

}
