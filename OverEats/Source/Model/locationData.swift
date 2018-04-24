//
//  locationData.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 23..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct locationData: Decodable {
   
    let result: detailData
    let formattedAddress: String
    
    private enum CodingKeys: String, CodingKey {
        case result
        case formattedAddress = "formatted_address"
    }
}
struct detailData: Decodable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
}
