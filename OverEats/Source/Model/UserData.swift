//
//  UserData.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 6..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct User {
    let user: [User] // 유저 데이터
    let token: String! // 토큰 값
}

struct UserDetail {
    let id: String!
    let userName: String! // 유저 아이디
    let firstName: String! // 이름
    let lastName: String! // 성
    let phoneNumber: String! // 폰 번호
    let imageURL: String? // 이미지 URL
}

struct CreditCard {
    let creditCard: String? // 결제할 카드
}

struct Favorites {
    let favoriteRestaurant: [String] //즐겨 찾는 매장의 고유번호를 저장
}
