//
//  LocationDeliveryTableViewCell.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 25..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class LocationDeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var buildingNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    
    @IBOutlet weak var checkImage: UIImageView!
    
    
    @IBOutlet weak var detailStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        
        if selected {
            checkImage.isHidden = false
            detailStackView.isHidden = false
        } else {
            checkImage.isHidden = true
            detailStackView.isHidden = true
        }
        // Configure the view for the selected state
    }
    
    func configure(locationData: LocationTableUtility) {
        logoImageView.image = UIImage(named: locationData.iconName!)
        titleLabel.text = locationData.title
    }

}
