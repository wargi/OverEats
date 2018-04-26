//
//  CartFooterView.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 18..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit


class CartFooterView: UIView {

    @IBOutlet weak var requestLabel : UILabel!
    @IBOutlet weak var requestView : UIView!
    @IBOutlet private weak var totalPrice : UILabel?
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var cardLabel : UILabel!
  
    let defaultString: String = "요청할 사항을 적어주세요(소스 추가, 양파 빼기 등)"
    var requestTap: UITapGestureRecognizer! // Request Tap Gesture 요청사항 작성 이벤트
    
    func configure(with priceList: [CartMenu]) -> Int {
        var sum: Int = 0
        for price in priceList {
            sum = sum + price.totalPrice
        }
        
        totalPrice?.text = "₩" + String(sum)
        
        return sum
    }
}
