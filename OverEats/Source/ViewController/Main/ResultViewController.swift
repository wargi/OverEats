//
//  ResultViewController.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 25..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var PrepareResultButton: UIButton!
    @IBOutlet weak var pastResultButton: UIButton!
    
    @IBOutlet weak var resultScrollView: UIScrollView!
    
    @IBOutlet weak var prepareCenterPoint: NSLayoutConstraint!
    @IBOutlet weak var pastCenterPoint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pastResultButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.resultScrollView.contentOffset.x = 0
        }
    }
    
    @IBAction func PrepareResultButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.resultScrollView.contentOffset.x = self.view.frame.width
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ResultViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == resultScrollView {
            print(scrollView.contentOffset.x)
            if scrollView.contentOffset.x >= self.view.frame.width / 2 {
                UIView.animate(withDuration: 0.3){
                    self.prepareCenterPoint.priority = UILayoutPriority(rawValue: 950)
                    self.view.layoutIfNeeded()
                }
                
            }else {
                UIView.animate(withDuration: 0.3){
                    self.prepareCenterPoint.priority = UILayoutPriority(rawValue: 850)
                    self.view.layoutIfNeeded()
                }
                
            }
        }
    }
}
