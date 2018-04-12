//
//  MainData.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct Lestaurants: Decodable {
    let count: Int!
    let lestaurants: [Lestaurant]!
}


struct Lestaurant: Decodable {
    let id: String! // 매장 고유 번호
    let name: String! // 매장 명
    let status: String! // 오픈 상태
    let visible: String! // 리스트 공개 여부
    let scheduleOrder: Bool! // 예약 주문 가능 여부
    let rating: String! // 매장 오픈 여부
    let address: [Address]! // 매장 주소
    let position: [Position]! // 매장 설명
    let etaRange: [EtaRange]! // 매장 점수
    let tags: [Tag]! // 테그 리스트
    let logo: String!
    let logos: [Logo]! // 매장 이미지
    let openTime: [OpenTime]! // 매장 오픈 시간
    let contact: [String]?
    var imageData: Data? // 이미지
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "title"
        case status = "r_status"
        case visible = "r_visible"
        case scheduleOrder = "schedule_order"
        case rating
        case address
        case position
        case etaRange = "eta_range"
        case tags
        case logo
        case logos
        case openTime = "open_time"
        case contact
        case imageData
    }
}

struct Address: Decodable {
    let address: String!
    let aptSuite: String!
    let city: String!
    let country: String!
    let postalCode: String!
    let region: String!
    let formattedAddress: String!
    
    private enum CodingKeys: String, CodingKey {
        case address = "address1"
        case aptSuite = "apt_suite"
        case city
        case country
        case postalCode = "postal_code"
        case region
        case formattedAddress = "formatted_address"
    }
}

struct Position: Decodable {
    let latitude: Double!
    let longtitude: Double?
    let distance: Int!
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longtitude
        case distance
    }
}

struct EtaRange: Decodable {
    let min: Int!
    let max: Int!
    
    private enum CodingKeys: String, CodingKey {
        case min
        case max
        
    }
}

struct Tag: Decodable {
    let id: String!
    let name: String!
    let logoUrl: String!
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case logoUrl = "logo_url"
    }
}

struct Logo: Decodable {
    let id: Int!
    let url: String!
    let width: Int!
    let height: Int!
    let isDefault: Bool!
    let restaurant: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "address1"
        case url = "apt_suite"
        case width = "city"
        case height = "country"
        case isDefault = "is_default"
        case restaurant = "region"
    }
}

struct OpenTime: Decodable {
    let dayOfWeek: String!
    let dayOfWeekDisplay: String?
    let startTime: Int!
    let endTime: Int!
    
    private enum CodingKeys: String, CodingKey {
        case dayOfWeek = "day_of_week"
        case dayOfWeekDisplay = "day_of_week_display"
        case startTime = "start_time"
        case endTime = "end_time"
    }
}
