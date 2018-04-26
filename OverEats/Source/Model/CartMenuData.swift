//
//  CartMenuData.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 23..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct CartMenu {
    let id: String
    let name: String
    let price: Int
    let description: String
    let imageURL: String
    var totalPrice: Int
    var count: Int
    var comment: String
}
