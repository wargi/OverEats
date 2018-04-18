//
//  RecommendCollectionViewCell.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 17..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantScoreLabel: UILabel!
    @IBOutlet weak var restaurantDeliveryTimeLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    
    @IBOutlet weak var restaurantBottomStack: UIStackView!
    
    func configure(with restaurant: Lestaurant?) {
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.widthAnchor.constraint(equalToConstant: 300)
//        self.heightAnchor.constraint(equalToConstant: 300)
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
