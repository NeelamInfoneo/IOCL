//
//  CommonUtilities.swift
//  IOCL
//
//  Created by infoneo on 19/12/22.
//

import Foundation
import PhotosUI
import Alamofire


class CommonUtilities
{
    static let shared = CommonUtilities()
    
    let userName = "admin"
    let password = "12345"
 
    var Token = UserDefaults.standard.value(forKey: "Token") as? String ?? ""
    
    
//      var bearerHeaders: HTTPHeaders {
//        [
//          "Authorization": "Bearer XTJCAvT8P9manD3YAO+wXf9D+PWcdYr7CjC05yh7B2yOGktBarQNk3wm0T8EJ5Vi93xO4XiBcpK4yxcwxMfS0C2pUGVF9k9e8+jBWzbihSyHkz35twh2QPwKCpiFjeZLJYfhKUvr2N91kJpA/s/T2RJHdHOYukNnE2S1tV1dndHYx9Ctg6BwR+YwVW1/H1SKKw2TeCIgpJLB7hY9Nw/PUQ==",
//          "Content-Type": "application/json"
//        ]
//      }
    var bearerHeaders: HTTPHeaders {
      [
        "Authorization": "Bearer \(kUserDefaults.retriveString(.Token))",
        "Content-Type": "application/json"
      ]
    }
//    Token

 
    //get asssests thumbnails
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        var arrayOfImages = [UIImage]()
        for asset in assets {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                image = result!
                arrayOfImages.append(image)
            })
        }
        
        return arrayOfImages
    }
    
    
//    func getVideoThumbnailImage(forUrl url: URL,   completionHandler: @escaping( _ isSucess: UIImage?)-> Void ) {
//        DispatchQueue.global(qos: .background).async {
//            //background code
//            
//            let asset: AVAsset = AVAsset(url: url)
//            let imageGenerator = AVAssetImageGenerator(asset: asset)
//            
//            do {
//                let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
//                completionHandler(UIImage(cgImage: thumbnailImage))
//            } catch let error {
//                completionHandler(UIImage(named: kIconbackImageLogo))
//                print(error)
//            }
//        }
//    }
//    
//    func getVideoThumbnailImage(forUrl url: URL)-> UIImage? {
//        //DispatchQueue.global(qos: .background).async {
//        //background code
//        
//        let asset: AVAsset = AVAsset(url: url)
//        let imageGenerator = AVAssetImageGenerator(asset: asset)
//        
//        do {
//            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
//            return UIImage(cgImage: thumbnailImage)
//        } catch let error {
//            print(error)
//            return UIImage(named: kIconbackImageLogo)
//        }
//    }
//    
    //differnce time betweeen created post time and current time
    func differnceTime(sendTime:String) -> String
    {
        let dateFormatter = DateFormatter() //"2021-08-24T05:47:59.899Z"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSS'Z'"
        
        let fmt = ISO8601DateFormatter()
        fmt.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let date1 = fmt.date(from: sendTime) ?? Date()
        let date2 = fmt.date(from: getCurrentTime()) ?? Date()
        
        let diffs = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date1, to: date2)
        
        
        if (diffs.year! > 0)
        {
            print("\(diffs.year!) years")
            return "\(diffs.year!) years"
        }
        else if(diffs.month! > 0)
        {
            print("\(diffs.month!) months")
            return "\(diffs.month!) months"
        }
        else if(diffs.day! > 0)
        {
            print("\(diffs.day!) day")
            return "\(diffs.day!) day"
        }
        else if(diffs.hour! > 0)
        {
            print("\(diffs.hour!) hours")
            return "\(diffs.hour!) hours"
        }
        else if(diffs.minute! > 0)
        {
            print("\(diffs.minute!) minutes")
            return "\(diffs.minute!) minutes"
        }
        else
        {
            print("\(diffs.second!) seconds")
            return "\(diffs.second!) seconds"
        }
        
    }
    func getCurrentTime() -> String
    {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:SSS'Z'"
        let dateString = df.string(from: date)
        return dateString
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:SSS'Z'" //"yyyy-MM-ddTHH:mm:ss.ssssssZ" //2021-08-24T10:09:16.000000Z
        
        guard let date = dateFormatter.date(from: date) else { return "date" }
//        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateFormat = "d MMM, yyyy"
        return  dateFormatter.string(from: date)
    }
    
    public func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"//this is your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)
        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }
       
        dateFormatter.dateFormat = "dd MMM yyyy, h:mm a"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        print(timeStamp)
        return timeStamp
    }
    
    
    
    
//    func setTableViewPlaceHolder(_ tblView: UITableView, bottom txt: String = "") {
//            
//            let emptyView: EmptyBackgroundView = EmptyBackgroundView.fromNib()
//            
//            //let emptyView =
//              //  UINib(nibName: "EmptyBackgroundView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! EmptyBackgroundView //UIView
//            emptyView.frame = tblView.bounds
//            emptyView.descLbl.text = txt
//            tblView.backgroundView = emptyView
//            tblView.backgroundView?.isHidden = true
//            
//        }
    
    public func setAttibuttedString(font: UIFont, font2: UIFont, color : UIColor, Color2: UIColor, str1 : String, str2: String) -> NSMutableAttributedString {
        
        let attrs1 = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor :color]
        let attrs2 = [NSAttributedString.Key.font : font2, NSAttributedString.Key.foregroundColor : Color2]
        let attStr1 = NSMutableAttributedString(string:"\(str1)", attributes:attrs1 as [NSAttributedString.Key : Any])
        let attStr2 = NSMutableAttributedString(string:"\(str2)", attributes:attrs2 as [NSAttributedString.Key : Any])
        attStr1.append(attStr2)
        return attStr1
    }
    
}
