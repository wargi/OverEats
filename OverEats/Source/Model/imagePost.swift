//
//  Post.swift
//  OverEats
//
//  Created by 박상욱 on 2018. 4. 8..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

struct imagePost {
    
    
    static func imageDownload(stringURL: String) -> UIImage? {
        var img: UIImage?
        let apiURL = URL(string: stringURL)!
        let task = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, 200..<400 ~= response.statusCode else {
                print("StatusCode is not valid")
                return
            }
            guard let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data) as? UIImage
                else {
                    img = nil
                    return
            }
            img = jsonObject
        }
        
        task.resume()
        return img
    }

}
