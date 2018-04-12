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
    var restaurants: [Restaurant]?
    var nearRestaurants: [Restaurant]?
    var prefRestaurants: [Restaurant]?
    
    var listStatusBits: UInt8 = 0b000
    
    @IBOutlet weak private var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRestaurantData()
        
        getNoticeData()
        
        mainTableView.register(
            UINib(nibName: "MainListHeaderCell", bundle: nil),
            forCellReuseIdentifier: "MainListHeaderCell"
        )
//
//        mainTableView.contentInset = UIEdgeInsetsMake(0, 0, -10, 0)
        self.mainTableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        self.mainTableView.estimatedSectionHeaderHeight = 10;
    }
    
    private func getNoticeData(){
        
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.backgroundColor = .lightGray
        
        let noticeView = Bundle.main.loadNibNamed("\(NoticeView.self)", owner: nil, options: nil)!.first as! NoticeView
        
        // noticeView를 headerView로 정의
        self.mainTableView.setTableHeaderView(headerView: noticeView)
        
        MainGet.getNotice(completionHandler: { notices in
            noticeView.setNoticePage(with: notices)
        })
        
    }
    
    func getRestaurantData(){        MainGet.getRestaurantList { restaurants in
            self.restaurants = restaurants
        }
        
        if let restaurants = self.restaurants {
            listStatusBits = listStatusBits | 0b001
            for (index, restaurant) in restaurants.enumerated() {
                let url = URL(string: restaurant.imageURL)
                self.restaurants![index].imageData = try? Data(contentsOf: url!)
                if restaurant.isOpen, restaurant.maxDeliveryTime >= 25 {
                    listStatusBits = listStatusBits | 0b010
                    nearRestaurants?.append(restaurant)
                }else if restaurant.isOpen, restaurant.score! >= Float(4.0) {
                    listStatusBits = listStatusBits | 0b100
                    prefRestaurants?.append(restaurant)
                }
            }
        }
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func layoutRestaurantCell(with restaurant: Restaurant) -> UITableViewCell{
        
        let tempCell = UITableViewCell()
        
        let mainRestView = MainRestView.loadMainRestNib()
        tempCell.addSubview(mainRestView)
        mainRestView.translatesAutoresizingMaskIntoConstraints = false
        mainRestView.configure(with: restaurant)
        
        mainRestView.topAnchor.constraint(equalTo: tempCell.topAnchor, constant: 0).isActive = true
        mainRestView.leadingAnchor.constraint(equalTo: tempCell.leadingAnchor, constant: 15).isActive = true
        mainRestView.trailingAnchor.constraint(equalTo: tempCell.trailingAnchor, constant: -15).isActive = true
        mainRestView.bottomAnchor.constraint(equalTo: tempCell.bottomAnchor, constant: -15).isActive = true
        
        return tempCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        if listStatusBits == 1 {
//            return 1
//        } else if listStatusBits == 7 {
//            return 3
//        } else {
//            return 2
//        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        if section == 1 {
            print("tt", section)
            return 0
        }else {
            print("sddas")
            return (restaurants?.count)!
        }
        
//        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let mainHeaderInSection = MainHeaderInSection.loadMainHeaderInSectionNib()
        mainHeaderInSection.headerLabel.text = "레스토랑 더 보기"
        return mainHeaderInSection
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return layoutRestaurantCell(with: self.restaurants![indexPath.row])

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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
//        let nextViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
//        nextViewController.restaurantInfomation =
//        self.present(nextViewController, animated: true, completion: nil)
//    }
}
