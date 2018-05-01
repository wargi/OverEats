//
//  LocationTableUtility.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 25..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

enum CellType: String{
    case select = "select"
    case search = "search"
    case detail = "detail"
}

struct LocationTableUtility {
    init(cellType: String, title: String) {
        self.cellType = cellType
        self.title = title
    }
    
    let cellType: String! //
    let title: String! // 주소 이름
    var firstValue: String? //
    var secondValue: String? //
    var iconName: String?
    var buttonname: String?
}
