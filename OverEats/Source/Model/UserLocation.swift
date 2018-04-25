
//
//  LocationData.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 24..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct UserLocation: Decodable {
    
    let result: [AddressData]
    
    private enum CodingKeys: String, CodingKey {
        case result
    }
    
}

struct AddressData: Decodable {
    
    let addressComponents: [LongName]
    let formattedAddress: String
    let geometry: MapData
    
    private enum CodingKeys: String, CodingKey {
        
        case addressComponents = "address_components"
        case formattedAddress = "formatted_address"
        case geometry
    }
}

struct MapData: Decodable {
    let location: Geometry
    
    private enum CodingKeys: String, CodingKey {
        case location
    }
}


