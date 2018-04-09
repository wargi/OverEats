//
//  MainRestView.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 5..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class MainRestView: UIView {
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantScoreLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    
    @IBOutlet weak var restaurantBottomStack: UIStackView!
    
    class func loadMainRestNib() ->  MainRestView {
        return UINib(nibName: "MainRestView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MainRestView
    }
    
    func configure(with restaurant: Restaurant) {
//        self.restaurantImageView.image = UIImage(data: restaurant.imageData!)
        self.restaurantNameLabel.text = restaurant.name
        var sumCategoryString: String = ""
        for category in restaurant.category! {
            sumCategoryString.append("* \(category.name!)")
        }
        self.restaurantCategoryLabel.text = sumCategoryString
        //                if restaurant.score! > 0 {
        //                    self.restaurantScoreLabel.text = restaurant.score as? String
        //                } else {
        //                    self.restaurantScoreLabel.removeFromSuperview()
        //                }
        if restaurant.description != "" {
            self.restaurantDescriptionLabel.text = restaurant.description
        }else {
            self.restaurantBottomStack.removeFromSuperview()
        }
    }

}
