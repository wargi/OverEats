//
//  MainNetwork.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 3..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

// 더미 데이터 - 향후 삭제할 내용
struct MainGet {
    
    static func getNotice(completionHandler: @escaping ([Notice]) -> Void) {
        var notices = [Notice]()
        
        let tempImageURL = "https://duyt4h9nfnj50.cloudfront.net/resized/9c6493c25086978e677d38ad416cbbb1-w550-bb.jpg"
        
        // 1번 데이터
        let notice1 = Notice(id: "1", title: "함께하면 더욱 맛있다!", subTitle: "친구 초대하고 7,000원 할인받으세요.", imageURL: tempImageURL)
        notices.append(notice1)
        
        // 2번 데이터
        let notice2 = Notice(id: "2", title: "", subTitle: "드디어! 오버이츠가 마포, 서대문 맛집을 배달합니다!", imageURL: tempImageURL)
        notices.append(notice2)
        
        // 3번 데이터
        let notice3 = Notice(id: "3", title: "똑똑한 오버이츠 이용 꿀팁", subTitle: "탭하고 프로모션 코드, 상세주소 입력방법을 확인하세요.", imageURL: tempImageURL)
        notices.append(notice3)
        
        // 4번 데이터
        let notice4 = Notice(id: "4", title: "", subTitle: "오버이츠만의  기간한정 더블 혜택, 지금 주문하세요!", imageURL: tempImageURL)
        notices.append(notice4)
        
        completionHandler(notices)
    }
    
    
    static func getRestaurantList(completionHandler: @escaping ([Restaurant]) -> Void) {
        var restaurants = [Restaurant]()
        
        let tempImageURL = "https://duyt4h9nfnj50.cloudfront.net/resized/9c6493c25086978e677d38ad416cbbb1-w550-bb.jpg"
        
        
        let category1:[Category] = [
            Category(id: "1", name: "일식", imageURL: "https://picsum.photos/500/500?random")
        ]

        let menuListTemp:[Menu] = [
            Menu(id: "1", price: 7000, foodName: "비빔밥", foodImage: nil, foodDescription: "여러가지 채소가 들어가는 비빔밥여러가지 채소가 들어가는 비빔밥여러가지 채소가 들어가는 비빔밥여러가지 채소가 들어가는 비빔밥여러가지 채소가 들어가는 비빔밥여러가지 채소가 들어가는 비빔밥여러가지 채소가 들어가는 비빔밥"),
            Menu(id: "2", price: 14000, foodName: "매운탕", foodImage: nil, foodDescription: "얼큰한 매운탕"),
            Menu(id: "3", price: 28000, foodName: "아구찜", foodImage: nil, foodDescription: "푸짐한 아구와 콩나물"),
            Menu(id: "4", price: 56000, foodName: "자연산 회", foodImage: nil, foodDescription: "자연산 회"),
            Menu(id: "5", price: 112000, foodName: "2인 코스", foodImage: nil, foodDescription: nil),
            ]
        
        let restaurant1 = Restaurant(id: "1", name: "이치라쿠", isOpen: true, address: "서초구 서초동 101-1", description: "테이스티로드에 소개된 라멘 맛집, 가로수길 피에스타 선정 맛집", score: 4.2, imageURL: "https://picsum.photos/800/500?random", imageData: nil, minDeliveryTime: 10, maxDeliveryTime: 20, menuList: menuListTemp, category: category1)
        
        restaurants.append(restaurant1)
        
        let category2:[Category] = [
            Category(id: "2", name: "셀러드", imageURL: "https://picsum.photos/500/500?random"),
            Category(id: "3", name: "웰빙", imageURL: "https://picsum.photos/500/500?random"),
            Category(id: "4", name: "비건", imageURL: "https://picsum.photos/500/500?random")
        ]
        
        let restaurant2 = Restaurant(id: "2", name: "알로하 포케 학동점", isOpen: true, address: "서초구 서초동 101-1", description: "", score: 0, imageURL: tempImageURL, imageData: nil, minDeliveryTime: 10, maxDeliveryTime: 20, menuList: nil, category: category2)
        
        restaurants.append(restaurant2)
        
        
        let category3:[Category] = [
            Category(id: "5", name: "베이커리", imageURL: "https://picsum.photos/500/500?random"),
            Category(id: "6", name: "디저트", imageURL: "https://picsum.photos/500/500?random"),
            Category(id: "7", name: "커피", imageURL: "https://picsum.photos/500/500?random"),
            Category(id: "8", name: "차", imageURL: "https://picsum.photos/500/500?random")
        ]

        let restaurant3 = Restaurant(id: "3", name: "컨버세이션", isOpen: true, address: "서초구 서초동 101-1", description: "그림책에만 있는줄 알았던 엄청난 비주얼의 케이크", score: 4.0, imageURL: tempImageURL, imageData: nil, minDeliveryTime: 10, maxDeliveryTime: 20, menuList: nil, category: category3)

        restaurants.append(restaurant3)
        
        
        let category4:[Category] = [
            Category(id: "1", name: "일식", imageURL: "https://picsum.photos/500/500?random")
        ]

        let restaurant4 = Restaurant(id: "4", name: "김태완 스시 논현점", isOpen: false, address: "서초구 서초동 101-1", description: "이름을 걸고 만드는 신선한 사시미와 스시 전문점", score: 0, imageURL: tempImageURL, imageData: nil, minDeliveryTime: 30, maxDeliveryTime: 40, menuList: nil, category: category4)

        restaurants.append(restaurant4)
        
        
        let category5:[Category] = [
            Category(id: "1", name: "일식", imageURL: "https://picsum.photos/500/500?random")
        ]
        let restaurant5 = Restaurant(id: "5", name: "테루", isOpen: true, address: "서초구 서초동 101-1", description: "", score: 0, imageURL: tempImageURL, imageData: nil, minDeliveryTime: 30, maxDeliveryTime: 40, menuList: nil, category: category5)
        
        restaurants.append(restaurant5)
        
        
        let category6:[Category] = [
            Category(id: "9", name: "양식", imageURL: "https://picsum.photos/500/500?random"),
            Category(id: "10", name: "이탈리안", imageURL: "https://picsum.photos/500/500?random")
        ]
        let restaurant6 = Restaurant(id: "6", name: "셰프런", isOpen: false, address: "서초구 서초동 101-1", description: "Top 스타셰프의 요리를 집에서 즐기세요!", score: 4.0, imageURL: tempImageURL, imageData: nil, minDeliveryTime: 10, maxDeliveryTime: 20, menuList: nil, category: category6)

        restaurants.append(restaurant6)
        
        completionHandler(restaurants)
    }
}
