//
//  RecommendTableViewCell.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 17..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit


/// 추천 리스트를 담당하는 TableViewCell
class RecommendTableViewCell: UITableViewCell {
    
    // 추천 리스트 스크롤뷰
    @IBOutlet weak var restaurantScrollView: UIScrollView!
    
    // restaurantView의 배열
    private var restaurantViews:[RestaurantView] = []
    var targetView: UIViewController!
    
    // 레스토랑 데이터가 들어올 때 셀을 체크
    var restaurants: [Restaurant]? {
        didSet {
            checkRestaurantScroll()
            configureRestaurantData()
        }
    }
    
    // restaurantViews 의 우선순위를 정의하는 변수
    var priorityPoint: Float = 500
    
    // restaurantViews 간 여백 변수
    let leadingPoint: CGFloat = 20
    let spacingPoint: CGFloat = 20
    let trailingPoint: CGFloat = -20
    
    override func awakeFromNib() {
        super.awakeFromNib()
        restaurantScrollView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension RecommendTableViewCell: UIScrollViewDelegate {
    
    // Cell 내 restaurantViews 의 수를 확인하고 생성, 삭제하는 함수
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
    
    // restaurantViews 의 마지막 인자를 삭제하는 함수
    private func removeRestaurantScroll(){
        restaurantViews.last?.removeFromSuperview()
        restaurantViews.last?.trailingAnchor.constraint(equalTo: restaurantScrollView.trailingAnchor).isActive = true
    }
    
    // restaurantViews 의 마지막 인자를 생성하는 함수
    private func addRestaurantScroll(scrollIndex: Int){
        
        let restaurantView = RestaurantView.loadNib()
        restaurantView.translatesAutoresizingMaskIntoConstraints = false
        
        restaurantViews.append(restaurantView)
        restaurantScrollView.addSubview(restaurantView)
        
        restaurantView.delegate = targetView as? RestaurantViewDelegate
        
        restaurantView.centerYAnchor.constraint(equalTo: restaurantScrollView.centerYAnchor).isActive = true
        restaurantView.widthAnchor.constraint(equalTo: restaurantScrollView.widthAnchor, multiplier: 0.85).isActive = true
        restaurantView.topAnchor.constraint(equalTo: restaurantScrollView.topAnchor).isActive = true
        restaurantView.bottomAnchor.constraint(equalTo: restaurantScrollView.bottomAnchor).isActive = true
        
        if scrollIndex == 0 {
            let trailingMargin = restaurantView.trailingAnchor.constraint(equalTo: restaurantScrollView.trailingAnchor, constant: trailingPoint)
            trailingMargin.priority = UILayoutPriority(priorityPoint)
            trailingMargin.isActive = true
            restaurantView.leadingAnchor.constraint(equalTo: restaurantScrollView.leadingAnchor, constant: leadingPoint).isActive = true
            priorityPoint += 1
            
        }else{
            let leadingMargin = restaurantView.leadingAnchor.constraint(equalTo: restaurantViews[scrollIndex - 1].trailingAnchor, constant: spacingPoint)
            leadingMargin.priority = UILayoutPriority(1000)
            leadingMargin.isActive = true
            
            let trailingMargin = restaurantView.trailingAnchor.constraint(equalTo: restaurantScrollView.trailingAnchor, constant: trailingPoint)
            trailingMargin.priority = UILayoutPriority(priorityPoint)
            trailingMargin.isActive = true
            
            priorityPoint += 1
        }
    }
    
    // restaurantView 에 데이터를 적용하는 함수
    private func configureRestaurantData(){
        if let restaurants = self.restaurants {
            for (index, restaurant) in restaurants.enumerated(){
                restaurantViews[index].restaurant = restaurant
            }
        }
    }

}
