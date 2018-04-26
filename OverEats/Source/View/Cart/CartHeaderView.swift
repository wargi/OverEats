//
//  CartFooterView.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 17..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class CartHeaderView: UIView {

    @IBOutlet weak var gradientView : UIView!
    @IBOutlet weak var restaurantImageView : UIImageView!
    @IBOutlet weak var restaurantName : UILabel!
    @IBOutlet weak var deliveryTime : UILabel!
    @IBOutlet private weak var mapImage : UIImageView!
    @IBOutlet private weak var address : UILabel!
    @IBOutlet private weak var detailAddress : UILabel!
    @IBOutlet private weak var addressView : UIView!
    
    func configure() {
        restaurantName.text = CartManager.restaurantName
        deliveryTime.text = String(CartManager.deliveryTime!.min) + "분 - " +
                            String(CartManager.deliveryTime!.max) + "분 소요"
        restaurantImageView.loadImageUsingCacheWithUrl(urlString: CartManager.restaurantURL!) { _ in }
        mapImage.loadImageUsingCacheWithUrl(urlString: API.getMapImage(latitude: Float(CartManager.dumpDelivery.lat),
                                                                       longitude: Float(CartManager.dumpDelivery.lng)).urlString) { _ in }
        address.text = CartManager.dumpDelivery.address
        detailAddress.text = CartManager.dumpDelivery.detailAddress
    }
}
