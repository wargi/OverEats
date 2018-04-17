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
        self.imageView.loadImageUsingCacheWithUrl(urlString: notice.imageUrl, completion: { (success) in })
        self.titleLabel.text = notice.title
        self.subTitleLabel.text = notice.subTitle
    }

}
