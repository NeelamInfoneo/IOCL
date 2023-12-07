//
//  ComplainDetailTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 21/12/22.
//

import UIKit

class ComplainDetailTableViewCell: UITableViewCell {

    //MARK: -VARIABLES-
    var txtCallBack : ((String)-> Void)?
    //MARK: -OUTLETS-
   
    @IBOutlet weak var outerviewTop: NSLayoutConstraint!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var outerviewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var DetailTextView: UITextView!
    @IBOutlet weak var headingLbl: UILabel!
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
        DetailTextView.font = .Inter(.semiBold, size: .oneSix)
        DetailTextView.textColor = .appColor(.darkPurple)
        DetailTextView.placeholderFont = .Inter(.mediumItalic, size: .oneSix)
        DetailTextView.placeholder = "Max. 500 Character"
        DetailTextView.placeholderColor = .appColor(.grayText)
        DetailTextView.makeRoundCornerwithborder(8.0, bordercolor: .appColor(.grayBorder), borderwidth: 1.0)
        DetailTextView.delegate = self
      
    }

}

extension ComplainDetailTableViewCell : UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let call = self.txtCallBack {
            call(DetailTextView.text!)
        }
    }
}
