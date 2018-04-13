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
            .request(API.Get.restaurantList)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let restaurantData = try value.decode(Lestaurants.self)
                        for lestaurant in restaurantData.lestaurants{
                            // 함수 추가 예정
                        }
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
