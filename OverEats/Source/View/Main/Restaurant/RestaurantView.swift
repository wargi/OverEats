//
//  RestaurantView.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 19..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class RestaurantView: UIView {
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantScoreLabel: UILabel!
    @IBOutlet weak var restaurantDeliveryTimeLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    
    @IBOutlet weak var restaurantScoreImageView: UIImageView!
    
    @IBOutlet weak var restaurantScoreStack: UIStackView!
    @IBOutlet weak var restaurantDescriptionStack: UIStackView!
    
    class func loadNib() -> RestaurantView {
        return UINib(nibName: "RestaurantView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RestaurantView
    }
    
    func configure(with restaurant: Lestaurant?) {
        if let restaurant = restaurant {
            self.restaurantImageView.loadImageUsingCacheWithUrl(urlString: restaurant.logo) { (success) in
            }
            self.restaurantNameLabel.text = restaurant.name
            
            var sumCategoryString: String = ""
            for (index, category) in restaurant.tags.enumerated() {
                if index == 0{
                    sumCategoryString.append("\(category.name) ")
                }else {
                    sumCategoryString.append("•\(category.name) ")
                }
                
            }
            self.restaurantCategoryLabel.text = sumCategoryString
            
            self.restaurantDeliveryTimeLabel.text = "\(restaurant.etaRange.min)-\(restaurant.etaRange.max)분"
            
            //            self.restaurantBottomStack.removeFromSuperview()
            
            
            // 차후 Description 이 생기면 실행
            //            if restaurant.description != "" {
            //                self.restaurantDescriptionLabel.text = restaurant.
            //            }else {
            //                self.restaurantBottomStack.removeFromSuperview()
            //            }
        }
        
    }
}
