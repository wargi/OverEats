//
//  ImageService.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 16..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImageUsingCacheWithUrl(urlString : String, completion: @escaping (_ success: Bool)->() ){
        self.image = nil;
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject)  as? UIImage {
            self.image = cachedImage;
            completion(true)
        }
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                completion(false)
            }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                    completion(true)
                }
            }
        }).resume()
    }
}
