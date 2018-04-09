//
//  SignUpCodable.swift
//  OverEats
//
//  Created by ENDERS on 2018. 4. 9..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct Repositories: Decodable {
    let username: String
    let password: String
    let firstname: String
    let lastname: String
    let phonenumber: String
    let imgprofile: String?
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case firstname = "first_name"
        case lastname = "last_name"
        case phonenumber = "phone_number"
        case imgprofile = "img_profile"
    }
    
}

