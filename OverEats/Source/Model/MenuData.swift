//
//  MenuData.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 16..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct Section: Decodable {
    let id: String
    let name: String
    let menuList: [Menu]
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "title"
        case menuList = "items"
    }
    
    struct Menu: Decodable {
        let id: String
        let name: String
        let price: Int
        let description: String
        let imageURL: String
        
        private enum CodingKeys: String, CodingKey {
            case id = "uuid"
            case price
            case name = "title"
            case description
            case imageURL = "image_url"
//            case alcoholic_items
//            case created_at
//            case restaurant
//            case section
        }
    }
    
}


