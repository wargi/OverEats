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
    func getRestaurantList(completion: @escaping (Result<Lestaurants>) -> ())
}

struct GetService: GetServiceType {
    func getRestaurantList(completion: @escaping (Result<Lestaurants>) -> ()) {
        Alamofire
            .request(API.getRestaurantList(latitude: 37.494760, longitude: 127.051284, pageSize: 20).urlString)
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
}
