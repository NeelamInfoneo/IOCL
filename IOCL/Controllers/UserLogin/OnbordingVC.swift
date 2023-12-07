//
//  OnbordingVC.swift
//  Furpics
//
//  Created by Codenicely  on 22/03/23.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage

class OnbordingVC: UIViewController {
    //MARK: - OUTLET -
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var IntroPageControl: UIPageControl!
    
    
    //MARK: - VARABEL -
    var OnbordingArray = [OnbordingModelData]()
    var OnbordingData = [[String:Any]]()
    var Count = 0
    
    
    //MARK: - VIEW LIFE CYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        CallForGetOnboardingAPI()
        // Do any additional setup after loading the view.
    }
    //MARK: - BUTTON ACTIONS -
    @IBAction func tapOnNextBtn(_ sender: UIButton) {
        self.Count = self.Count + 1
        if self.Count == self.OnbordingArray.count {
            let vc = WellcomeScreenVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            self.scrollToNextStory(count: Count)
        }
        
  
    }
    
    @IBAction func tapOnSkipBtn(_ sender: UIButton) {
        let vc = WellcomeScreenVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
        for cell in self.collectionView.visibleCells {
            let indexPath = self.collectionView.indexPath(for: cell)
            
            if indexPath?.row == 0{
            }
            else if indexPath?.row == (self.OnbordingArray.count - 1){
                let vc = LoginVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func scrollToNextStory(count: Int) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: count, section: 0)
            print("Scroll to next")
            print(indexPath)
            self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        }
    }
}

extension OnbordingVC : UICollectionViewDelegate{
    
    
}



extension OnbordingVC:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        IntroPageControl.numberOfPages = OnbordingArray.count
        return OnbordingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommonCollectionCell", for: indexPath)as! CommonCollectionCell
      //  cell.desLbl.text = OnbordingArray[indexPath.row].DESCRIPTION ?? ""
//        if let image = OnbordingArray[indexPath.row].FILEURL, let url = URL(string: image)  {
//            cell.img.downloadedsvg(from: url)
//        }else {
//            cell.img.image = UIImage(named: "Frame_1201_1")
//        }
        
        let img1 = OnbordingArray[indexPath.row].FILEURL
        if img1 == nil{
            cell.img.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "Rectangle 3254"))
        }else {
        cell.img.sd_setImage(with: URL(string:img1 ?? ""), placeholderImage: UIImage(named: "Rectangle 3254"))
        }
        return cell
        }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // return CGSize(width: collectionView.bounds.width  , height: 798)
        return CGSize(width: self.collectionView.frame.size.width , height: self.collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if IntroPageControl.currentPage == 2{
//            self.next_outlet.isHidden = false
//        } else{
//            self.next_outlet.isHidden = true
//        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {

        IntroPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        IntroPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    
}


extension OnbordingVC {
    
    //MARK: - GetOnboarding API -
    func CallForGetOnboardingAPI(){
        KRProgressHUD.show()
        if reachability.isConnectedToNetwork() == false{
            KRProgressHUD.dismiss()
            self.createAlert(title: kAppName, message: ApiLink.INTERNET_ERROR_MESSAGE)
            return
        }
        let url = "https://chat.infoneotech.com\(GetPromotionalOffers)"
        print(url)
        ServiceRequest.shared.GetPromotionalOffersApI(nil) { isSucess, response, errorMsg in
            let dict = response
            print("JSON: \(dict)")
            let statuscode = dict?["statuscode"] as? Int
            let message = dict?["message"] as? String
            if statuscode == 200{
                let userData = dict?["data"] as? [[String:Any]]
                var Mobj = [OnbordingModelData]()
                for item in userData ?? [] {
                    let obj = OnbordingModelData.init(item)
                    Mobj.append(obj)
                }
                self.OnbordingArray = Mobj
                self.collectionView.reloadData()
            }else{
                self.createAlert(title: kAppName, message: message ?? "")
            }
            
        }
        
    }
    
}



