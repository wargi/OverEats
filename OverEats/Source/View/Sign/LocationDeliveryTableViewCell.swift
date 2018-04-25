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
    @IBOutlet weak var buildingNameButton: UIButton!
    @IBOutlet weak var buildView: UIView!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var companyNameButton: UIButton!
    @IBOutlet weak var companyView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            UIView.animate(withDuration: 0) {
                self.frame.origin = CGPoint(x: 0, y: 100)
                self.bounds.size.height = 150
            }
        } else {
            UIView.animate(withDuration: 0) {
                self.frame.origin = CGPoint(x: 0, y: 100)
                self.frame.size.height = 50
            }
        }
        // Configure the view for the selected state
    }
    
    func configure(locationData: LocationTableUtility) {
        logoImageView.image = UIImage(named: locationData.iconName!)
        titleLabel.text = locationData.title
    }

}
