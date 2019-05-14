//
//  LocationData.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 24..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct LocationDatas: Decodable {
    
    let result: [LocationData]
    
    private enum CodingKeys: String, CodingKey {
        case result
    }
    
}

struct LocationData: Decodable {
    
    let name : String?
    let vicinity : String?
    let addressComponents: [LongName]
    var formattedAddress: String
    var geometry: Geometry
    
    private enum CodingKeys: String, CodingKey {
        
        case name
        case vicinity
        case addressComponents = "address_components"
        case formattedAddress = "formatted_address"
        case geometry
    }
    
}

struct LongName: Decodable {
    
    let longName : String
    let shortName : String
    
    private enum CodingKeys: String, CodingKey {
        
        case longName = "long_name"
        case shortName = "short_name"
    }
}

struct Geometry: Decodable {
    var lat: Double?
    var lng: Double?
    var location: Location?
    
    private enum CodingKeys: String, CodingKey {
        case lat
        case lng
        case location
    }
}

struct Location: Decodable {
    let lat: Double
    let lng: Double
    
    private enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
