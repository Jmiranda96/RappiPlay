//
//  UrlImageView.swift
//  MirandaMall
//
//  Created by Jorge Miranda on 7/09/20.
//  Copyright © 2020 Jorge Miranda. All rights reserved.
//

import UIKit
import Alamofire

class UrlImageView: UIImageView {
    

    let imageCache = NSCache<NSString, UIImage>()
    var imageUrlString = String()
    var usingPlaceholder = false
    
    /// load images from url and save in temporal cache to show in reusable views
    func loadImageFromUrl(_ urlString: String){
        imageUrlString = urlString
        
        image = nil
        
        // check if image already exist in cache
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        // download of image from url
        AF.download(urlString).responseData { response in
            
            guard response.error == nil else {
                self.usingPlaceholder = true
                self.image = UIImage(named: "Image-Not-Available")
                return
            }
            
            if let data = response.value {
                
                // data converted into UIImage
                let imageToCache = UIImage(data: data)
                
                
                guard imageToCache != nil else {
                    // if image not found, placeholder placed
                    self.usingPlaceholder = true
                    self.image = UIImage(named: "Image-Not-Available")
                    return
                }
                self.usingPlaceholder = false
                DispatchQueue.main.async {
                    //checking of right image and display
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                }
                // image saved in cache
                self.imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            }
        }
    }
}
