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
    static func setOrder(orderData: [String:Any], completion: @escaping (Result<OrderData>) -> ())
    static func locationIn(text: String, completion: @escaping (Result<LocationDatas>) -> ())
    static func userLocation(latitude: Double, longitude: Double, completion: @escaping (Result<LocationDatas>) -> ())
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
    

    static func locationIn(text: String, completion: @escaping (Result<LocationDatas>) -> ()) {
        
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
                        let locationData = try value.decode(LocationDatas.self)
                        completion(.success(locationData))
                    } catch {
                        completion(.error(error))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
        }
    }
    
    static func userLocation(latitude: Double, longitude: Double, completion: @escaping (Result<LocationDatas>) -> ()) {
        
        let params: Parameters = [
            "latitude": latitude,
            "longitude": longitude
        ]
        
        Alamofire.request(API.userLocation.urlString, method: .post, parameters: params)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let locationDatas = try value.decode(LocationDatas.self)
                        completion(.success(locationDatas))
                    } catch {
                        completion(.error(error))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
        }
    }


    static func setOrder(orderData: [String:Any], completion: @escaping (Result<OrderData>) -> ()) {
        guard let url = URL(string: API.postCart.urlString),
            let urlRequest = try? URLRequest(url: url, method: .post, headers: ["Authorization": "token a0224ede337f2245a0b80d0157872de58284b4e9"])

            else { return completion(.error(ServiceError.invalidURL))
        }
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in orderData {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key as String)
            }
        }, with: urlRequest) { (encodingResult) in
            switch encodingResult {
            case .success(request: let upload, _, _):
                upload.responseData { (response) in
                    switch response.result {
                    case .success(let value):
                        do {
                            let orderData = try value.decode(OrderData.self)
                            completion(.success(orderData))
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
}
