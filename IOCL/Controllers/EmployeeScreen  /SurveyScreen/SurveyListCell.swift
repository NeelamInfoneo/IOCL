//
//  SurveyListCell.swift
//  IOCL
//
//  Created by neelam  on 24/04/23.
//

import UIKit

class SurveyListCell: UITableViewCell {

    
    @IBOutlet weak var questionLbl: UILabel!

    @IBOutlet weak var topicLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
