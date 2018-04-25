//
//  TabBarController.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 25..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewOverTabBar = UIView(frame: CGRect(x: 0, y: -self.tabBar.bounds.height, width: self.tabBar.bounds.width, height: self.tabBar.bounds.height))
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        viewOverTabBar.addGestureRecognizer(tap)
        viewOverTabBar.backgroundColor = UIColor.red
        self.tabBar.addSubview(viewOverTabBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "CartViewController")
        
        self.present(nextViewController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
