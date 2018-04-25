//
//  SearchTableViewCell.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 24..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // 레스토랑 뷰를 정의
    var restaurantView: RestaurantView?
    
    var targetView: UIViewController!
    
    // 뷰 여백 포인트
    var leadingMargin: CGFloat = 15
    var trailingMargin: CGFloat = -15
    
    // 레스토랑 데이터가 들어올 때 뷰가 있는지 체크
    var restaurant: Lestaurant? {
        didSet {
            checkSubview()
        }
    }
    
    // 뷰가 있는지 확인한 후 있으면, 데이터만 변경하고, 없으면 뷰를 생성
    private func checkSubview() {
        if let restaurantView = self.restaurantView {
            restaurantView.restaurant = restaurant
        } else {
            setRestaurantViewLayout()
        }
    }
    
    // 테이블 뷰를 정의하고 데이터를 적용
    private func setRestaurantViewLayout(){
        self.restaurantView = RestaurantView.loadNib()
        if let restaurantView = self.restaurantView {
            restaurantView.translatesAutoresizingMaskIntoConstraints = false
            
            restaurantView.delegate = targetView as? RestaurantViewDelegate
            
            self.addSubview(restaurantView)
            
            restaurantView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            restaurantView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingMargin).isActive = true
            restaurantView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingMargin).isActive = true
            restaurantView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            restaurantView.restaurant = restaurant
        }
    }
}
