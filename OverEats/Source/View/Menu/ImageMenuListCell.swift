//
//  ImageMenuListCell.swift
//  OverEats
//
//  Created by 박상욱 on 2018. 4. 8..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class ImageMenuListCell: UITableViewCell {

    // MenuList TavleView Cell의 ImageMenuListCell 변수
    @IBOutlet private weak var name : UILabel! // 메뉴명
    @IBOutlet private weak var menuDescription : UILabel! // 메뉴설명
    @IBOutlet private weak var price : UILabel! // 메뉴 가격
    @IBOutlet private weak var ImageView : UIImageView! // 메뉴 이미지
    
    // 이미지 삽입
    var setImage: UIImage? {
        didSet {
            if let image = setImage {
                ImageView.image = image
            }
        }
    }
    
    // 메뉴 명 삽입
    var setName: String? {
        didSet {
            if let setName = setName {
                name.text = setName
            }
        }
    }
    
    // 메뉴 명 삽입
    var setDescription: String? {
        didSet {
            if let foodDescription = setDescription {
                menuDescription.text = foodDescription
            }
        }
    }
    
    // 가격 삽입
    var setPrice: String? {
        didSet {
            if let setPrice = setPrice {
                price.text = setPrice
            }
        }
    }
    
}
