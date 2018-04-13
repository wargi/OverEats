//
//  SettingCell.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 11..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    // SettingCell의
    @IBOutlet private weak var cellImage : UIImageView!
    @IBOutlet private weak var name : UILabel!
    
    var setImage: UIImage! {
        didSet {
            if let setImage = setImage {
                cellImage.image = setImage
            }
        }
    }
    
    var setText: String! {
        didSet {
            if let setText = setText {
                name.text = setText
            }
        }
    }
    
}
