//
//  RestaurantView.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 19..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

protocol RestaurantViewDelegate {
    func tappedView(_ restaurantView: RestaurantView)
}

class RestaurantView: UIView {
    
    @IBOutlet weak var restaurantImageView: UIImageView! // 레스토랑 이미지 레이블
    @IBOutlet weak var restaurantNameLabel: UILabel! // 레스토랑 명칭 레이블
    @IBOutlet weak var restaurantCategoryLabel: UILabel! // 레스토랑 카테고리 레이블
    @IBOutlet weak var restaurantScoreLabel: UILabel! // 레스토랑 평점 레이블
    @IBOutlet weak var restaurantDeliveryTimeLabel: UILabel! // 배달 시간 레이블
    @IBOutlet weak var restaurantDescriptionLabel: UILabel! // 레스토랑 소개 레이블
    
    @IBOutlet weak var restaurantScoreImageView: UIImageView! // 레스토랑 평점 별 이미지
    
    @IBOutlet weak var restaurantScoreStack: UIStackView! // 평점 스택
    @IBOutlet weak var restaurantDescriptionStack: UIStackView! // 소개 스택
    
    var delegate: RestaurantViewDelegate?
    
    // restaurantView 를 호출받는 함수
    class func loadNib() -> RestaurantView {
        return UINib(nibName: "RestaurantView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RestaurantView
    }
    
    override func awakeFromNib() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedView))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tappedView(_ sender: UITapGestureRecognizer){
        delegate?.tappedView(self)
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
