//
//  RemarkSurveyTableViewCell.swift
//  IOCL
//
//  Created by infoneo on 19/04/23.
//

import UIKit

class RemarkSurveyTableViewCell: UITableViewCell {

  
    //MARK: -OUTLETS-
 
    var remarkCallBack : ((String)->())?
    var remarktext = ""
    
    @IBOutlet weak var outerView: UIView!
  
    @IBOutlet weak var remarkLbl: UILabel!
    @IBOutlet weak var remarktextView: UITextView!
    
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
        remarktextView.delegate = self
 
    }
 
}

extension RemarkSurveyTableViewCell : UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let action = self.remarkCallBack {
            action(textView.text)
            
        }
    }
}


