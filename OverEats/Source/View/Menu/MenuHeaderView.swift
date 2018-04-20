//
//  MenuHeaderView.swift
//  OverEats
//
//  Created by 박상욱 on 2018. 4. 8..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView
{
    // MenuList TableView의 HeaderView 내부 변수
    @IBOutlet weak var mainImage : UIImageView! // 음식점 이미지 뷰
    @IBOutlet weak var titleView : UIView! // 음식점 정보 뷰(이름, 카테고리, 배달시간)
    @IBOutlet weak var titleLabel : UILabel! // 음식점 명
    @IBOutlet weak var categoriLabel : UILabel! // 음식점의 카테고리(ex) 한식, 중식, 일식)
    @IBOutlet weak var deliveryTimeLabel : UILabel! // 배달 시간
    @IBOutlet weak var gradientView : UIView! // 이미지 뷰 내의 그라데이션
    
    // 음식점 이미지 삽입
    var setImage: UIImage? {
        didSet {
            if let image = setImage {
                mainImage.image = image
            }
        }
    }
    
    // 음식점 명 삽입
    var setTitle: String? {
        didSet {
            if let title = setTitle {
                titleLabel.text = title
            }
        }
    }
    
    // 음식점의 카테고리 삽입
    var setCategori: String? {
        didSet {
            if let categori = setCategori {
                categoriLabel.text = categori
            }
        }
    }
    
    // 배달 시간 삽입
    var setDeliveryTime: String? {
        didSet {
            if let deliveryTime = setDeliveryTime {
                deliveryTimeLabel.text = deliveryTime
            }
        }
    }
}
