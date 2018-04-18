//
//  NoticeTableViewCell.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell{
    
    @IBOutlet weak var noticeScrollView: UIScrollView!
    @IBOutlet weak var noticePageControl: UIPageControl!
    
    private var noticeImageViews:[NoticeImageView] = []
    
    var notices: [Notice]? {
        didSet {
            checkNoticeScroll()
            configureNoticeData()
        }
    }
    var priorityPoint: Float = 500
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noticeScrollView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //    /// 입력된 페이지로 스크롤 뷰를 이동해주는 함수
    //    ///
    //    /// - Parameter page: 이동해야되는 페이지 0부터 시작
    //    func scrollToPage(page: Int) {
    //        var frame: CGRect = self.frame
    //        print(frame.origin.x)
    //        frame.origin.x = frame.size.width * CGFloat(page);
    //        print(frame.origin.x)
    //        frame.origin.y = 0;
    //        noticeScrollView.scrollRectToVisible(frame, animated: true)
    //    }
    
}
extension NoticeTableViewCell: UIScrollViewDelegate {
    
    private func checkNoticeScroll(){
        if let notices = self.notices {
            let checkCount = noticeImageViews.count - notices.count
            if checkCount > 0 {
                for _ in 0..<checkCount{
                    removeNoticeScroll()
                }
            } else if checkCount < 0{
                let createCount = abs(checkCount)
                for index in noticeImageViews.count..<createCount {
                    addNoticeScroll(scrollIndex: index)
                }
            }
            noticePageControl.numberOfPages = notices.count
        }
    }
    
    private func removeNoticeScroll(){
        noticeImageViews.last?.removeFromSuperview()
        noticeImageViews.last?.trailingAnchor.constraint(equalTo: noticeScrollView.trailingAnchor).isActive = true
    }
    
    private func configureNoticeData(){
        if let notices = self.notices {
            for (index, notice) in notices.enumerated(){
                noticeImageViews[index].configure(with: notice)
            }
        }
    }
    
    private func addNoticeScroll(scrollIndex: Int){
        
        let noticeImageView = NoticeImageView.loadNoticeNib()
        noticeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        noticeImageViews.append(noticeImageView)
        noticeScrollView.addSubview(noticeImageView)
        
        noticeImageView.centerYAnchor.constraint(equalTo: noticeScrollView.centerYAnchor).isActive = true
        noticeImageView.widthAnchor.constraint(equalTo: noticeScrollView.widthAnchor).isActive = true
        noticeImageView.topAnchor.constraint(equalTo: noticeScrollView.topAnchor).isActive = true
        noticeImageView.bottomAnchor.constraint(equalTo: noticeScrollView.bottomAnchor).isActive = true
        
        if scrollIndex == 0 {
            let trailingMargin = noticeImageView.trailingAnchor.constraint(equalTo: noticeScrollView.trailingAnchor)
            trailingMargin.priority = UILayoutPriority(priorityPoint)
            trailingMargin.isActive = true
            noticeImageView.leadingAnchor.constraint(equalTo: noticeScrollView.leadingAnchor).isActive = true
            priorityPoint += 1
            
        }else{
            let leadingMargin = noticeImageView.leadingAnchor.constraint(equalTo: noticeImageViews[scrollIndex - 1].trailingAnchor)
            leadingMargin.priority = UILayoutPriority(1000)
            leadingMargin.isActive = true
            
            let trailingMargin = noticeImageView.trailingAnchor.constraint(equalTo: noticeScrollView.trailingAnchor)
            trailingMargin.priority = UILayoutPriority(priorityPoint)
            trailingMargin.isActive = true
            
            priorityPoint += 1
        }
        addGradient(imageView: noticeImageView.imageView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        noticePageControl.currentPage = Int(noticeScrollView.contentOffset.x / self.frame.size.width)
    }
    
    private func addGradient(imageView: UIImageView) {
        let topBlack = UIColor(white: 0, alpha: 0)
        let bottomBlack = UIColor(white: 0, alpha: 0.7)
        
        let gradientColors: [CGColor] = [topBlack.cgColor, bottomBlack.cgColor]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        
        self.setNeedsLayout()
        
        gradientLayer.frame = self.bounds
        
        imageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
