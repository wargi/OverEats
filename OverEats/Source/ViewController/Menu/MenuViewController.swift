//
//  MenuViewController.swift
//  OverEats
//
//  Created by 박상욱 on 2018. 4. 2..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit
//import Alamofire

struct MenuSize {
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
    @IBOutlet private weak var headerView : MenuHeaderView!
    var footerView: UIView!
    
    var sections: [Section]?
    var restaurantInfo: Restaurant!
    
    @IBOutlet private weak var cartView : UIView!
    @IBOutlet private weak var totalSumPrice : UILabel!
    @IBOutlet private weak var totalCount : UILabel!
    @IBOutlet private weak var totalCountView : UIView!
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        totalCount.layer.borderWidth = 1
        totalCount.layer.cornerRadius = 3
        totalCount.layer.borderColor = UIColor.white.cgColor
        tap = UITapGestureRecognizer(target: self, action: #selector(self.cartGo(_:)))
        cartView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
        setNavigation()
        setMenuList()
        setGradient()
        setCartList()
        
    }
    
    func configure() {
        guard CartManager.cartList.count > 0 else {
            cartView.isHidden = true
            return
            
        }
        cartView.isHidden = false
        
        print("=++++++++++++++++++++++++++++")
        var sumCount: Int = 0
        var sumPrice: Int = 0
        for cart in CartManager.cartList {
            sumCount = sumCount + cart.count
            sumPrice = sumPrice + cart.price
        }
        totalCount.text = String(sumCount)
        totalSumPrice.text = "₩" + String(sumPrice)
    }
    
    @objc func cartGo(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func setData(restaurant: Restaurant?) {
        if let rest = restaurant {
            restaurantInfo = rest
        }
        DispatchQueue.global().async {
            GetService.getMenuList(id: self.restaurantInfo.id) { result in
                switch result {
                case .success(let data):
                    self.sections = data
                    self.menuList.reloadData()
                case .error(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    // Navigation 관련 설정
    func setNavigation() {
        // navigationView의 위치 설정
        self.navigationView.frame.origin.y = -MenuSize.navigationViewHeight
        
        // backbutton 설정
        // tintColor 적용을 위한 설정 withRenderingMode(.alwaysTemplate)
        let backImage = UIImage(named: "btnBack")?.withRenderingMode(.alwaysTemplate) // Button Image 삽입
        backButton.setImage(backImage, for: .normal) // backImage 추가
        backButton.tintColor = .white // tintColor white 설정
        backButton.addTarget(self, action: #selector(self.clickedEvent(_:)), for: .touchUpInside)
        navigationTitle.text = restaurantInfo.name // navigation title ( 음식점 명 삽입 )
        
    }
    
    // MenuList의 TableView 설정
    func setMenuList() {
        
        menuList.backgroundColor = .white // 테이블뷰의 배경 색
        menuList.separatorStyle = .none
        
        // 사용할 xib 등록
        // NonImageMenuList xib
        menuList.register(
            UINib(nibName: "MenuListCell", bundle: nil),
            forCellReuseIdentifier: "MenuListCell")
        menuList.tableHeaderView = nil // 테이블뷰 자체 헤더뷰 nil
        menuList.rowHeight = UITableViewAutomaticDimension // 테이블뷰의 rowHeight값을 custom 하게 설정
        menuList.addSubview(headerView)
        
        footerView = menuList.tableFooterView
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: menuList.bounds.width, height: 1))
        footerView.backgroundColor = UIColor(red: 214, green: 214, blue: 214, alpha: 0.9)
        menuList.tableFooterView = nil
        menuList.addSubview(footerView)
        
        //테이블 뷰의 content In/Off set 적용
        menuList.contentInset = UIEdgeInsetsMake(MenuSize.headerViewHeight, 0, 0, 0)
        menuList.contentOffset = CGPoint(x: 0, y: -MenuSize.headerViewHeight)
        
        headerView.configure(with: restaurantInfo)
        
        setHeaderFrame()
        
    }
    
    //테이블뷰의 contentOffset의 값에 따라 headerViewFrame설정
    func setHeaderFrame() {
        // 초기 getHeaderViewFrame 값
        var getHeaderViewFrame = CGRect(x: 0, y: -MenuSize.headerViewHeight, width: menuList.bounds.width,
                                        height: MenuSize.headerViewHeight)
        // 테이블뷰의 contentOffset.y가 headerViewHeight의 값보다 작을 때
        if menuList.contentOffset.y < -MenuSize.headerViewHeight {
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
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.frame = CGRect(x: 0, y: 0, width: headerView.gradientView.bounds.width, height: headerView.gradientView.bounds.height / 3)
        gradient.locations = [0.01]
        
        headerView.gradientView.layer.addSublayer(gradient)
    }
    
    func setCartList() {
        if CartManager.cartList.count > 1 {
            
            
        }
    }
    
    @objc func clickedEvent(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
    
    

// MARK: extension TableView
// UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections?[section].name ?? "제목없음"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections?[section].menuList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = self.sections?[indexPath.section] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuListCell") as! MenuListCell
        cell.configure(with: section.menuList[indexPath.row])

        return cell

    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.systemFont(ofSize: 17)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        header.textLabel?.lineBreakMode = .byWordWrapping
        header.textLabel?.numberOfLines = 1
        header.frame.origin.x = 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 뷰가 스크롤 될 때 마다 HeaderView의 프레임을 변경
        setHeaderFrame()
    }
    
    
}

// UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowInSection = self.sections?[indexPath.section].menuList[indexPath.row] else { return }
        
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "SelectMenu") as! SelectMenuViewController
        nextViewController.menuInfo = rowInSection
        self.definesPresentationContext = false
        nextViewController.modalPresentationStyle = .currentContext
        
        nextViewController.restaurantId = restaurantInfo.id
        nextViewController.restaurantURL = restaurantInfo.logo
        nextViewController.restaurantName = restaurantInfo.name
        nextViewController.deliveryTime = restaurantInfo.etaRange
        
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
