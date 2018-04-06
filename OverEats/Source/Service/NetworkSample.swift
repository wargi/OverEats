//
//  MainNetwork.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 3..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct MainGet {
    
    static func getNotice(completionHandler: @escaping ([Notice]) -> Void) {
        var notices = [Notice]()
        
        // 1번 데이터
        let notice1 = Notice(id: "1", title: "함께하면 더욱 맛있다!", subTitle: "친구 초대하고 7,000원 할인받으세요.", imageURL: "https://picsum.photos/800/500?random")
        notices.append(notice1)
        
        // 2번 데이터
        let notice2 = Notice(id: "2", title: "", subTitle: "드디어! 오버이츠가 마포, 서대문 맛집을 배달합니다!", imageURL: "https://picsum.photos/800/500?random")
        notices.append(notice2)
        
        // 3번 데이터
        let notice3 = Notice(id: "3", title: "똑똑한 오버이츠 이용 꿀팁", subTitle: "탭하고 프로모션 코드, 상세주소 입력방법을 확인하세요.", imageURL: "https://picsum.photos/800/500?random")
        notices.append(notice3)
        
        // 4번 데이터
        let notice4 = Notice(id: "4", title: "", subTitle: "오버이츠만의  기간한정 더블 혜택, 지금 주문하세요!", imageURL: "https://picsum.photos/800/500?random")
        notices.append(notice4)
        
        completionHandler(notices)
    }
    
    
    static func getRestaurantList(completionHandler: @escaping ([Restaurant]) -> Void) {
        var restaurants = [Restaurant]()
        
        
        let category1:[Category] = [
            Category(id: "1", name: "일식", imageURL: "https://picsum.photos/500/500?random")
        ]
        let restaurant1 = Restaurant(id: "1", name: "이치라쿠", isOpen: true, address: "서초구 서초동 101-1", description: "테이스티로드에 소개된 라멘 맛집, 가로수길 피에스타 선정 맛집", score: 4.2, imageURL: "https://picsum.photos/800/500?random", minDeliveryTime: 10, maxDeliveryTime: 20, menuList: nil, category: category1)
        restaurants.append(restaurant1)
        
        let category2:[Category] = [
            Category(id: "2", name: "셀러드", imageURL: "https://picsum.photos/500/500?random"),
            Category(id: "3", name: "웰빙", imageURL: "https://picsum.photos/500/500?random"),
            Category(id: "3", name: "비건", imageURL: "https://picsum.photos/500/500?random")
        ]
        let restaurant2 = Restaurant(id: "2", name: "알로하 포케 학동점", isOpen: true, address: "서초구 서초동 101-1", description: "", score: 0, imageURL: "https://picsum.photos/800/500?random", minDeliveryTime: 10, maxDeliveryTime: 20, menuList: nil, category: category2)
        restaurants.append(restaurant2)



//        let tag3 = ["베이커리", "디저트", "커피", "차"]
//        let restaurant3 = Restaurant(id: 3, name: "컨버세이션", tag: tag3, score: 4.0, time: 20,account: "그림책에만 있는줄 알았던 엄청난 비주얼의 케이크", imageURL: "https://picsum.photos/800/500?random")
//        restaurants.append(restaurant3)
//
//        let tag4 = ["일식"]
//        let restaurant4 = Restaurant(id: 4, name: "김태완 스시 논현점", tag: tag4, score: 0, time: 35,account: "이름을 걸고 만드는 신선한 사시미와 스시 전문점", imageURL: "https://picsum.photos/800/500?random")
//        restaurants.append(restaurant4)
//
//        let tag5 = ["일식"]
//        let restaurant5 = Restaurant(id: 5, name: "테루", tag: tag5, score: 0, time: 30,account: "", imageURL: "https://picsum.photos/800/500?random")
//        restaurants.append(restaurant5)
//
//        let tag6 = ["양식", "이탈리안"]
//        let restaurant6 = Restaurant(id: 6, name: "셰프런", tag: tag6, score: 4.5, time: 20,account: "Top 스타셰프의 요리를 집에서 즐기세요!", imageURL: "https://picsum.photos/800/500?random")
//        restaurants.append(restaurant6)
        
        completionHandler(restaurants)
    }
}
