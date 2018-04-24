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
    static func singUp(singUpData: [String : Any], imageData: Data? ,completion: @escaping (Result<UserData>) -> ())
    static func signIn(email: String, password: String, completion: @escaping (Result<UserData>) -> ())
}

struct PostService: PostServiceType {
    static func singUp(singUpData: [String : Any], imageData: Data?, completion: @escaping (Result<UserData>) -> ()) {
        
        guard let url = URL(string: API.postSignUp.urlString),
            let urlRequest = try? URLRequest(url: url, method: .post)
            else { return completion(.error(ServiceError.invalidURL))
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in singUpData {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key as String)
            }
            if let data = imageData {
                multipartFormData.append(data, withName: "img_profile", fileName: "profileImage.jpeg", mimeType: "image/jpeg")
            }
        }, with: urlRequest) { (encodingResult) in
            switch encodingResult {
            case .success(request: let upload, _, _):
                upload.responseData { (response) in
                    switch response.result {
                    case .success(let value):
                        do {
                            let userData = try value.decode(UserData.self)
                            completion(.success(userData))
                        } catch {
                            completion(.error(error))
                        }
                    case .failure(let error):
                        completion(.error(error))
                    }
                }
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
    static func signIn(email: String, password: String, completion: @escaping (Result<UserData>) -> ()) {
        guard !email.isEmpty else { return completion(.error(AuthError.invalidUsername)) }
        guard !password.isEmpty else { return completion(.error(AuthError.invalidPassword)) }
        
        let params: Parameters = [
            "username": email,
            "password": password
        ]
        
        Alamofire.request(API.postLogin.urlString, method: .post, parameters: params)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let userData = try value.decode(UserData.self)
                        completion(.success(userData))
                    } catch {
                        completion(.error(error))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
        }
    }
    
    static func locationIn(text: String, completion: @escaping (Result<LocationData>) -> ()) {
        
        let params: Parameters = [
            "search_text": text,
            "language": "ko"
        ]
        
        Alamofire.request(API.location.urlString, method: .post, parameters: params)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let userData = try value.decode(LocationData.self)
                        completion(.success(userData))
                    } catch {
                        completion(.error(error))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
        }
    }
    
}
