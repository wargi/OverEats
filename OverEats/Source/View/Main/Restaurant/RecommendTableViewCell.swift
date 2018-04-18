//
//  RecommendTableViewCell.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 17..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class RecommendTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantScrollView: UIScrollView!
    
    var restaurants: [Lestaurant]? {
        didSet {
            checkRestaurantScroll()
            configureRestaurantData()
        }
    }
    
    private var restaurantViews:[RestaurantView] = []
    
    var priorityPoint: Float = 500
    
    override func awakeFromNib() {
        super.awakeFromNib()
        restaurantScrollView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension RecommendTableViewCell: UIScrollViewDelegate {
    
//    private func setRestaurantScollView
    
    private func checkRestaurantScroll(){
        if let restaurant = self.restaurants {
            let checkCount = restaurantViews.count - restaurant.count
            if checkCount > 0 {
                for _ in 0..<checkCount{
                    removeRestaurantScroll()
                }
            } else if checkCount < 0{
                let createCount = abs(checkCount)
                for index in restaurantViews.count..<createCount {
                    addRestaurantScroll(scrollIndex: index)
                }
            }
        }
    }
    
    private func removeRestaurantScroll(){
        restaurantViews.last?.removeFromSuperview()
        restaurantViews.last?.trailingAnchor.constraint(equalTo: restaurantScrollView.trailingAnchor).isActive = true
    }
    
    private func configureRestaurantData(){
        if let restaurants = self.restaurants {
            for (index, restaurant) in restaurants.enumerated(){
                restaurantViews[index].configure(with: restaurant)
            }
        }
    }
    
    private func addRestaurantScroll(scrollIndex: Int){
        
        let restaurantView = RestaurantView.loadNib()
        restaurantView.translatesAutoresizingMaskIntoConstraints = false
        
        restaurantViews.append(restaurantView)
        restaurantScrollView.addSubview(restaurantView)
        
        restaurantView.centerYAnchor.constraint(equalTo: restaurantScrollView.centerYAnchor).isActive = true
        restaurantView.widthAnchor.constraint(equalTo: restaurantScrollView.widthAnchor).isActive = true
        restaurantView.topAnchor.constraint(equalTo: restaurantScrollView.topAnchor).isActive = true
        restaurantView.bottomAnchor.constraint(equalTo: restaurantScrollView.bottomAnchor).isActive = true
        
        if scrollIndex == 0 {
            let trailingMargin = restaurantView.trailingAnchor.constraint(equalTo: restaurantScrollView.trailingAnchor)
            trailingMargin.priority = UILayoutPriority(priorityPoint)
            trailingMargin.isActive = true
            restaurantView.leadingAnchor.constraint(equalTo: restaurantScrollView.leadingAnchor).isActive = true
            priorityPoint += 1
            
        }else{
            let leadingMargin = restaurantView.leadingAnchor.constraint(equalTo: restaurantViews[scrollIndex - 1].trailingAnchor)
            leadingMargin.priority = UILayoutPriority(1000)
            leadingMargin.isActive = true
            
            let trailingMargin = restaurantView.trailingAnchor.constraint(equalTo: restaurantScrollView.trailingAnchor)
            trailingMargin.priority = UILayoutPriority(priorityPoint)
            trailingMargin.isActive = true
            
            priorityPoint += 1
        }
    }
    
}
