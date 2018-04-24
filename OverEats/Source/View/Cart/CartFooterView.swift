//
//  CartFooterView.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 18..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class CartFooterView: UIView {

    @IBOutlet private weak var request : UILabel!
    @IBOutlet private weak var requestView : UIView!
    @IBOutlet private weak var totalPrice : UILabel?
    @IBOutlet private weak var cardNumber : UITextField!
    
    func sumPrice(with priceList: [CartMenu]) {
        var sum: Int = 0
        for price in priceList {
            print(sum, price.totalPrice)
            sum = sum + price.totalPrice
        }
        
        print(self.totalPrice?.text)
    }
}
