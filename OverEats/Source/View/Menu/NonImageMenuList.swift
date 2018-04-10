//
//  NonImageMenuList.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 8..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class NonImageMenuList: UITableViewCell {
    
    @IBOutlet private weak var name : UILabel!
    @IBOutlet private weak var menuDescription : UILabel!
    @IBOutlet private weak var price : UILabel!
    
    var setName: String? {
        didSet {
            if let setName = setName {
                name.text = setName
            }
        }
    }
    
    var foodDescription: String? {
        didSet {
            if let foodDescription = foodDescription {
                menuDescription.text = foodDescription
            } else {
                menuDescription.text = nil
            }
        }
    }
    
    var setPrice: String? {
        didSet {
            if let setPrice = setPrice {
                price.text = setPrice
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
