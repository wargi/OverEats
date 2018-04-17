//
//  MainHeaderInSection.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class MainHeaderInSection: UIView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    class func loadMainHeaderInSectionNib() ->  MainHeaderInSection {
        return UINib(nibName: "MainHeaderInSection", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MainHeaderInSection
    }
    
    override func awakeFromNib() {
    }
    
}
