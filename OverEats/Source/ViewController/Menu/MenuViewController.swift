//
//  MenuViewController.swift
//  OverEats
//
//  Created by 박상욱 on 2018. 4. 2..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    // Menu List View 영역
    @IBOutlet private weak var menuList : UITableView!
    var restaurantInfomation: Restaurant!
    
    
    var backgroundView: UIView!
    var headerView: MenuHeaderView!
    let headerViewHeight: CGFloat = 332.5 // 헤더뷰의 height 설정 값
    var gradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderView()
        
        menuList.register(
            UINib(nibName: "ImageMenuListCell", bundle: nil),
            forCellReuseIdentifier: "ImageMenuListCell"
        )
        
        menuList.register(
            UINib(nibName: "NonImageMenuList", bundle: nil),
            forCellReuseIdentifier: "NonImageMenuList")
        
        menuList.reloadData()
        
    }
    
    // 테이블 뷰 헤더뷰 생성
    func setHeaderView() {
        
        menuList.backgroundColor = .white // 테이블뷰의 배경 색
        headerView = menuList.tableHeaderView as! MenuHeaderView // 헤더뷰 설정
        menuList.tableHeaderView = nil // 테이블뷰 자체 헤더뷰 nil
        menuList.rowHeight = UITableViewAutomaticDimension // 테이블뷰의 rowHeight값을 custom 하게 설정
        menuList.addSubview(headerView) // 테이블뷰에 헤더뷰 addSubView
        
        headerView.titleView.layer.cornerRadius = 4
        headerView.titleView.layer.shadowColor = UIColor.black.cgColor
        headerView.titleView.layer.shadowOpacity = 0.1
        headerView.titleView.layer.shadowOffset = CGSize.zero
        headerView.titleView.layer.shadowRadius = 7
        
        headerView.title = restaurantInfomation.name
        headerView.deliveryTime = String(restaurantInfomation.minDeliveryTime) + "분-" +
                                  String(restaurantInfomation.maxDeliveryTime) + "분"
        
        gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: headerView.frame.origin.y, width: self.view.bounds.width, height: headerView.mainImage.bounds.height / 2)
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.01]
        headerView.gradientView.layer.insertSublayer(gradient, at: 0)
        
        
        //테이블 뷰의 content In/Off set 적용
        menuList.contentInset = UIEdgeInsetsMake(headerViewHeight, 0, 0, 0)
        menuList.contentOffset = CGPoint(x: 0, y: -headerViewHeight)
        
        setHeaderFrame()
        
    }
    
    //테이블뷰의 contentOffset의 값에 따라 headerViewFrame설정
    func setHeaderFrame() {
        // 초기 getHeaderViewFrame 값
        var getHeaderViewFrame = CGRect(x: 0, y: -headerViewHeight, width: menuList.bounds.width,
                                        height: headerViewHeight)
        
        // 테이블뷰의 contentOffset.y가 headerViewHeight의 값보다 작을 때
        if menuList.contentOffset.y < -headerViewHeight {
            print(menuList.contentOffset.y, headerViewHeight)
            // 테이블 뷰의 위치가 점점 아래로 내려간다.
            getHeaderViewFrame.origin.y = menuList.contentOffset.y
            // getHeaderView의 크기가 점점 커진다. (menuList.contentOffset.y은 원래 minus값이므로 -를 주면 양수로 바뀐다)
            getHeaderViewFrame.size.height = -menuList.contentOffset.y
        }
        //변경된 값을 헤더 뷰의 프레임에 업데이트 시켜준다.
        headerView.frame = getHeaderViewFrame
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(restaurantInfomation.menuList!.count)
        guard let menuCount = restaurantInfomation.menuList?.count else { return 0 }
        return menuCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let menuImage = restaurantInfomation.menuList?[indexPath.row].foodImage else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NonImageMenuList") as! NonImageMenuList
            cell.setName = restaurantInfomation.menuList?[indexPath.row].foodName
            cell.foodDescription = restaurantInfomation.menuList?[indexPath.row].foodDescription
            cell.setPrice = "₩" + String(restaurantInfomation.menuList![indexPath.row].price)
            
            return cell
            
        }
        if let menuImage = imagePost.imageDownload(stringURL: menuImage) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageMenuListCell") as! ImageMenuListCell
            cell.setImage = menuImage
            cell.setName = restaurantInfomation.menuList?[indexPath.row].foodName
            cell.foodDescription = restaurantInfomation.menuList?[indexPath.row].foodDescription
            cell.setPrice = "₩" + String(restaurantInfomation.menuList![indexPath.row].price)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 뷰가 스크롤 될 때 마다 HeaderView의 프레임을 변경
        setHeaderFrame()
    }
    
    
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "SelectMenu") as! SelectMenuViewController
        nextViewController.price = 7000
        nextViewController.modalPresentationStyle = .overFullScreen
        
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
