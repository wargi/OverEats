//
//  ViewController.swift
//  OverEats
//
//  Created by 안솔찬 on 2018. 3. 30..
//  Copyright © 2018년 solchan ahn. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var notices: [Notice]?
    
    @IBOutlet weak private var mainTableView: UITableView!
    
    @IBOutlet private var noticeView: UIView!
    @IBOutlet private var noticeScrollView: UIScrollView!
    
    @IBOutlet private var noticePageControl: UIPageControl!
    
    @IBAction func testBtn(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noticeScrollView.delegate = self
        
        getNoticeData()
        

    }
}

extension MainViewController: UIScrollViewDelegate {
    
    // MARK: buttonhandler
    private func getNoticeData(){
        MainGet.getNotice(completionHandler: { notices in
            self.notices = notices
        })
        
        var contentWidth: CGFloat = 0.0
        
        noticeView.frame.size = CGSize(width: self.view.frame.size.width, height: 200)
        
        let viewWidth = noticeView.frame.size.width
        let contentHeight = noticeView.frame.size.height
        
        if let notices = self.notices {
            for notice in notices {
                
                let noticeImageView = NoticeImageView.loadNoticeNib()
                noticeImageView.configure(with: notice)
                
                noticeScrollView.addSubview(noticeImageView)

                noticeImageView.frame = CGRect(x: contentWidth, y: 0, width: viewWidth, height: contentHeight)
                noticeImageView.addGradient(with: noticeView.frame)

                contentWidth += viewWidth
                
            }
            noticePageControl.numberOfPages = notices.count
            noticeScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
            
        }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        noticePageControl.currentPage = Int(noticeScrollView.contentOffset.x / noticeView.frame.size.width)
    }
    
    /// 입력된 페이지로 스크롤 뷰를 이동해주는 함수
    ///
    /// - Parameter page: 이동해야되는 페이지 0부터 시작
    func scrollToPage(page: Int) {
        var frame: CGRect = noticeView.frame
        print(frame.origin.x)
        frame.origin.x = frame.size.width * CGFloat(page);
        print(frame.origin.x)
        frame.origin.y = 0;
        noticeScrollView.scrollRectToVisible(frame, animated: true)
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = UITableViewCell()
        tempCell.backgroundColor = .yellow
        return tempCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }


}

extension MainViewController: UITableViewDelegate {

}
