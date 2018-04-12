//
//  GetService.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Alamofire

protocol GetServiceType {
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
                        let restaurantList = try value.decode(Lestaurants.self)
                        completion(.success(restaurantList))
                    } catch {
                        completion(.error(error))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
            })
    }
}
