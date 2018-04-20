//
//  PostService.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 20..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

import Alamofire

protocol PostServiceType {
    static func singUp(userInfo: [String: Any], imageData: Data? ,completion: @escaping (Result<UserData>) -> ())
}

struct PostService: PostServiceType {
    static func singUp(userInfo: [String: Any], imageData: Data?, completion: @escaping (Result<UserData>) -> ()) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in userInfo {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key as String)
            }
            if let imageData = imageData {
                multipartFormData.append(imageData, withName: "img_profile", fileName: "profileImage.jpeg", mimeType: "image/jpeg")
            }
        },
            to: API.postSignUp.urlString,
            method: .post,
            encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .success(request: let upload, _, _):
                    upload.responseData { (response) in
                        switch response.result {
                        case .success(let value):
                            do {
                                print("------------ssss----------", value)
                                let userData = try value.decode(UserData.self)
                                completion(.success(userData))
                            } catch {
                                print("------------ffff----------")
                                completion(.error(error))
                            }
                        case .failure(let error):
                            completion(.error(error))
                        }
                    }
                case .failure(let error):
                    completion(.error(error))
                }
        })
    }
    

}
