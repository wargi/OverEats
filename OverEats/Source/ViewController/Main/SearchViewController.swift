//
//  SearchViewController.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 22..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchCollectionMarginToSafeArea: NSLayoutConstraint!
    @IBOutlet weak var searchTopBarHeight: NSLayoutConstraint!
    var searchTopBarPoint: CGFloat?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tagData: Tags? {
        didSet {
            self.collectionView.reloadData()
            print("-------!------")
        }
    }
    
    private struct Metric {
        static let numberOfItem: CGFloat = 2
        static let numberOfLine: CGFloat = 2
        
        static let topPadding: CGFloat = 0
        static let leftPadding: CGFloat = 15.0
        static let bottomPadding: CGFloat = 10.0
        static let rightPadding: CGFloat = 15.0
        
        static let lineSpacing: CGFloat = 10.0
        static let itemSpacing: CGFloat = 10.0
        
        static let nextOffset: CGFloat = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTagData()
        searchTopBarPoint = searchTopBarHeight.constant
    }
    
    private func getTagData() {
        GetService.tagList(completion: { (result) in
            switch result {
            case .success(let tagData):
                self.tagData = tagData
            case .error(let error):
                print(error)
            }
//            self.mainTableView.reloadData()
        })
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagData?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellData = tagData?.categories[indexPath.item] else { return UICollectionViewCell ()}
        let searchCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        searchCollectionViewCell.tagImageView.loadImageUsingCacheWithUrl(urlString: cellData.logoUrl) { (success) in
        }
        searchCollectionViewCell.tagLabel.text = cellData.name
        return searchCollectionViewCell
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {
        
        let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
        let horizontalPadding = Metric.leftPadding + Metric.rightPadding + Metric.nextOffset
        let width = (collectionView.frame.width - lineSpacing - horizontalPadding) / Metric.numberOfLine
        let height = width * 0.8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int ) -> CGFloat {
        return Metric.lineSpacing
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Metric.itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int ) -> UIEdgeInsets {
        return UIEdgeInsetsMake(Metric.topPadding, Metric.leftPadding,
                                Metric.bottomPadding, Metric.rightPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchCollectionHeaderView", for: indexPath) as! SearchCollectionHeaderView
        headerView.titleLabel.text = "레스토랑 카테고리"
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchTopBarHeight.constant = searchTopBarPoint! - (scrollView.contentOffset.y / 2)
        searchCollectionMarginToSafeArea.constant = searchTopBarPoint! - scrollView.contentOffset.y
        
    }
}

