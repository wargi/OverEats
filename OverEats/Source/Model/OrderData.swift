//
//  OrderData.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 22..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct OrderData: Decodable {
    var delivery: Delivery
    var payment: Payment
    var order: Infomation
    var comment: String?
    
    enum CodingKeys: String, CodingKey {
        case delivery
        case payment
        case order
        case comment
    }
}

struct Delivery: Decodable {
    var lat: Double
    var lng: Double
    var address: String
    var detailAddress: String?
    var comment: String?
    var orderTime: String?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
        case address
        case detailAddress = "address_detail"
        case comment
        case orderTime = "data_time"
    }
}

struct Payment: Decodable {
    var method: String
    var cardNumber: String
    
    enum CodingKeys: String, CodingKey {
        case method
        case cardNumber = "num"
    }
}

struct Infomation: Decodable {
    var restaurantID: String
    var orderMenu: [OrderMenu]
    
    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant"
        case orderMenu = "items"
    }
}

struct OrderMenu: Decodable {
    var id: String
    var count: Int
    var comment: String
    
    enum CodingKeys: String, CodingKey {
        case id = "item"
        case count = "cnt"
        case comment
    }
}
