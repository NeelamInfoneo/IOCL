//
//  HomeHeaderView.swift
//  IOCL
//
//  Created by infoneo on 20/12/22.
//

import UIKit

class HomeHeaderView: UITableViewHeaderFooterView {
    //MARK: - VARIABLES -
   
    var callBack: ((Int)->())?
    
    var timer = Timer()
    var counter = 0
    //MARK: - OUTLETS -
    @IBOutlet weak var complaintOuterView: UIView!
    @IBOutlet weak var vehcleRegistrationOuterView: UIView!
    @IBOutlet weak var leaveApplicationOuterView: UIView!
    @IBOutlet weak var feedbackOuterview: UIView!
    @IBOutlet weak var bannerOuterView: UIView!
    @IBOutlet weak var complaintLbl: UILabel!
    @IBOutlet weak var vehcleRegistrationLbl: UILabel!
    @IBOutlet weak var leaveApplicationLbl: UILabel!
    @IBOutlet weak var feedbackLbl: UILabel!
    @IBOutlet weak var bannarCollectionView: UICollectionView!
    
    @IBOutlet weak var complaintAdminView: UIView!
    @IBOutlet weak var vehcleRegistrationAdminView: UIView!
    @IBOutlet weak var outStationAdminView: UIView!
    @IBOutlet weak var feedbackAdminview: UIView!
    @IBOutlet weak var adminView: NSLayoutConstraint!
    @IBOutlet weak var haderTitleLbl: UILabel!
    
    @IBOutlet weak var complaintTitleLbl: UILabel!
    //MARK: - VIEW LIFE CYCLE -
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .clear
        setvc()
    }
    
   
    //MARK: - ACTIONS -
   
    @IBAction func tapOnNavigateBtn(_ sender: UIButton) {
        self.timer.invalidate()
       
        if let action = self.callBack {
            action(sender.tag)
        }
    }
    
    
    
    
    //MARK: - FUNCTIONS -
    private func setvc() {
        
        complaintOuterView.makeRoundCornerwithborder(20, bordercolor: .appColor(.appOrange), borderwidth: 1)
        complaintOuterView.dropShadowCustommain()
        vehcleRegistrationOuterView.makeRoundCornerwithborder(20, bordercolor: .appColor(.appOrange), borderwidth: 1)
        vehcleRegistrationOuterView.dropShadowCustommain()
        leaveApplicationOuterView.makeRoundCornerwithborder(20, bordercolor: .appColor(.appOrange), borderwidth: 1)
        leaveApplicationOuterView.dropShadowCustommain()
        feedbackOuterview.makeRoundCornerwithborder(20, bordercolor: .appColor(.appOrange), borderwidth: 1)
        feedbackOuterview.dropShadowCustommain()
        complaintTitleLbl.text =  "Complaint Admin (\(kUserDefaults.retriveString(.ComplaintAdminCategory)))"
        
        complaintLbl.setAppFontColor(.appColor(.appTextColor), font: .Inter(.medium, size: .oneSix))
        complaintLbl.text = kComplaintEntry
        vehcleRegistrationLbl.setAppFontColor(.appColor(.appTextColor), font: .Inter(.medium, size: .oneSix))
        vehcleRegistrationLbl.text = kVehicleRequisition
        leaveApplicationLbl.setAppFontColor(.appColor(.appTextColor), font: .Inter(.medium, size: .oneSix))
        leaveApplicationLbl.text = kOutstationLeave
        feedbackLbl.setAppFontColor(.appColor(.appTextColor), font: .Inter(.medium, size: .oneSix))
        feedbackLbl.text = kfeedbackSurvey
        
        ////Register of cells
        bannarCollectionView.registerCell(type: HomeBannerCollectionViewCell.self)
        ///connectors of collection View
        bannarCollectionView.delegate = self
        bannarCollectionView.dataSource = self
        bannarCollectionView.backgroundColor = .clear
        bannarCollectionView.isScrollEnabled = false
        bannarCollectionView.showsVerticalScrollIndicator = false
        bannarCollectionView.showsHorizontalScrollIndicator = false
        
        DispatchQueue.main.async {
              self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
           }
    }
    
    @objc func changeImage() {
             
         if counter < 2 {
              let index = IndexPath(item: counter, section: 0)
              self.bannarCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             UICollectionView.transition(with: self.bannarCollectionView, duration:1,
                                         options: UIView.AnimationOptions.transitionCrossDissolve,
                         animations: { }, completion: nil)
              counter += 1
         } else {
              counter = 0
              let index = IndexPath(item: counter, section: 0)
              self.bannarCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             UICollectionView.transition(with: self.bannarCollectionView, duration:1,
                                         options: UIView.AnimationOptions.transitionCrossDissolve,
                         animations: { }, completion: nil)
               counter = 1
           }
      }
    
    
}
//MARK: -Collection View Delegate-
extension HomeHeaderView : UICollectionViewDelegate{
}
//MARK: -Collection View DataSourcee-
extension HomeHeaderView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(withType: HomeBannerCollectionViewCell.self, for: indexPath) as? HomeBannerCollectionViewCell else {
            fatalError("HomeBannerCollectionViewCell is not initialize...")
        }
        if indexPath.item == 0 {
            cell.bannerImg.image = UIImage(named: kImage8)
        }else {
            cell.bannerImg.image = UIImage(named: kImage9)
        }
       
        return cell
    }
}
//MARK: -Collection View Delegate Flow layout-
extension HomeHeaderView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
