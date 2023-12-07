//
//  VehicleCell.swift
//  IOCL
//
//  Created by InfoneoMacMini on 31/01/23.
//

import UIKit

class VehicleCell: UITableViewCell {
    
    //MARK: -VARIABLES-
    var CT_VEHICLE_NAMECallBack : ((String)->())?
    var CT_VEHICLE_NOCallBack : ((String)->())?
    var CT_DRIVER_NAMECallBack : ((String)->())?
    var CT_DRIVER_CONTACTNOCallBack : ((String)->())?
    
    @IBOutlet weak var Datetext: UITextField!
    @IBOutlet weak var timetext: UITextField!
    @IBOutlet weak var placeToVisitText: UITextField!
    @IBOutlet weak var reportToVisitText: UITextField!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var timeBtn: UIButton!
    @IBOutlet weak var editIconBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var VisitCountText: UILabel!
    @IBOutlet weak var startDateText: UILabel!
    @IBOutlet weak var endDateText: UILabel!
    @IBOutlet weak var reqIDText: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var currentStatusText: UILabel!
    @IBOutlet weak var tripTypeText: UILabel!
    @IBOutlet weak var tripDetailsBtn: UIButton!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var placeToVisitLbl: UILabel!
    @IBOutlet weak var reportToVisitLbl: UILabel!
    @IBOutlet weak var vehicleTypeLbl: UILabel!
    @IBOutlet weak var vehicleNoLbl: UILabel!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var driverContactNoLbl: UILabel!
    @IBOutlet weak var vehicleTypeText: UITextField!
    @IBOutlet weak var vehicleNoText: UITextField!
    @IBOutlet weak var driverMobileNoText: UITextField!
    @IBOutlet weak var driverNameNoText: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setfortextfieldDelegate() {
        vehicleTypeText.delegate = self
        vehicleNoText.delegate = self
        driverMobileNoText.delegate = self
        driverNameNoText.delegate = self
    }
    
}

extension VehicleCell : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.vehicleTypeText {
            if let action = self.CT_VEHICLE_NAMECallBack {
                action(textField.text ?? "")
            }
        }else if textField == self.vehicleNoText {
            if let action = self.CT_VEHICLE_NOCallBack {
                action(textField.text ?? "")
            }
            
        }else  if textField == self.driverNameNoText {
            if let action = self.CT_DRIVER_NAMECallBack {
                action(textField.text ?? "")
            }
            
        }else if textField == self.driverMobileNoText {
            if let action = self.CT_DRIVER_CONTACTNOCallBack {
                action(textField.text ?? "")
            }
        }
        
        return true
      }
    
}

