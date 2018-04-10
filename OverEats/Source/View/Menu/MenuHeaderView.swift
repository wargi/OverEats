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
    @IBOutlet weak var mainImage : UIImageView!
    @IBOutlet weak var titleView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var categoriLabel : UILabel!
    @IBOutlet weak var deliveryTimeLabel : UILabel!
    @IBOutlet weak var gradientView : UIView!
    
    
    var image: UIImage? {
        willSet {
            if let image = image {
                mainImage.image = UIImage(named: "foodimg.jpg")
            }
        }
    }
    
    var title: String? {
        didSet {
            if let title = title {
                titleLabel.text = title
            }
        } 
    }
    
    // 카테고리
    var categori: String? {
        didSet {
            if let categori = categori {
                categoriLabel.text = categori
            }
        }
    }
    
    // 배달 시간
    var deliveryTime: String? {
        didSet {
            if let deliveryTime = deliveryTime {
                deliveryTimeLabel.text = deliveryTime
            }
        }
    }
}
