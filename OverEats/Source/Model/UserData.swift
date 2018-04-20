//
//  UserData.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 6..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    let token: String // 토큰 값
    let user: [User] // 유저 데이터
    
    private enum CodingKeys: String, CodingKey {
        case user
        case token
    }
}

struct User: Decodable {
    let pk: String
    let username: String // 유저 아이디
    let email: String // 이름
    let firstName: String // 이름
    let lastName: String // 성
    let phoneNumber: String // 폰 번호
    let imgProfile: String // 이미지 URL
    
    private enum CodingKeys: String, CodingKey {
        case pk
        case username
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case imgProfile = "img_profile"
    }
}

struct CreditCard {
    let creditCard: String? // 결제할 카드
}

struct Favorites {
    let favoriteRestaurant: [String] //즐겨 찾는 매장의 고유번호를 저장
}
