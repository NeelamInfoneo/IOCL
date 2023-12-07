//
//  ProfileVC.swift
//  IOCL
//
//  Created by neelam  on 05/01/23.
//

import UIKit
import SideMenu
import Alamofire
import KRProgressHUD


class ProfileVC: UIViewController  ,UITableViewDelegate, UITableViewDataSource  {
    
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var genralTableView: UITableView!
    // @IBOutlet weak var changePassTableView: UITableView!
    @IBOutlet weak var userimg: UIImageView!
    //    @IBOutlet weak var genralBtn: UIButton!
    //    @IBOutlet weak var changPasswordBtn: UIButton!
    //    @IBOutlet weak var genralLabel: UILabel!
    //    @IBOutlet weak var changPasswordLabel: UILabel!
    //    @IBOutlet weak var changePassword: UIView!
    @IBOutlet weak var employeeID_Text: UITextField!
    @IBOutlet weak var companyCode_Text: UITextField!
    @IBOutlet weak var townShipCode_Text: UITextField!
    @IBOutlet weak var firstName_Text: UITextField!
    @IBOutlet weak var lastName_Text: UITextField!
    @IBOutlet weak var gender_Text: UITextField!
    @IBOutlet weak var grade_Text: UITextField!
    @IBOutlet weak var designation_Text: UITextField!
    @IBOutlet weak var departmentCode_Text: UITextField!
    @IBOutlet weak var email_Text: UITextField!
    @IBOutlet weak var mobileNo_Text: UITextField!
    @IBOutlet weak var mobileNoPassword_Text: UITextField!
    @IBOutlet weak var alternatePassword_Text: UITextField!
    @IBOutlet weak var quarterNo_Text: UITextField!
    @IBOutlet weak var officeLocation_Text: UITextField!
    @IBOutlet weak var enterComNo_Text: UITextField!
    @IBOutlet weak var enterComResidenceNo_Text: UITextField!
    
    @IBOutlet weak var alterneteMobile_Text: UITextField!
    
    @IBOutlet weak var mobileNo_YesBtn: UIButton!
    @IBOutlet weak var mobileNo_NoBtn: UIButton!
    
    @IBOutlet weak var alternetNo_YesBtn: UIButton!
    @IBOutlet weak var alternetNo_NoBtn: UIButton!
    //MARK: - VARIABLES -
    var imagevalue:UIImage?
    var picker = UIImagePickerController()
    var imageUrl = String()
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    
    //MARK: - COMPLAINT VARIABLES -
    var townSipArray = [String]()
    var townSipID = Int()
    var townSipDataArray = [[String:Any]]()
    var townSipdropDown:BKDropDown!
    
    var primaryNoSelect = String()
    var secondryNoSelect = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Township name, Company Code, Employee code, Gender, Grade, Department code, Designation, Email
        
        townShipCode_Text.isUserInteractionEnabled = false
        companyCode_Text.isUserInteractionEnabled = false
        employeeID_Text.isUserInteractionEnabled = false
        gender_Text.isUserInteractionEnabled = false
        grade_Text.isUserInteractionEnabled = false
        departmentCode_Text.isUserInteractionEnabled = false
        designation_Text.isUserInteractionEnabled = false
        email_Text.isUserInteractionEnabled = false
        
        mobileNoPassword_Text.setLeftPaddingPoints(10)
        alternatePassword_Text.setLeftPaddingPoints(10)
        
        employeeID_Text.setLeftPaddingPoints(10)
        companyCode_Text.setLeftPaddingPoints(10)
        townShipCode_Text.setLeftPaddingPoints(10)
        firstName_Text.setLeftPaddingPoints(10)
        lastName_Text.setLeftPaddingPoints(10)
        gender_Text.setLeftPaddingPoints(10)
        grade_Text.setLeftPaddingPoints(10)
        departmentCode_Text.setLeftPaddingPoints(10)
        email_Text.setLeftPaddingPoints(10)
        mobileNo_Text.setLeftPaddingPoints(10)
        // mobileNoPassword_Text.setLeftPaddingPoints(10)
        quarterNo_Text.setLeftPaddingPoints(10)
        officeLocation_Text.setLeftPaddingPoints(10)
        enterComNo_Text.setLeftPaddingPoints(10)
        enterComResidenceNo_Text.setLeftPaddingPoints(10)
        
        alterneteMobile_Text.setLeftPaddingPoints(10)
        designation_Text.setLeftPaddingPoints(10)
        // genralBtn.isSelected = true
        //        changPasswordBtn.isSelected = false
        //        genralBtn.backgroundColor = .appColor(.appOrange)
        //        changPasswordBtn.backgroundColor = .white
        //        genralLabel.textColor = .white
        //        changPasswordLabel.textColor = .appColor(.appOrange)
        //        changPasswordBtn.borderColor = .appColor(.appOrange)
        genralTableView.isHidden = false
        //  changePassword.isHidden = true
        CallForGetProfileAPI()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func mobileNoBtnAction(_ sender: UIButton) {
        if sender.tag == 0 {
            mobileNo_YesBtn.isSelected = !mobileNo_YesBtn.isSelected
            if mobileNo_YesBtn.isSelected == true {
                primaryNoSelect = "Y"
                mobileNo_YesBtn.isSelected = true
                mobileNo_NoBtn.isSelected = false
            }else {
                mobileNo_YesBtn.isSelected = false
            }
        }else {
            mobileNo_NoBtn.isSelected = !mobileNo_NoBtn.isSelected
            if mobileNo_NoBtn.isSelected == true {
                primaryNoSelect = "N"
                mobileNo_NoBtn.isSelected = true
                mobileNo_YesBtn.isSelected = false
            }else {
                mobileNo_NoBtn.isSelected = false
            }
        }
    }
    
    
    @IBAction func alternetNoBtnAction(_ sender: UIButton) {
        if sender.tag == 0 {
            alternetNo_YesBtn.isSelected = !alternetNo_YesBtn.isSelected
            if alternetNo_YesBtn.isSelected == true {
                secondryNoSelect = "Y"
                alternetNo_YesBtn.isSelected = true
                alternetNo_NoBtn.isSelected = false
            }else {
                alternetNo_YesBtn.isSelected = false
            }
        }else {
            alternetNo_NoBtn.isSelected = !alternetNo_NoBtn.isSelected
            if alternetNo_NoBtn.isSelected == true {
                secondryNoSelect = "N"
                alternetNo_NoBtn.isSelected = true
                alternetNo_YesBtn.isSelected = false
            }else {
                alternetNo_NoBtn.isSelected = false
            }
        }
        
    }
    
    
    
    
    @IBAction func uploadbtnAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            if UIImagePickerController.availableMediaTypes(for: .photoLibrary) != nil {
                self.picker.allowsEditing = false
                self.picker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(self.picker, animated: true, completion: nil)
            } else {
                //  noCamera()
            }
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as! UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var Size = Float()
        var data = Data()
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        
        //For Kb just remove single 1024 from size
        
        // I am checking 5 MB size here you check as you want
        //        if Size <= 5.00{
        //            imageProduct.image = selectedImage
        //            imagevalue = selectedImage
        //        }
        
        
        imagevalue = selectedImage
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        print(fileUrl.lastPathComponent) // get file Name
        print(fileUrl.pathExtension)
        
        userimg.image = imagevalue
        // CallForImageUploadAPI()
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func backbtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitbtnAction(_ sender: UIButton) {
        
        CallForUpdateProfileAPI()
        
    }
    
    @IBAction func changeBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "User", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        viewController.modalPresentationStyle = .custom
        self.navigationController?.present(viewController, animated: false)
    }
    
    @IBAction func tapOnSideMenuBtn(_ sender: Any) {
        self.backPreviousPage()
    }
    
    @IBAction func townshipTypeBtnAction(_ sender: UIButton) {
        
        if townSipdropDown != nil{
            townSipdropDown
                .setLayoutCell(width: 220)
                .show(self, targetView: sender)
        }
    }
    
    
    //MARK: - SET COMPLAINT SUB DROPDOWN  --------------
    func TownshipSetupDropDown() {
        let cellNormal = UIColor.white
        let cellHighlight = selctedBorder
        townSipdropDown = BKDropDown.instance()
            .bind(townSipArray)
            .setLayoutCell(normal: cellNormal, highlight: cellHighlight, height: 50)
            .setLayoutTitle(normal: .black, highlight: .white)
            .setDidSelectRowAt({ (_, item, dropDown) in
                self.townShipCode_Text.text = item.title
                print("item value \(item.title)")
                for (i,item) in self.townSipDataArray.enumerated() {
                    print(i)
                    self.townSipID = item["TOWNSHIP_CODE"] as! Int
                }
                dropDown.hide()
            })
    }
    
    
    //------TableView Delegate and DataSource-------//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
        
    }
    
    
    //MARK: - API CALLING -
    func CallForGetProfileAPI(){
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
      
        ServiceRequest.shared.GetProfileApi(nil, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            let message = dict?["message"] as? String
            if (statuscode == 200){
                let DataDic = dict?["data"] as? [String:Any]
                self.enterComResidenceNo_Text.text = "\(DataDic?["INTERCOM_NO_RESIDENCE"] as? Int ?? 0)"
                self.enterComNo_Text.text = "\(DataDic?["INTERCOM_NO_OFFICE"] as? Int ?? 0)"
                self.mobileNo_Text.text = "\(DataDic?["MOBILE_NO"] as? Int ?? 0)"
                self.alterneteMobile_Text.text = "\(DataDic?["ADDL_MOBILE_NO"] as? Int ?? 0)"
                self.employeeID_Text.text = DataDic?["EMPNO"] as? String ?? ""
                self.companyCode_Text.text = "\(DataDic?["COMP_CODE"] as? Int ?? 0)"
                self.townShipCode_Text.text = "\(DataDic?["TOWNSHIP_CODE"] as? Int ?? 0)"
                self.firstName_Text.text = DataDic?["FIRST_NAME"] as? String
                self.lastName_Text.text = DataDic?["LAST_NAME"] as? String
                self.gender_Text.text = DataDic?["GENDER"] as? String
                self.grade_Text.text = DataDic?["GRADE"] as? String
                self.designation_Text.text = DataDic?["DESIGNATION"] as? String
                self.departmentCode_Text.text = DataDic?["DEPT_CODE"] as? String
                self.email_Text.text = DataDic?["EMAIL"] as? String
                self.quarterNo_Text.text = DataDic?["QTR_NO"] as? String
                self.officeLocation_Text.text = DataDic?["OFFICE_LOCATION"] as? String
                
                self.townSipID = DataDic?["TOWNSHIP_CODE"] as? Int ?? 0
                self.townShipCode_Text.text = DataDic?["TOWNSHIP_NAME"] as? String
                
                let INTERCOM_NO_OFFICE = DataDic?["INTERCOM_NO_OFFICE"] as? Int ?? 0
                let INTERCOM_NO_RESIDENCE = DataDic?["INTERCOM_NO_RESIDENCE"] as? Int ?? 0
                UserDefaults.standard.setValue(INTERCOM_NO_OFFICE, forKey: "INTERCOM_NO_OFFICE")
                UserDefaults.standard.setValue(INTERCOM_NO_RESIDENCE, forKey: "INTERCOM_NO_RESIDENCE")
                
                let QTR_NO = DataDic?["QTR_NO"] as? String ?? ""
                UserDefaults.standard.setValue(QTR_NO, forKey: "QTR_NO")
                
                let OFFICE_LOCATION = DataDic?["OFFICE_LOCATION"] as? String ?? ""
                UserDefaults.standard.setValue(OFFICE_LOCATION, forKey: "OFFICE_LOCATION")
                
                let ONLY_OTP1 = DataDic?["ONLY_OTP1"] as? String ?? ""
                if ONLY_OTP1 == "Y" {
                    self.mobileNo_YesBtn.isSelected = true
                }else if ONLY_OTP1 == "N" {
                    self.mobileNo_NoBtn.isSelected = true
                }
                let ONLY_OTP2 = DataDic?["ONLY_OTP2"] as? String ?? ""
                
                if ONLY_OTP2 == "Y" {
                    self.alternetNo_YesBtn.isSelected = true
                }else if ONLY_OTP2 == "N" {
                    self.alternetNo_NoBtn.isSelected = true
                }
                
                self.CallForGetTownshipsAPI()
            }else if (statuscode == 401){
                
                
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
                
            }
            
        })
        
    }
    
    //MARK: - GetTownships API CALLING FUNCTIONS ------------------------------------------
    func CallForGetTownshipsAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        
        ServiceRequest.shared.GetTownshipsApi(nil, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            self.townSipArray = []
            let statuscode = dict?["statuscode"] as? Int
            if (statuscode == 200){
                self.townSipDataArray = dict?["data"] as! [[String:Any]]
                for item in self.townSipDataArray {
                    let Name = item["TOWNSHIP_NAME"] as! String
                    self.townSipArray.append(Name)
                }
                self.TownshipSetupDropDown()
            }else if (statuscode == 401){
                
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
    
    
    //MARK: - UpdateProfile API CALLING -
    func CallForUpdateProfileAPI(){
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        
        var params = [String:Any]()
        params = [
            "TOWNSHIP_CODE": townSipID ,
            "PASSWORD" : mobileNoPassword_Text.text ?? "" ,
            "ADDL_MOBILE_NO": alterneteMobile_Text.text ?? "" ,
            "ADDL_MOBILE_NO_PASSWORD": alternatePassword_Text.text ?? "" ,
            "QTR_NO": quarterNo_Text.text ?? "" ,
            "OFFICE_LOCATION": officeLocation_Text.text ?? "" ,
            "INTERCOM_NO_RESIDENCE": enterComResidenceNo_Text.text ?? "" ,
            "INTERCOM_NO_OFFICE": enterComNo_Text.text ?? "" ,
            "ONLY_OTP1": primaryNoSelect ,
            "ONLY_OTP2": secondryNoSelect
        ]
        print(params)
            ServiceRequest.shared.UpdateProfileApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            let message = dict?["message"] as? String
            if (statuscode == 200){
                self.CallForGetProfileAPI()
                self.createAlert(title: kAppName, message: kUpdateProfile)
                self.navigationController?.popViewController(animated: true)
            }else if (statuscode == 401){
                
            }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
                
            }
            
            
        })
        
    }
    
}

