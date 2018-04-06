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
    @IBOutlet weak var titleView: UIView!
    @IBOutlet private weak var restaurantName : UILabel!
    @IBOutlet private weak var categori : UILabel!
    @IBOutlet private weak var cookingTime : UILabel!
    @IBOutlet private weak var search : UIButton!
    @IBOutlet private weak var menuList : UITableView!
    @IBOutlet private weak var restaurantImage : UIImageView!
    
    //pan 제스쳐
    var pan: UIPanGestureRecognizer!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    var defaultBottomConstant: CGFloat!
    var defaultSide: CGFloat!
    var defaultTitleHeight: CGFloat!
    
    //레이아웃
    @IBOutlet weak var restaurantImageBottom: NSLayoutConstraint!
    @IBOutlet weak var titleViewleft: NSLayoutConstraint!
    @IBOutlet weak var titleViewRight: NSLayoutConstraint!
    @IBOutlet weak var titleViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultBottomConstant = bottom.constant
        defaultSide = titleViewleft.constant
        defaultTitleHeight = titleViewHeight.constant
        
        
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(_:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        let velocity = pan.velocity(in: self.view)
        let transition = pan.translation(in: self.view)
        
        print(transition.y)
//        let changeY = restaurantImage.frame.origin.y + transition.y
//        restaurantImage.frame.origin = CGPoint(x: 0, y: changeY)
        
        
        if abs(velocity.y) > abs(velocity.x) {
            if velocity.y < 0 {
                print("up")
                if transition.y < 0 && bottom.constant != defaultBottomConstant {
                    print("1")
                    bottom.constant += 4
                } else if transition.y < 0  {
                    
                    titleViewleft.constant -= titleViewleft.constant > 0 ? 0.5 : 0
                    titleViewRight.constant -= titleViewRight.constant > 0 ? 0.5 : 0
                    titleViewHeight.constant -= titleViewHeight.constant > 80 ? 3 : 0
//                    restaurantImageBottom.constant += 1
                    categori.alpha -= 0.03
                    cookingTime.alpha -= 0.03
                    
                } else if transition.y == 0 {
                    bottom.constant = defaultBottomConstant
                    titleViewleft.constant = defaultSide
                    titleViewRight.constant = defaultSide
                    titleViewHeight.constant = defaultTitleHeight
                }
            } else {
                print("down")
                if transition.y > 0 {
                    bottom.constant -= 4
                } else if transition.y == 0 {
                    bottom.constant = defaultBottomConstant
                }
                
                
            }
        }
        
        pan.setTranslation(CGPoint.zero, in: restaurantImage)
//        print(transition)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
    }
    
    
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "SelectMenu") as! SelectMenuViewController
        nextViewController.price = 7000
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
}

// UIGestureRecognizerDelegate
extension MenuViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            
            return true
    }
}
