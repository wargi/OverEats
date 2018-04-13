//
//  SettingViewController.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 11..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

struct tableViewSize {
    static let cellSize:CGFloat = 60
}

final class SettingViewController: UIViewController {

    @IBOutlet private weak var settingTableView : UITableView!
    @IBOutlet private weak var headerView : SettingHeaderView!
    let firstName = "상욱"
    let lastName = "박"
    
    let cellImage = [UIImage(named: "icSettingListLike"), UIImage(named: "icSettingListPayment"),
                     UIImage(named: "icSettingListCustomer"), UIImage(named: "icSettingListSetting"),
                     UIImage(named: "icSettingListInvite")]
    let cellTitle = ["즐겨찾기","결제","고객지원","설정","정보"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.bounds.size.height = tableViewSize.cellSize * CGFloat(cellImage.count)
        settingTableView.register(UINib(nibName: "SettingCell", bundle: nil),
                                  forCellReuseIdentifier: "SettingCell")
        
        headerView = settingTableView.tableHeaderView as! SettingHeaderView
//        settingTableView.tableHeaderView = nil
        settingTableView.rowHeight = UITableViewAutomaticDimension
        settingTableView.separatorStyle = .none
        
        settingTableView.addSubview(headerView)
        
        headerView.image = nil 
        headerView.userName = firstName + " " + lastName
        
        tableViewSetting()
    }
    
    func tableViewSetting() {
        
        
        
//        settingTableView.footerView(forSection: 1)
        
        
        
    }



}




extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableViewSize.cellSize
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(cellImage.count)
        return cellImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
        cell.setImage = cellImage[indexPath.row]
        cell.setText = cellTitle[indexPath.row]
        
        return cell
    }

}

extension SettingViewController: UITableViewDelegate {
    
}
