//
//  NonImageMenuList.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 8..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class NonImageMenuListCell: UITableViewCell {
    
    // MenuList TavleView Cell의 NonImageMenuListCell 변수
    @IBOutlet private weak var name : UILabel! // 메뉴 명
    @IBOutlet private weak var menuDescription : UILabel! // 메뉴 설명
    @IBOutlet private weak var price : UILabel! // 메뉴 가격
    
    // 메뉴 명 삽입
    var setName: String? {
        didSet {
            if let setName = setName {
                name.text = setName
            }
        }
    }
    
    // 메뉴 설명 삽입
    var setDescription: String? {
        didSet {
            if let foodDescription = setDescription {
                menuDescription.text = foodDescription
            } else {
                menuDescription.text = nil
            }
        }
    }
    
    // 메뉴 가격 삽입
    var setPrice: String? {
        didSet {
            if let setPrice = setPrice {
                price.text = setPrice
            }
        }
    }
    
}
