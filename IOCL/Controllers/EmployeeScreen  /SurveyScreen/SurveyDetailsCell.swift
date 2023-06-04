//
//  SurveyDetailsCell.swift
//  IOCL
//
//  Created by neelam  on 24/04/23.
//

import UIKit

class SurveyDetailsCell: UITableViewCell {

    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var highlySatisfiedLbl: UILabel!
    @IBOutlet weak var satisfiedLbl: UILabel!
    @IBOutlet weak var needsImprovementLbl: UILabel!
    @IBOutlet weak var dissatisfiedLbl: UILabel!
    @IBOutlet weak var highlyDissatisfedLbl: UILabel!
    @IBOutlet weak var weightedScorelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
