//
//  NoticeData.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 17..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct Notice: Decodable {
    let id: Int
    let order: Int
    let title: String
    let subTitle: String
    let content: String
    let imageUrl: String?
    let imageBannerUrl: String?
    let restaurant: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case order
        case title
        case subTitle = "sub_title"
        case content
        case imageUrl = "img_banner"
        case imageBannerUrl = "img_banner_url"
        case restaurant
    }
}
