//
//  DumpOrderData.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 26..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct DumpOrderData {
    var delivery: DumpDelivery
    var payment: DumpPayment
    var order: DumpInfomation
    var comment: String?
}

struct DumpDelivery {
    var lat: Double
    var lng: Double
    var address: String
    var detailAddress: String?
    var comment: String?
    var orderTime: String?
}

struct DumpPayment {
    var method: String
    var cardNumber: String
}

struct DumpInfomation {
    var restaurantID: String
    var orderMenu: [DumpOrderMenu]
}

struct DumpOrderMenu {
    var id: String
    var count: Int
    var comment: String
}
