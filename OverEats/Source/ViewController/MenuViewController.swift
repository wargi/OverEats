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
    @IBOutlet private weak var restaurantName : UILabel!
    @IBOutlet private weak var categori : UILabel!
    @IBOutlet private weak var cookingTime : UILabel!
    @IBOutlet private weak var search : UIButton!
    @IBOutlet private weak var menuList : UITableView!
    @IBOutlet private weak var restaurantImage : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.backgroundColor = .red
        
        return cell!
    }
    
    
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SelectMenu", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "SelectMenu") as! SelectMenuViewController
        nextViewController.price = 7000
        present(nextViewController, animated: true, completion: nil)
    }
}
