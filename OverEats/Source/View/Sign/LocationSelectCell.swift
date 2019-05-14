//
//  LocationSelectCell.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 25..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class LocationSelectCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailAddress: UILabel!
    
    @IBOutlet weak var checkImage: UIImageView!
    
    var locationData: LocationData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            checkImage.isHidden = false
        } else {
            checkImage.isHidden = true
        }
    }
    
    func configure(locationData: LocationTableUtility) {
        logoImageView.image = UIImage(named: locationData.iconName!)
        titleLabel.text = locationData.title
        print(locationData.cellContent)
        detailAddress.text = locationData.cellContent
        
        self.locationData = locationData.cellData
    }

}
