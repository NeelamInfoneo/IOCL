//
//  LoginHeaderView.swift
//  IOCL
//
//  Created by infoneo on 20/12/22.
//

import UIKit

class LoginView: UITableViewHeaderFooterView {

    //MARK: - VARIABLES -
    let eyeBtn = UIButton()
    
    var callBackRememberBtn : (()->())?
    var callBackForgetBtn : (()->())?
    var callBackLoginBtn : ((String, String)->())?
    var callBackCreateAccBtn : (()->())?
    //MARK: - OUTLETS -
    @IBOutlet weak var emailMobileLbl: UILabel!
    @IBOutlet weak var emailMobileTxt: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var rememberBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var dontHaveAccLbl: UILabel!
    @IBOutlet weak var createAccBtn: UIButton!
    
    //MARK: - VIEW LIFE CYCLE -
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .clear
       setvc()
    }
    //MARK: - ACTIONS -
    @IBAction func tapOnRememberBtn(_ sender: Any) {
        if let action = self.callBackRememberBtn {
            action()
        }
    }
    @IBAction func tapOnForgetBtn(_ sender: Any) {
        if let action = self.callBackForgetBtn {
            action()
        }
    }
    @IBAction func tapOnLoginBtn(_ sender: Any) {
        
        if let action = self.callBackLoginBtn {
            action(self.emailMobileTxt.text ?? "", passwordTxt.text ?? "")
        }
    }
    @IBAction func tapOnCreateAccBtn(_ sender: Any) {
        if let action = self.callBackCreateAccBtn {
            action()
        }
    }
    //MARK: - FUNCTIONS -
    private func setvc() {
        
        emailMobileLbl.setAppFontColor(.appColor(.grayText), font: .Inter(.medium, size: .oneSix))
        emailMobileLbl.text = kEmailIdOrMobileNumber
    
        emailMobileTxt.makeRoundCornerwithborder(8.0, bordercolor: .appColor(.grayBorder), borderwidth: 1.0)
        emailMobileTxt.setAppFontColor(.appColor(.appTextColor), font: .Inter(.medium, size: .oneEight))
        emailMobileTxt.backgroundColor = .appColor(.white)
        emailMobileTxt.layer.shadowColor = UIColor.appColor(.black, alpha: 0.08).cgColor
        emailMobileTxt.layer.shadowRadius = 3.0
        emailMobileTxt.layer.shadowOpacity = 1.0
        emailMobileTxt.layer.shadowOffset = CGSize(width: 4, height: 4)
        emailMobileTxt.layer.masksToBounds = false
        
        passwordLbl.setAppFontColor(.appColor(.grayText), font: .Inter(.medium, size: .oneSix))
        passwordLbl.text = kPassword
        
        passwordTxt.makeRoundCornerwithborder(8.0, bordercolor: .appColor(.grayBorder), borderwidth: 1.0)
        passwordTxt.setAppFontColor(.appColor(.appTextColor), font: .Inter(.medium, size: .oneEight))
        passwordTxt.backgroundColor = .appColor(.white)
        passwordTxt.layer.shadowColor = UIColor.appColor(.black, alpha: 0.08).cgColor
        passwordTxt.layer.shadowRadius = 3.0
        passwordTxt.layer.shadowOpacity = 1.0
        passwordTxt.layer.shadowOffset = CGSize(width: 4, height: 4)
        passwordTxt.layer.masksToBounds = false
        passwordTxt.setRightPaddingPoints(20)
        //hide unhide password in swift
        eyeBtn.setNormalImage(normalImgName: kIconEyeOpen)
        eyeBtn.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        eyeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        eyeBtn.contentMode = .scaleAspectFit
        eyeBtn.addTarget(self, action: #selector(eyeBtnAction), for: .touchUpInside)
        
        self.passwordTxt.rightView = eyeBtn
        self.passwordTxt.rightViewMode = .always
        
        rememberBtn.setAppFontColor(.appColor(.darkPurple), font: .Inter(.medium, size: .oneTwo))
        rememberBtn.setTitle(kRememberMe, for: .normal)
        forgetBtn.setAppFontColor(.appColor(.darkPurple), font: .Inter(.medium, size: .oneTwo))
        forgetBtn.setTitle(kForgotPassword, for: .normal)
        
        loginBtn.setAppFontColor(.appColor(.white), font: .Inter(.bold, size: .oneSix))
        loginBtn.backgroundColor = .appColor(.appOrange)
        loginBtn.setTitle(kLOGIN, for: .normal)
        loginBtn.makeRoundCorner(8)
        
        
        dontHaveAccLbl.setAppFontColor(.appColor(.grayLightText), font: .Inter(.regular, size: .oneThree))
        dontHaveAccLbl.text = kDontHaveAnAccount
        
        createAccBtn.setAppFontColor(.appColor(.appOrange), font: .Inter(.medium, size: .oneThree))
        createAccBtn.setTitle(kCreateAccount, for: .normal)
        
      
    }
   
    
    
    
    
    @objc func eyeBtnAction() {
        if passwordTxt.isSecureTextEntry == true {
            self.eyeBtn.setNormalImage(normalImgName: kIconEyeOpen)
            passwordTxt.isSecureTextEntry = false
            
        }else {
            self.eyeBtn.setNormalImage(normalImgName: kIconEyeOpen)
            passwordTxt.isSecureTextEntry = true
        }
        
    }

}
