//
//  NoticeView.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 11..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class NoticeView: UIView, UIScrollViewDelegate{
    
    @IBOutlet weak var noticeScrollView: UIScrollView!
    @IBOutlet weak var noticePageControl: UIPageControl!
    
    private var noticeImageViews:[NoticeImageView] = []
    
    override func awakeFromNib() {
        noticeScrollView.delegate = self
    }
    
    func setNoticePage(with notices: [Notice]){
        
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
                print(index, "first")
            } else if index == notices.count - 1 {
                noticeImageView.leadingAnchor.constraint(equalTo: noticeImageViews[index - 1].trailingAnchor).isActive = true
                noticeImageView.trailingAnchor.constraint(equalTo: noticeScrollView.trailingAnchor).isActive = true
                print(index, "last")
            } else {
                noticeImageView.leadingAnchor.constraint(equalTo: noticeImageViews[index - 1].trailingAnchor).isActive = true
                print(index, notices.count)
            }
            noticeImageView.addGradient()
        }
        
        noticePageControl.numberOfPages = notices.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        noticePageControl.currentPage = Int(noticeScrollView.contentOffset.x / self.frame.size.width)
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
