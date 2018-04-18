//
//  RecommendTableViewCell.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 17..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class RecommendTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var restaurants: [Lestaurant]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = UIViewAutoresizing.flexibleHeight
    }
    
    override func layoutSubviews() {
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension RecommendTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let restaurantData = restaurants?[indexPath.item] else { return UICollectionViewCell() }
        let recommendCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as! RecommendCollectionViewCell
        recommendCollectionViewCell.configure(with: restaurantData)
        return recommendCollectionViewCell
    }
}

extension RecommendCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 300, height: 300)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        return 30
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
        ) -> CGFloat {
        return 30
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
        ) -> UIEdgeInsets {
        return UIEdgeInsetsMake(30, 30, 30, 30)
    }
}
