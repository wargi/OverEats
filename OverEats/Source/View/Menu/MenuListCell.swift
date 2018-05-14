//
//  NonImageMenuList.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 8..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class MenuListCell: UITableViewCell {
    
    
    
    // MenuList TavleView Cell의 NonImageMenuListCell 변수
    @IBOutlet weak var menuImageView : UIImageView?
    @IBOutlet private weak var name : UILabel! // 메뉴 명
    @IBOutlet private weak var menuDescription : UILabel! // 메뉴 설명
    @IBOutlet private weak var price : UILabel! // 메뉴 가격
    @IBOutlet weak var line: UIView!
    
    override func prepareForReuse() {
        self.name.text = nil
        self.menuDescription.text = nil
        self.price.text = nil
        self.menuImageView?.image = nil
        
    }
    
    
    // 메뉴 명, 설명, 가격, 이미지 삽입
    func configure(with menu: Menu) {
        self.name.text = menu.name
        self.menuDescription.text = menu.description
        self.price.text = "₩" + String(menu.price)
        
        if menu.imageURL != "" {
            self.menuImageView?.loadImageUsingCacheWithUrl(urlString: menu.imageURL) { _ in
            }
        }
    }
    
}
