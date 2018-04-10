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
    
    @IBOutlet private var noticeView: UIView!
    @IBOutlet private var noticeScrollView: UIScrollView!
    
    @IBOutlet private var noticePageControl: UIPageControl!
    
    @IBAction func testBtn(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noticeScrollView.delegate = self
        
        getNoticeData()
        
        getRestaurantData()
        

    }
    
    func getRestaurantData(){
        MainGet.getRestaurantList { restaurants in
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
    
    func layoutRestaurantCell(with restaurant: Restaurant) -> UITableViewCell{
        
        let tempCell = UITableViewCell()
        
        let mainRestView = MainRestView.loadMainRestNib()
        tempCell.addSubview(mainRestView)
        mainRestView.translatesAutoresizingMaskIntoConstraints = false
        mainRestView.configure(with: restaurant)
        
        mainRestView.topAnchor.constraint(equalTo: tempCell.topAnchor, constant: 15).isActive = true
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
        return 1
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
        return (restaurants?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
//        let nextViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
//        nextViewController.restaurantInfomation =
//        self.present(nextViewController, animated: true, completion: nil)
//    }
}
