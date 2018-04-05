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
        var notice = [Notice]()
        
        // 1번 데이터
        let notice1 = Notice(id: 1, title: "함께하면 더욱 맛있다!", subTitle: "친구 초대하고 7,000원 할인받으세요.", imageURL: "https://picsum.photos/800/500")
        notice.append(notice1)
        
        // 2번 데이터
        let notice2 = Notice(id: 2, title: "", subTitle: "드디어! 오버이츠가 마포, 서대문 맛집을 배달합니다!", imageURL: "https://picsum.photos/800/500")
        notice.append(notice2)
        
        // 3번 데이터
        let notice3 = Notice(id: 3, title: "똑똑한 오버이츠 이용 꿀팁", subTitle: "탭하고 프로모션 코드, 상세주소 입력방법을 확인하세요.", imageURL: "https://picsum.photos/800/500")
        notice.append(notice3)
        
        // 4번 데이터
        let notice4 = Notice(id: 4, title: "", subTitle: "오버이츠만의  기간한정 더블 혜택, 지금 주문하세요!", imageURL: "https://picsum.photos/800/500")
        notice.append(notice4)
        
        completionHandler(notice)
    }
    
}
