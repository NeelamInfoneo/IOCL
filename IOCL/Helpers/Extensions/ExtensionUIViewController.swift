//
//  ExtensionUIViewController.swift
//  Betcha
//
//  Created by Gaurav_kumar on 07/06/21.
//

import Foundation
import UIKit
import AVFoundation
import SideMenu


typealias alertActionHandler = ((UIAlertAction) -> ())?
typealias alertTextFieldHandler = ((UITextField) -> ())
typealias apiErrorHandler = ((_ index: Int, _ btnTitle: String) -> ())

extension UIViewController
{
    
    func setBackgroundImage(imageName: String = "AppBGImg" ) {
        let backgroundImage = UIImage(named: imageName)
        let backgroundImageView = UIImageView(frame: self.view.frame)
        if self.view.safeAreaBottom == 0 {
            //backgroundImageView.frame.size.height = backgroundImageView.frame.size.height - 11
            backgroundImageView.frame.size.height = backgroundImageView.frame.size.height
        }
        backgroundImageView.image = backgroundImage
        self.view.insertSubview(backgroundImageView, at: 0)
        
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: imageName)!)
        
    }
    
    func backPreviousPage()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func presentAlertViewWithOneButton(alertTitle:String? , alertMessage:String? , btnOneTitle:String , btnOneTapped:alertActionHandler)
    {
        
        let alertController = UIAlertController(title: alertTitle ?? "", message: alertMessage ?? "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: .default, handler: btnOneTapped))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertViewWithTwoButtons(alertTitle:String? , alertMessage:String? , btnOneTitle:String , btnOneTapped:alertActionHandler , btnTwoTitle:String , btnTwoTapped:alertActionHandler)
    {
        let alertController = UIAlertController(title: alertTitle ?? "", message: alertMessage ?? "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: .default, handler: btnOneTapped))
        alertController.addAction(UIAlertAction(title: btnTwoTitle, style: .default, handler: btnTwoTapped))
        self.present(alertController, animated: true, completion: nil)
    }
    func presentAlertViewWithThreeButtons(alertTitle:String? , alertMessage:String? , btnOneTitle:String , btnOneTapped:alertActionHandler , btnTwoTitle:String , btnTwoTapped:alertActionHandler , btnThreeTitle:String , btnThreeTapped:alertActionHandler)
    {
        let alertController = UIAlertController(title: alertTitle ?? "", message: alertMessage ?? "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: .default, handler: btnOneTapped))
        
        alertController.addAction(UIAlertAction(title: btnTwoTitle, style: .default, handler: btnTwoTapped))
        
        alertController.addAction(UIAlertAction(title: btnThreeTitle, style: .default, handler: btnThreeTapped))
        
        self.present(alertController, animated: true, completion: nil)
    }
    func createAlert (title:String, message:String)
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in})
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func getThumbnailFrom(path url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        let cache = URLCache.shared
        
        if
            let cachedResponse = cache.cachedResponse(for: request),
            let image = UIImage(data: cachedResponse.data)
        {
            return image
        }
        
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        imageGenerator.maximumSize = resolutionSizeForLocalVideo(url: url) ?? CGSize(width: 350, height: 200)//CGSize(width: 250, height: 120)
        
        var time = asset.duration
        time.value = min(time.value, 1)
        
        var image: UIImage?
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            image = UIImage(cgImage: cgImage)
        } catch { }
        
        if
            let image = image,
            let data = image.pngData(),
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        {
            let cachedResponse = CachedURLResponse(response: response, data: data)
            
            cache.storeCachedResponse(cachedResponse, for: request)
        }
        return image
    }
    
    func resolutionSizeForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
}
//MARK: -ALERT FUNCTION LIKE BANNER-
extension UIViewController {
    func alert(message: String, title: String = "", compleation: (()->())? ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        //    alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) { [weak self] in
                guard self?.presentedViewController == alertController else { return }
                //self?.dismiss(animated: true, completion: nil)
                self?.dismiss(animated: true, completion: {
                    compleation?()
                })
            }
            
        }
    }
}


//MARK: -TOAST FUNCTION -
extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        //User interaction false
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.blue//UIColor.appColor(.b,alpha: 0.8)
        toastLabel.textColor = .appColor(.white)
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10.0, delay: 1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            
            toastLabel.removeFromSuperview()
        })
    } }


//thumbnail extension
extension UIViewController {
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
}





    


