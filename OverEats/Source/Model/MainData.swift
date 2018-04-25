//
//  MainData.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct Lestaurants: Decodable {
    let count: Int
    let restaurants: [Lestaurant]
    private enum CodingKeys: String, CodingKey {
        case count
        case restaurants = "restaurants"
    }
}

struct Lestaurant: Decodable {
    let id: String // 매장 고유 번호
    let name: String // 매장 명
    let status: String // 오픈 상태
    let visible: Bool // 리스트 공개 여부
    let scheduleOrder: Bool // 예약 주문 가능 여부
    let rating: Float // 매장 오픈 여부
    let ratingCount: Int
    let address: Address // 매장 주소
    let position: Position // 매장 설명
    let etaRange: EtaRange // 매장 점수
    let tags: [Tag] // 테그 리스트
    let logo: String
    let logos: [Logo] // 매장 이미지
    let openTime: [OpenTime] // 매장 오픈 시간
    let contact: [String]?
    let endorsement: Endorsement?
    let isLike: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "title"
        case status = "r_status"
        case visible = "r_visible"
        case scheduleOrder = "schedule_order"
        case rating
        case ratingCount = "rating_count"
        case address
        case position
        case etaRange = "eta_range"
        case tags
        case logo
        case logos
        case openTime = "open_time"
        case contact
        case endorsement
        case isLike = "is_like"
    }
}

struct Address: Decodable {
    let mainAddress: String
    let aptSuite: String
    let city: String
    let country: String
    let postalCode: String
    let region: String
    let formattedAddress: String
    
    private enum CodingKeys: String, CodingKey {
        case mainAddress = "address1"
        case aptSuite = "apt_suite"
        case city
        case country
        case postalCode = "postal_code"
        case region
        case formattedAddress = "formatted_address"
    }
}

struct Position: Decodable {
    let latitude: Float
    let longtitude: Float?
    let distance: Int
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longtitude
        case distance
    }
}

struct EtaRange: Decodable {
    let min: Int
    let max: Int
    
    private enum CodingKeys: String, CodingKey {
        case min
        case max
        
    }
}

struct Tags: Decodable {
    let count: Int
    let next: String
    let categories: [Tag]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case next
        case categories
    }
}

struct Tag: Decodable {
    let id: String
    let name: String
    let logoUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case logoUrl = "logo_url"
    }
}

struct Logo: Decodable {
    let id: Int
    let url: String
    let width: Int
    let height: Int
    let isDefault: Bool
    let restaurant: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case url
        case width
        case height
        case isDefault = "is_default"
        case restaurant
    }
}

struct OpenTime: Decodable {
    let dayOfWeek: String
    let dayOfWeekDisplay: String?
    let startTime: Int
    let endTime: Int
    
    private enum CodingKeys: String, CodingKey {
        case dayOfWeek = "day_of_week"
        case dayOfWeekDisplay = "day_of_week_display"
        case startTime = "start_time"
        case endTime = "end_time"
    }
}


struct Endorsement: Decodable {
    let text: String
    
    private enum CodingKeys: String, CodingKey {
        case text
    }
}


