//
//  ViewController.swift
//  OverEats
//
//  Created by 안솔찬 on 2018. 3. 30..
//  Copyright © 2018년 solchan ahn. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction private func btn(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
        MainGet.getRestaurantList { (rest) in
            nextViewController.restaurantInfomation = rest[0]
        }
        present(nextViewController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

