//
//  SurveyCell.swift
//  IOCL
//
//  Created by neelam  on 21/03/23.
//

import UIKit

class SurveyCell: UITableViewCell {

    //MARK: -OUTLETS-
 
    var tapAction : (()->())?
    @IBOutlet weak var OPTIONOUTTR: UIView!
    @IBOutlet weak var opt2: UIView!
    @IBOutlet weak var opt3: UIView!
    @IBOutlet weak var opt4: UIView!
    
    @IBOutlet weak var optNa: UIView!
    @IBOutlet weak var opt5: UIView!
    
    @IBOutlet weak var outerOPTIONOUTTR: UIView!
    @IBOutlet weak var outeopt2: UIView!
    @IBOutlet weak var outeopt3: UIView!
    @IBOutlet weak var outeopt4: UIView!
    
    @IBOutlet weak var outeoptNa: UIView!
    @IBOutlet weak var outeopt5: UIView!
    
    @IBOutlet weak var innerOPTIONOUTTR: UIView!
    @IBOutlet weak var inneropt2: UIView!
    @IBOutlet weak var inneropt3: UIView!
    @IBOutlet weak var inneropt4: UIView!
    
    @IBOutlet weak var inneroptNa: UIView!
    @IBOutlet weak var inneropt5: UIView!
    
    @IBOutlet weak var remarkLbl: UILabel!
    @IBOutlet weak var remarkHeight: NSLayoutConstraint!
    @IBOutlet weak var remarktextView: UITextView!
    @IBOutlet weak var remarkHeightView: NSLayoutConstraint!
    
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
        
        setOuterView(view: self.OPTIONOUTTR)
        setOuterView(view: self.opt2)
        setOuterView(view: self.opt3)
        setOuterView(view: self.opt4)
        setOuterView(view: self.opt5)
        setOuterView(view: self.optNa)
        
        
        setinnterOuterView(view: self.innerOPTIONOUTTR)
        setinnterOuterView(view: self.inneropt2)
        setinnterOuterView(view: self.inneropt3)
        setinnterOuterView(view: self.inneropt4)
        setinnterOuterView(view: self.inneropt5)
        setinnterOuterView(view: self.inneroptNa)
        

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        outerOPTIONOUTTR.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap1(_:)))
        outeopt2.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
        outeopt3.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap3(_:)))
        outeopt4.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap4(_:)))
        outeopt5.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap5(_:)))
        outeoptNa.addGestureRecognizer(tap5)
       
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        setSelectedCell(view: innerOPTIONOUTTR)
        setNormalCell(view: inneropt2)
        setNormalCell(view: inneropt3)
        setNormalCell(view: inneropt4)
        setNormalCell(view: inneropt5)
        setNormalCell(view: inneroptNa)
        remarkLbl.isHidden = false
        remarkHeight.constant =  30
        remarktextView.isHidden = false
        remarkHeightView.constant =  95
        
        
    }
    @objc func handleTap1(_ sender: UITapGestureRecognizer? = nil) {
        setSelectedCell(view: inneropt2)
        setNormalCell(view: innerOPTIONOUTTR)
        setNormalCell(view: inneropt3)
        setNormalCell(view: inneropt4)
        setNormalCell(view: inneropt5)
        setNormalCell(view: inneroptNa)
        remarkLbl.isHidden = true
        remarkHeight.constant =  0
        remarktextView.isHidden = true
         remarkHeightView.constant =  0
       
    }
    @objc func handleTap2(_ sender: UITapGestureRecognizer? = nil) {
        setSelectedCell(view: inneropt3)
        setNormalCell(view: inneropt2)
        setNormalCell(view: innerOPTIONOUTTR)
        setNormalCell(view: inneropt4)
        setNormalCell(view: inneropt5)
        setNormalCell(view: inneroptNa)
        remarkLbl.isHidden = true
        remarkHeight.constant =  0
        remarktextView.isHidden = true
         remarkHeightView.constant =  0
       
    }
    @objc func handleTap3(_ sender: UITapGestureRecognizer? = nil) {
        setSelectedCell(view: inneropt4)
        setNormalCell(view: inneropt2)
        setNormalCell(view: inneropt3)
        setNormalCell(view: innerOPTIONOUTTR)
        setNormalCell(view: inneropt5)
        setNormalCell(view: inneroptNa)
        remarkLbl.isHidden = true
        remarkHeight.constant =  0
        remarktextView.isHidden = true
         remarkHeightView.constant =  0
       
    }
    @objc func handleTap4(_ sender: UITapGestureRecognizer? = nil) {
        setSelectedCell(view: inneropt5)
        setNormalCell(view: inneropt2)
        setNormalCell(view: inneropt3)
        setNormalCell(view: inneropt4)
        setNormalCell(view: innerOPTIONOUTTR)
        setNormalCell(view: inneroptNa)
        remarkLbl.isHidden = true
        remarkHeight.constant =  0
        remarktextView.isHidden = true
         remarkHeightView.constant =  0
       
    }
    @objc func handleTap5(_ sender: UITapGestureRecognizer? = nil) {
        setSelectedCell(view: inneroptNa)
        setNormalCell(view: inneropt2)
        setNormalCell(view: inneropt3)
        setNormalCell(view: inneropt4)
        setNormalCell(view: inneropt5)
        setNormalCell(view: innerOPTIONOUTTR)
        remarkLbl.isHidden = false
        remarkHeight.constant =  30
        remarktextView.isHidden = false
        remarkHeightView.constant =  95
       
    }
    
    
    
    func setOuterView(view : UIView){
        view.makeRounded()
        view.borderWidth = 1
        view.backgroundColor = .appColor(.white)
        view.borderColor = .appColor(.qbNormalBorderGray, alpha: 0.3)
    }
    func setinnterOuterView(view : UIView){
        
        view.makeRounded()
        view.borderWidth = 1
        view.backgroundColor = .clear
     
        view.borderColor = .appColor(.qbBlack)

    }
    
    
    func setSelectedCell(view: UIView){
        view.backgroundColor  = .appColor(.qbBlack)
       
    }
    func setNormalCell(view: UIView){
        view.backgroundColor  = .clear
       
    }
    
 
}
