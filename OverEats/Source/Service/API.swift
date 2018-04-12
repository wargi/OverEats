//
//  API.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

enum API {
    static let baseURL = "https://www.overeats.kr/api/"
    
    enum Get {
        static let restaurantList = API.baseURL + "restaurant/?lat=37.494760&lng=127.051284&radius=5000"
    }
}
