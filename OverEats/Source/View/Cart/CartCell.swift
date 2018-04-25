//
//  CartCell.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 18..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

struct CustomViewSize {
    static let deleteView: CGFloat = 60
}

class CartCell: UITableViewCell {

    @IBOutlet private weak var count : UILabel!
    @IBOutlet private weak var countView : UIView!
    @IBOutlet private weak var name : UILabel!
    @IBOutlet private weak var price : UILabel!
    @IBOutlet weak var cellScrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        countView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with menu: CartMenu) {
        self.name.text = menu.name
        self.count.text = String(menu.count)
        self.price.text = "₩" + String(menu.totalPrice)
    }
}
