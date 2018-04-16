//
//  MenuViewController.swift
//  OverEats
//
//  Created by 박상욱 on 2018. 4. 2..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit
//import Alamofire

struct SetSize {
    static let headerViewHeight: CGFloat = 332.5 // HeaderView의 height 설정 값
    static let navigationViewHeight: CGFloat = 80 // NavigationView의 height 설정 값
}

final class MenuViewController: UIViewController {
    
    // MenuViewController 변수
    // Navigation 관련
    @IBOutlet private weak var navigationView: UIView! // Navigation View
    @IBOutlet private weak var navigationTitle : UILabel! // Navigation Title
    @IBOutlet private weak var backButton: UIButton! // 이전 페이지로 이동
    
    // TableView 관련
    @IBOutlet private weak var menuList : UITableView! // menuList tableView
    var headerView: MenuHeaderView! // menuList의 headerView
    var gradient: CAGradientLayer! // menuList의 headerView의 그라데이션
    
    var restaurantInfomation: Restaurant!
    var restaurantId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = readLine()!
        print(input.self)
        
        
        
        
        MainGet.getRestaurantList { rest in
            self.restaurantInfomation = rest[0]
        }
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        setNavigation()
        setMenuList()
        setHeaderView()
        setGradient()
        
    }
    
    // Navigation 관련 설정
    func setNavigation() {
        
        // navigationView의 위치 설정
        self.navigationView.frame.origin.y = -SetSize.navigationViewHeight
        
        // backbutton 설정
        // tintColor 적용을 위한 설정 withRenderingMode(.alwaysTemplate)
        let backImage = UIImage(named: "btnBack")?.withRenderingMode(.alwaysTemplate) // Button Image 삽입
        backButton.setImage(backImage, for: .normal) // backImage 추가
        backButton.tintColor = .white // tintColor white 설정
        navigationTitle.text = restaurantInfomation.name // navigation title ( 음식점 명 삽입 )
        
    }
    
    // MenuList의 TableView 설정
    func setMenuList() {
        
        menuList.backgroundColor = .white // 테이블뷰의 배경 색
        
        // 사용할 xib 등록
        // ImageMenuListCell xib
        menuList.register(
            UINib(nibName: "ImageMenuListCell", bundle: nil),
            forCellReuseIdentifier: "ImageMenuListCell")
        
        // NonImageMenuList xib
        menuList.register(
            UINib(nibName: "NonImageMenuListCell", bundle: nil),
            forCellReuseIdentifier: "NonImageMenuListCell")
        
        headerView = menuList.tableHeaderView as! MenuHeaderView // 헤더뷰 설정
        menuList.tableHeaderView = nil // 테이블뷰 자체 헤더뷰 nil
        menuList.rowHeight = UITableViewAutomaticDimension // 테이블뷰의 rowHeight값을 custom 하게 설정
        menuList.addSubview(headerView) // 테이블뷰에 헤더뷰 addSubView
        
        //테이블 뷰의 content In/Off set 적용
        menuList.contentInset = UIEdgeInsetsMake(SetSize.headerViewHeight, 0, 0, 0)
        menuList.contentOffset = CGPoint(x: 0, y: -SetSize.headerViewHeight)
        
        setHeaderFrame()
        
    }
    
    // 테이블 뷰 헤더뷰 생성
    func setHeaderView() {
        
        headerView.setTitle = restaurantInfomation.name
        headerView.setDeliveryTime = String(restaurantInfomation.minDeliveryTime) + "분-" +
                                  String(restaurantInfomation.maxDeliveryTime) + "분"
        
    }
    
    //테이블뷰의 contentOffset의 값에 따라 headerViewFrame설정
    func setHeaderFrame() {
        // 초기 getHeaderViewFrame 값
        var getHeaderViewFrame = CGRect(x: 0, y: -SetSize.headerViewHeight, width: menuList.bounds.width,
                                        height: SetSize.headerViewHeight)
        // 테이블뷰의 contentOffset.y가 headerViewHeight의 값보다 작을 때
        if menuList.contentOffset.y < -SetSize.headerViewHeight {
            // 테이블 뷰의 위치가 점점 아래로 내려간다.
            getHeaderViewFrame.origin.y = menuList.contentOffset.y
            // getHeaderView의 크기가 점점 커진다. (menuList.contentOffset.y은 원래 minus값이므로 -를 주면 양수로 바뀐다)
            getHeaderViewFrame.size.height = -menuList.contentOffset.y
        } else if menuList.contentOffset.y > -headerView.mainImage.frame.maxY {
            UIView.animate(withDuration: 0.3) {
                self.navigationView.frame.origin.y = 0
                self.backButton.tintColor = .black
                UIApplication.shared.statusBarStyle = .default
            }
        } else if menuList.contentOffset.y < -headerView.mainImage.frame.maxY {
            UIView.animate(withDuration: 0.3) {
                self.navigationView.frame.origin.y = -80
                self.backButton.tintColor = .white
                UIApplication.shared.statusBarStyle = .lightContent
            }
        }
        setNeedsStatusBarAppearanceUpdate()
        //변경된 값을 헤더 뷰의 프레임에 업데이트 시켜준다.
        headerView.frame = getHeaderViewFrame
    }
    
    func setGradient() {
        headerView.titleView.layer.cornerRadius = 4
        headerView.titleView.layer.shadowColor = UIColor.black.cgColor
        headerView.titleView.layer.shadowOpacity = 0.1
        headerView.titleView.layer.shadowOffset = CGSize.zero
        headerView.titleView.layer.shadowRadius = 7
        
        gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: headerView.frame.origin.y, width: self.view.bounds.width, height: headerView.mainImage.bounds.height / 2)
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.01]
        
        headerView.gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
}

// MARK: extension TableView
// UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let menuCount = restaurantInfomation.menuList?.count else { return 0 }
        return menuCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let menuImage = restaurantInfomation.menuList?[indexPath.row].foodImage else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NonImageMenuListCell") as! NonImageMenuListCell
            cell.setName = restaurantInfomation.menuList?[indexPath.row].foodName
            cell.setDescription = restaurantInfomation.menuList?[indexPath.row].foodDescription
            cell.setPrice = "₩" + String(restaurantInfomation.menuList![indexPath.row].price)

            return cell

        }
        
        if let menuImage = imagePost.imageDownload(stringURL: menuImage) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageMenuListCell") as! ImageMenuListCell
            cell.setImage = menuImage
            cell.setName = restaurantInfomation.menuList?[indexPath.row].foodName
            cell.setDescription = restaurantInfomation.menuList?[indexPath.row].foodDescription
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

// UITableViewDelegate
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
