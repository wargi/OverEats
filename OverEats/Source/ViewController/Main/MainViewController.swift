//
//  ViewController.swift
//  OverEats
//
//  Created by 안솔찬 on 2018. 3. 30..
//  Copyright © 2018년 solchan ahn. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var getService: GetServiceType?
    
    var notices: [Notice]?
    var restaurants: [Lestaurant]?
    var nearRestaurants: [Lestaurant] = []
    var prefRestaurants: [Lestaurant] = []
    
    var listStatusBits: UInt8 = 0b000
    var listNumberOfSection = 0
    
    @IBOutlet weak private var mainTableView: UITableView!
    
//    static func createWith(getService: GetServiceType = GetService()) -> Self {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let `self` = storyboard.instantiateViewController(ofType: self.self)
//        self.getService = getService
//        return self
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRestaurantData()
        getNoticeData()
        
        self.mainTableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: CGFloat.leastNormalMagnitude))
        
        // 섹션 헤더뷰의 기본값 정의
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        self.mainTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        self.mainTableView.estimatedSectionHeaderHeight = CGFloat.leastNormalMagnitude
        
    }
    
    private func getRestaurantData(){
        GetService.getRestaurantList(latitude: 37.524124, longitude: 127.022881, pageSize: 20, searchText: nil, completion: { (result) in
            switch result {
            case .success(let restaurantData):
                self.restaurants = restaurantData.restaurants
            case .error(let error):
                print(error)
            }
            if let restaurants = self.restaurants {
                self.listStatusBits = self.listStatusBits | 0b001
                for restaurant in restaurants {
                    if restaurant.visible == true && restaurant.etaRange.max <= 35 {
                        self.listStatusBits = self.listStatusBits | 0b010
                        self.nearRestaurants.append(restaurant)
                    }
                }
            }
            self.mainTableView.reloadData()
        })
    }
    
    private func getNoticeData() {
        GetService.getNoticeList(completion: { (result) in
            switch result {
            case .success(let noticeData):
                self.notices = noticeData
            case .error(let error):
                print(error)
            }
            self.mainTableView.reloadData()
        })
    }
    
    func tempSender() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if listStatusBits == 1 {
            listNumberOfSection = 1
            return 2
        } else {
            listNumberOfSection = 2
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            if listStatusBits == 1 {
                return restaurants?.count ?? 0
            } else {
                if section == 1 {
                    return 1
                } else {
                    return restaurants?.count ?? 0
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == listNumberOfSection {
//            let mainHeaderInSection = MainHeaderInSection.loadMainHeaderInSectionNib()
//            mainHeaderInSection.headerLabel.text = "레스토랑 더 보기"
//            return mainHeaderInSection
//        }
        if section == 1 {
            let mainHeaderInSection = MainHeaderInSection.loadMainHeaderInSectionNib()
            mainHeaderInSection.headerLabel.text = "가까운 레스토랑"
            return mainHeaderInSection
        } else if section == 2 {
            let mainHeaderInSection = MainHeaderInSection.loadMainHeaderInSectionNib()
            mainHeaderInSection.headerLabel.text = "레스토랑 더 보기"
            return mainHeaderInSection
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == listNumberOfSection {
//            return tableView.sectionHeaderHeight
//        }
        if section == 1 {
            return tableView.sectionHeaderHeight
        } else if section == 2 {
            return tableView.sectionHeaderHeight
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let noticeTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell") as! NoticeTableViewCell
            noticeTableViewCell.notices = notices
            return noticeTableViewCell
        }else{
            if listStatusBits == 1 {
                guard let restaurantData = restaurants?[indexPath.item] else { return UITableViewCell() }
                let restaurantTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell") as! RestaurantTableViewCell
                restaurantTableViewCell.targetView = self
                restaurantTableViewCell.restaurant = restaurantData
                return restaurantTableViewCell
            } else {
                if indexPath.section == 1 {
                    let recommendTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: "RecommendTableViewCell") as! RecommendTableViewCell
                    recommendTableViewCell.targetView = self
                    recommendTableViewCell.restaurants = nearRestaurants
                    return recommendTableViewCell
                } else {
                    guard let restaurantData = restaurants?[indexPath.item] else { return UITableViewCell() }
                    let restaurantTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell") as! RestaurantTableViewCell
                    restaurantTableViewCell.targetView = self
                    restaurantTableViewCell.restaurant = restaurantData
                    return restaurantTableViewCell
                }
            }
        }

//        let emptyCell = UITableViewCell()
//        if listStatusBits == 1 {
//            return (restaurants?.count)!
//        } else if listStatusBits == 2{
//            if section == 0 {
//                return (restaurants?.count)!
//            } else if section == 1 {
//                return (nearRestaurants?.count)!
//            }
//        } else if listStatusBits == 5 {
//            if section == 0 {
//                return (restaurants?.count)!
//            } else if section == 1 {
//                return (prefRestaurants?.count)!
//            }
//        } else if listStatusBits == 7 {
//            if section == 0 {
//                return (restaurants?.count)!
//            } else if section == 1 {
//                return (nearRestaurants?.count)!
//            } else if section == 2 {
//                return (prefRestaurants?.count)!
//            }
//        }
//        return emptyCell
    }

}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

extension MainViewController: RestaurantViewDelegate {
    func tappedView(_ restaurantView: RestaurantView) {
        
//        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
//        let nextViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
//
//        self.definesPresentationContext = true
//        self.modalPresentationStyle = .currentContext
//        //        nextViewController.modalPresentationStyle = .CurrentContext
//        self.present(nextViewController, animated: true, completion: nil)
////        nextViewController.setData(restaurant: restaurant)
        
        self.hidesBottomBarWhenPushed = true

    }
}
