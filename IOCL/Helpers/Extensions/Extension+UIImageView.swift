//
//  Extension+UIImageView.swift
//  Betcha
//
//  Created by admin on 01/07/21.
//

import UIKit
import Foundation
import SDWebImage


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    //func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?) {
    func loadImageUsingCache(
        withUrl urlString : String,
        isShowIndicator: Bool,
        placeHolder: UIImage? = nil,
        isSucessImageLoadCompleationHandler: @escaping ((Bool)-> ())
    ) {
        if urlString.isEmpty {
            isSucessImageLoadCompleationHandler(false)
            return
        }
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return
        }
        
        var activityIndicator: UIActivityIndicatorView?
        if isShowIndicator {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
            
            if #available(iOS 13.0, *) {
                activityIndicator?.style = .medium
            } else {
                activityIndicator?.style = .gray
            }
            activityIndicator?.tintColor = UIColor.gray//UIColor.darkGray
            activityIndicator?.color = UIColor.gray
            addSubview(activityIndicator!)
            activityIndicator?.startAnimating()
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async { [weak self] in
                        if let indicator = activityIndicator {
                            indicator.removeFromSuperview()
                        }
                        self?.image = placeHolder
                    }
                    isSucessImageLoadCompleationHandler(false)
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let indicator = activityIndicator {
                        indicator.removeFromSuperview()
                    }
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                            self?.image = downloadedImage
                        } else {
                            isSucessImageLoadCompleationHandler(false)
                        }
                    } else {
                        isSucessImageLoadCompleationHandler(false)
                    }
                }
            }).resume()
        }
    }
}

extension UIImageView {
    func setImageWithURL(_ url:URL, placeholderImage: UIImage){
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: .continueInBackground, context: nil)
    }
}

