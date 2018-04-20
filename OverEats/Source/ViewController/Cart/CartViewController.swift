//
//  MenuViewController.swift
//  OverEats
//
//  Created by 박상욱 on 2018. 4. 2..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit


struct CartSize {
    static let headerViewHeight: CGFloat = 562 // HeaderView의 height 설정 값
    static let navigationViewHeight: CGFloat = 80 // NavigationView의 height 설정 값
}

final class CartViewController: UIViewController {
    
    // CartViewController 변수
    // Navigation 관련
    @IBOutlet private weak var navigationView: UIView! // Navigation View
    @IBOutlet private weak var navigationTitle: UILabel! // Navigation Title
    @IBOutlet private weak var backButton: UIButton! // 이전 페이지로 이동
    
    // TableView 관련
    @IBOutlet private weak var orderList: UITableView! // menuList tableView
    var headerView: CartHeaderView! // menuList의 headerView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        setNavigation()
        setOrderList()
        setHeaderView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setHeaderFrame()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setHeaderFrame()
    }
    
    // Navigation 관련 설정
    func setNavigation() {
        // navigationView의 위치 설정
        self.navigationView.frame.origin.y = -CartSize.navigationViewHeight
        
        // backbutton 설정
        // tintColor 적용을 위한 설정 withRenderingMode(.alwaysTemplate)
        let backImage = UIImage(named: "btnClose")?.withRenderingMode(.alwaysTemplate) // Button Image 삽입
        backButton.setImage(backImage, for: .normal) // backImage 추가
        backButton.tintColor = .white // tintColor white 설정
        navigationTitle.text = "장바구니" // navigation
        
    }
    
    // MenuList의 TableView 설정
    func setOrderList() {
        
        orderList.separatorStyle = .none
        orderList.register(UINib(nibName: "CartCell", bundle: nil),
                            forCellReuseIdentifier: "CartCell")
        
        orderList.backgroundColor = .white // 테이블뷰의 배경 색
        orderList.rowHeight = UITableViewAutomaticDimension
        self.headerView = orderList.tableHeaderView as! CartHeaderView // 헤더뷰 설정
        orderList.tableHeaderView = nil // 테이블뷰 자체 헤더뷰 nil
        orderList.rowHeight = UITableViewAutomaticDimension // 테이블뷰의 rowHeight값을 custom 하게 설정
        orderList.addSubview(headerView) // 테이블뷰에 헤더뷰 addSubView
        
        let footerView = CartFooterView.cartFooterViewLoad()
//        footerView = orderList.tableFooterView as! CartFooterView
        orderList.tableFooterView = footerView
        orderList.addSubview(footerView)
        
        
        //테이블 뷰의 content In/Off set 적용
        orderList.contentInset = UIEdgeInsets(top: CartSize.headerViewHeight, left: 0, bottom: 0, right: 0)
        orderList.contentOffset = CGPoint(x: 0, y: -CartSize.headerViewHeight)
        
        setHeaderFrame()
        
    }
    
    // 테이블 뷰 헤더뷰 생성
    func setHeaderView() {
        
        headerView.restaurantName.text = "맥도날드"
        headerView.deliveryTime.text = "15" + "분-" + "25" + "분"
        
    }
    
    //테이블뷰의 contentOffset의 값에 따라 headerViewFrame설정
    func setHeaderFrame() {
        // 초기 getHeaderViewFrame 값
        var getHeaderViewFrame = CGRect(x: 0, y: -CartSize.headerViewHeight, width: orderList.bounds.width,
                                        height: CartSize.headerViewHeight)
        // 테이블뷰의 contentOffset.y가 headerViewHeight의 값보다 작을 때
        if orderList.contentOffset.y < -CartSize.headerViewHeight {
            // 테이블 뷰의 위치가 점점 아래로 내려간다.
            getHeaderViewFrame.origin.y = orderList.contentOffset.y
            // getHeaderView의 크기가 점점 커진다. (menuList.contentOffset.y은 원래 minus값이므로 -를 주면 양수로 바뀐다)
            getHeaderViewFrame.size.height = -orderList.contentOffset.y
        } else if orderList.contentOffset.y > -headerView.restaurantImageView.frame.maxY {
            UIView.animate(withDuration: 0.3) {
                self.navigationView.frame.origin.y = 0
                self.backButton.tintColor = .black
                UIApplication.shared.statusBarStyle = .default
            }
        } else if orderList.contentOffset.y < -headerView.restaurantImageView.frame.maxY {
            UIView.animate(withDuration: 0.3) {
                self.navigationView.frame.origin.y = -80
                self.backButton.tintColor = .white
                UIApplication.shared.statusBarStyle = .lightContent
            }
        }
        
        //변경된 값을 헤더 뷰의 프레임에 업데이트 시켜준다.
        headerView.frame = getHeaderViewFrame
    }

}



// MARK: extension TableView
// UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "주문내역"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.systemFont(ofSize: 17)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 뷰가 스크롤 될 때 마다 HeaderView의 프레임을 변경
        
        setHeaderFrame()
        if scrollView.contentOffset.y < 0 {
            
        } else {
            
        }
    }
    
    
}

// UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

