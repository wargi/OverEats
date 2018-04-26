//
//  CartManager.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 24..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

final class CartManager {
    private init() {}
    
    static var restaurantId: String?
    static var restaurantName: String?
    static var restaurantURL: String?
    static var deliveryTime: EtaRange?
    static var cartList: [CartMenu] = []
    static var dumpDelivery = DumpDelivery(lat: 37.524124, lng: 127.022883, address: "서울특별시 신사동",
    detailAddress: "현대고등학교 앞 사거리\n밖에서 픽업", comment: "빨간옷 입고 서있는 아저씨", orderTime: nil)
}
