//
//  LocationTableUtility.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 25..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

enum CellType{
    case select
    case search
    case delivery
    case pickUp
}

struct LocationTableUtility {
    init(cellType: CellType, title: String) {
        self.cellType = cellType
        self.title = title
    }
    
    var cellType: CellType! // 셀 타입
    var title: String! // 셀 타이틀
    var cellData: LocationData? // 셀 데이터
    var iconName: String? // 셀 아이콘 네임
    var cellContent: String? // 셀 내용
}
