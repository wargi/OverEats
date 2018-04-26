//
//  GetService.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Alamofire

/// GET 네트워크 프로토콜
protocol GetServiceType {
    // get service에 대한 개별 프로토콜 함수
    static func getRestaurantList(latitude: Float, longitude: Float, pageSize: Int, searchText: String?, completion: @escaping (Result<Lestaurants>) -> ())
    static func getNoticeList(completion: @escaping (Result<[Notice]>) -> ())
    static func getMenuList(id: String, completion: @escaping (Result<[Section]>) -> ())
}

struct GetService: GetServiceType {
    
    static func getRestaurantList(latitude: Float, longitude: Float, pageSize: Int, searchText: String?, completion: @escaping (Result<Lestaurants>) -> ()) {
        Alamofire
            .request(API.getRestaurantList(latitude: latitude, longitude: longitude, pageSize: pageSize, searchText: searchText).urlString)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let restaurantData = try value.decode(Lestaurants.self)
                        completion(.success(restaurantData))
                    } catch {
                        completion(.error(error))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
            })
    }
    
    static func getNoticeList(completion: @escaping (Result<[Notice]>) -> ()) {
        Alamofire
            .request(API.getNotice.urlString)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let noticetData = try value.decode([Notice].self)
                        completion(.success(noticetData))
                    } catch {
                        completion(.error(error))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
            })
    }

    static func getMenuList(id: String, completion: @escaping (Result<[Section]>) -> ()) {
        Alamofire
            .request(API.getMenuList(restaurantId: id).urlString)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let menuListData = try data.decode([Section].self)
                        completion(.success(menuListData))
                    } catch {
                        completion(.error(error))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
            }
    }
    
    static func tagList(completion: @escaping (Result<Tags>) -> ()) {
        Alamofire
            .request(API.tagList(pageSize: 40).urlString)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let tagData = try value.decode(Tags.self)
                        completion(.success(tagData))
                    } catch {
                        completion(.error(error))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
            })
    }
}
