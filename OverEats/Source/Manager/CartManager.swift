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
    
}
