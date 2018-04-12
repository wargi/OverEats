//
//  NoticeImageView.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class NoticeImageView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var titleStack: UIStackView!
    
    class func loadNoticeNib() -> NoticeImageView {
        return UINib(nibName: "NoticeImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NoticeImageView
    }
    
    func configure(with notice: Notice) {
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: notice.imageURL)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
                self.titleLabel.text = notice.title
                self.subTitleLabel.text = notice.subTitle
            }
        }
    }
    
    func addGradient() {
        let topBlack = UIColor(white: 0, alpha: 0)
        let bottomBlack = UIColor(white: 0, alpha: 0.7)
        
        let gradientColors: [CGColor] = [topBlack.cgColor, bottomBlack.cgColor]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        self.setNeedsLayout()
        self.layoutIfNeeded()
        gradientLayer.frame = self.imageView.bounds
        
        self.imageView.layer.insertSublayer(gradientLayer, at: 0)
    }

}
