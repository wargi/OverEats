//
//  mainTableViewCell.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 23..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stopLocationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
  
    let tagNumberThree = 3
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func configure(stopLocation: String, location address: String) {
        stopLocationLabel.text = stopLocation
        locationLabel.text = address
        
    }
    
}
