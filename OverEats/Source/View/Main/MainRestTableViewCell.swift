//
//  MainRestTableViewCell.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 5..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class MainRestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var MainRestScrollView: UIScrollView!
    @IBOutlet weak var SectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MainRestTableViewCell: UIScrollViewDelegate {
    
}
