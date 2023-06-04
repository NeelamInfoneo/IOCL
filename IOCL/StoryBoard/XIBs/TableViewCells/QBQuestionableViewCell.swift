//
//  QBQuestionableViewCell.swift
//  DBMCI
//
//  Created by Gaurav_kumar_MaC on 13/10/22.
//  Copyright © 2022 RipenApps. All rights reserved.
//

import UIKit

class QBQuestionableViewCell: UITableViewCell {

    
    //MARK: -VARIABLES-
    
    //MARK: -OUTLETS-
    
    @IBOutlet weak var quesTxtView: UILabel!
    
    
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
        quesTxtView.backgroundColor = .clear
    }
    
    
   
}
