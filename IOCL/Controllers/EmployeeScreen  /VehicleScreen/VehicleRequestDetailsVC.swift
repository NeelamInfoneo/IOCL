//
//  VehicleRequestDetailsVC.swift
//  IOCL
//
//  Created by neelam  on 16/02/23.
//

import UIKit
import Alamofire
import KRProgressHUD

class VehicleRequestDetailsVC: UIViewController , WWCalendarTimeSelectorProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var dataArray = [trip_request_list]()
    var CM_REQUESTID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CallForGetCarRequestByIdAPI()
        // Do any additional setup after loading the view.
    }
    
@IBAction func backBtnAction(_ sender: UIButton) {
     dismiss(animated: true)
        
    }
    
    
    
}
//MARK: - TABLEV VIEW DATASOURCE -
extension VehicleRequestDetailsVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
       
        cell.DateLbl.text = dataArray[indexPath.row].CT_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "dd/MM/YYYY") ?? ""
        cell.timeLbl.text = dataArray[indexPath.row].CT_DATE?.convertToDateFormate(current: "yyyy-MM-dd'T'HH:mm:ss", convertTo: "hh:mm") ?? ""
        cell.reportToVisitLbl.text = dataArray[indexPath.row].CT_PLACETO_VISIT ?? ""
        cell.placeToVisitLbl.text = dataArray[indexPath.row].CT_PLACETO_REPORT ?? ""
        if dataArray[indexPath.row].CT_VEHICLE_NAME  == nil{
            cell.vehicleTypeLbl.text =  "NA"
        }else {
            cell.vehicleTypeLbl.text = dataArray[indexPath.row].CT_VEHICLE_NAME ?? ""
        }
        if dataArray[indexPath.row].CT_VEHICLE_NO  == nil{
            cell.vehicleNoLbl.text = "NA"
        }else {
            cell.vehicleNoLbl.text = dataArray[indexPath.row].CT_VEHICLE_NO ?? ""
        }
        
        if dataArray[indexPath.row].CT_VEHICLE_NO  == nil{
            cell.driverNameLbl.text = "NA"

        }else {
            cell.driverNameLbl.text = dataArray[indexPath.row].CT_DRIVER_NAME ?? ""
        }
        
        if dataArray[indexPath.row].CT_VEHICLE_NO  == nil{
            cell.driverContactNoLbl.text = "NA"

        }else {
            cell.driverContactNoLbl.text = dataArray[indexPath.row].CT_DRIVER_CONTACTNO ?? ""
        }
    return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
        
    }
    
    
}


extension VehicleRequestDetailsVC {
    
    //MARK: - GetComplaint History API CALLING FUNCTIONS ------------------------------------------
    func CallForGetCarRequestByIdAPI() {
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let params : [String:Any]  = [
            "CM_REQUESTID" : CM_REQUESTID ,
            ]
        ServiceRequest.shared.GetCarRequestByIdApi(params, completionHandler: { isSucess, response, errorMsg in
            KRProgressHUD.dismiss()
                let dict = response
                print("JSON: \(dict)")
                 let statuscode = dict?["statuscode"] as? Int
                if (statuscode == 200){
                   let data = dict?["data"] as! [String:Any]
                    let tripRequestList = data["trip_request_list"] as! [[String:Any]]
                    var Mobj = [trip_request_list]()
                    for item in tripRequestList {
                        let obj = trip_request_list.init(item)
                        Mobj.append(obj)
                    }
                    self.dataArray = Mobj
                    self.tableView.reloadData()
                }else if (statuscode == 401){
                }else {
                KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: kServerError)
            }
        })
    }
}

