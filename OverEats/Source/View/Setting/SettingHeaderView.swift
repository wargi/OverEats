//
//  HeaderView.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 11..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class SettingHeaderView: UIView {

    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet private weak var name : UILabel!
    
    var image: UIImage? {
        willSet {
            profileImage.layer.cornerRadius = profileImage.bounds.width / 2
            profileImage.layer.borderWidth = 1
            if let profile = image {
                profileImage.image = profile
            } else {
                profileImage.image = UIImage(named: "icSettingListProfile")
            }
        }
    }
    
    var userName: String! {
        didSet {
            if let userName = userName {
                name.text = userName
            }
        }
    }
    
    
}
