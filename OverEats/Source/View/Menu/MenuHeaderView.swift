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
    
    
    func configure(with restaurant: Lestaurant) {
        self.deliveryTimeLabel.text = String(restaurant.etaRange.min) + "분-" +
                                      String(restaurant.etaRange.max) + "분"
        self.titleLabel.text = restaurant.name
        self.mainImage.loadImageUsingCacheWithUrl(urlString: restaurant.logo) { _ in
        
        }
        for tag in restaurant.tags {
            if self.categoriLabel.text == nil {
                self.categoriLabel.text = tag.name
            } else {
                self.categoriLabel.text = self.categoriLabel.text! + " " + tag.name
            }
        }
    }
}
