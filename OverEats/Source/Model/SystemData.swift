//
//  SystemData.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 6..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct Notice {
    let id: String! // 공지 고유 번호
    let title: String? // 대제목
    let subTitle: String? // 소제목
    let imageURL: String! // 이미지 URL
}

struct Restaurant {
    let id: String! // 매장 고유 번호
    let name: String // 매장 명
    let isOpen: Bool! // 매장 오픈 여부
    let address: String! // 매장 주소
    let description: String? // 매장 설명
    let score: Float? // 매장 점수
    let imageURL: String! // 매장 표시 이미지
    var imageData: Data?
    let minDeliveryTime: Int! // 매장 최소 조리시간
    let maxDeliveryTime: Int! // 매장 최대 조리시간
    let menuList: [Menu]? // 메뉴 목록
    let category: [Category]? // 식당의 유형 예)카페, 한식
}

struct Menu {
    let id: String! // 음식 고유 번호
    let price: Int! // 음식 가격
    let foodName: String! // 음식 이름
    let foodImage: String? // 음식 사진
    let foodDescription: String? // 음식 설명
}

struct Category {
    let id: String! // 카테고리 고유 번호
    let name: String! // 카테고리명
    let imageURL: String? // 카테고리 이미지
}
