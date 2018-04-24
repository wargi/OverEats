//
//  SearchCollectionViewCell.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 24..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    var category: Tag? {
        didSet {
            setCategoryData()
        }
    }
    
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    
    private func setCategoryData(){
        if let categoryData = self.category {
            self.tagImageView.loadImageUsingCacheWithUrl(urlString: categoryData.logoUrl) { (success) in
            }
            self.tagLabel.text = categoryData.name
        }
    }
}
