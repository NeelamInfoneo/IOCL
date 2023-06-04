//
//  NotificationVC.swift
//  AIIA
//
//  Created by InfoneoMacMini on 22/06/22.
//

import UIKit
import Alamofire
import KRProgressHUD


class NotificationVC: UIViewController  ,UITableViewDelegate,UITableViewDataSource {
  
    
    
    @IBOutlet weak var tableView: UITableView!
  
    @IBOutlet weak var topView: UIView!

    var Token = UserDefaults.standard.value(forKey: "Token") as? String
    var UserType = UserDefaults.standard.value(forKey: "UserType") as? Int
    var dataArray =  [NotificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setvc()
              CallForGetNotificationsAPI()
    }
    
    private func setvc() {
        topView.roundCornerBottom(30)
        topView.backgroundColor = .appColor(.appOrange)
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
      
       }

    //------ All Button Action-------//
 
    @IBAction func backbtnAction(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        
    }
  
 
    //------TableView Delegate and DataSource-------//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell") as! CommonCell
        let name = "\(dataArray[indexPath.row].SenderName ?? "") (Emp NO. \(dataArray[indexPath.row].SenderEMPNO ?? 0))"
        cell.titletext.text = name
        cell.datetext.text = dataArray[indexPath.row].CREATED_ON?.convertToDateFormate(current: "yyyy-MM-dd HH:mm" , convertTo: "dd/MM/YYYY") ?? ""
        cell.destext.text = dataArray[indexPath.row].MESSAGE
        cell.statustext.text = dataArray[indexPath.row].MODE_TYPE

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func CallForGetNotificationsAPI(){
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
                self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let url = "\(ApiLink.HOST_URL)\(GetNotifications)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Token ?? "")",
            "Accept": "application/json"
        ]
        print(url)
        ServiceRequest.shared.GetNotificationsApi(nil, completionHandler: { isSucess, response, errorMsg in
        KRProgressHUD.dismiss()
                let dict = response
                print("JSON: \(dict)")
                let statuscode = dict?["statuscode"] as? Int
               if (statuscode == 200){
                   let data = dict?["data"] as! [[String:Any]]
                   var Mobj = [NotificationModel]()
                   for item in data {
                       let obj = NotificationModel.init(item)
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

