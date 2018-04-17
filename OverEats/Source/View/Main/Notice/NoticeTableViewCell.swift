//
//  NoticeTableViewCell.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell, UIScrollViewDelegate{
    
    @IBOutlet weak var noticeScrollView: UIScrollView!
    @IBOutlet weak var noticePageControl: UIPageControl!
    
    private var noticeImageViews:[NoticeImageView] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noticeScrollView.delegate = self
    }
    
    func setNoticeScroll(with notices: [Notice]?){
        if let notices = notices {
            for (index, notice) in notices.enumerated(){
                
                let noticeImageView = NoticeImageView.loadNoticeNib()
                noticeImageView.translatesAutoresizingMaskIntoConstraints = false
                noticeImageViews.append(noticeImageView)
                
                noticeImageView.configure(with: notice)
                
                noticeScrollView.addSubview(noticeImageView)
                
                noticeImageView.centerYAnchor.constraint(equalTo: noticeScrollView.centerYAnchor).isActive = true
                noticeImageView.widthAnchor.constraint(equalTo: noticeScrollView.widthAnchor).isActive = true
                noticeImageView.topAnchor.constraint(equalTo: noticeScrollView.topAnchor).isActive = true
                noticeImageView.bottomAnchor.constraint(equalTo: noticeScrollView.bottomAnchor).isActive = true
                
                if index == 0 {
                    noticeImageView.leadingAnchor.constraint(equalTo: noticeScrollView.leadingAnchor).isActive = true
                } else if index == notices.count - 1 {
                    noticeImageView.leadingAnchor.constraint(equalTo: noticeImageViews[index - 1].trailingAnchor).isActive = true
                    noticeImageView.trailingAnchor.constraint(equalTo: noticeScrollView.trailingAnchor).isActive = true
                } else {
                    noticeImageView.leadingAnchor.constraint(equalTo: noticeImageViews[index - 1].trailingAnchor).isActive = true
                }
                addGradient(imageView: noticeImageView.imageView)
            }
            noticePageControl.numberOfPages = notices.count
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        noticePageControl.currentPage = Int(noticeScrollView.contentOffset.x / self.frame.size.width)
    }
    
    func addGradient(imageView: UIImageView) {
        let topBlack = UIColor(white: 0, alpha: 0)
        let bottomBlack = UIColor(white: 0, alpha: 0.7)
        
        let gradientColors: [CGColor] = [topBlack.cgColor, bottomBlack.cgColor]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        
        self.setNeedsLayout()
        
        gradientLayer.frame = self.bounds
        
        imageView.layer.insertSublayer(gradientLayer, at: 0)
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
