//
//  SelectMenuViewController.swift
//  OverEats
//
//  Created by 박상욱 on 2018. 4. 2..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

final class SelectMenuViewController: UIViewController {

    @IBOutlet weak var scrollView : UIScrollView! // 스크롤 뷰
    @IBOutlet weak var selectMenuView : UIView! // 콘텐츠 뷰
    @IBOutlet weak var backView: UIView!
    @IBOutlet private weak var closeButton : UIButton!
    @IBOutlet weak var menuNameTopConstraint: NSLayoutConstraint!
    
    // 음식 관련
    @IBOutlet weak var menuImageView: UIImageView? // 음식 이미지
    @IBOutlet weak var menuName: UILabel! // 음식 이름
    @IBOutlet weak var menuDescription : UILabel! // 음식 설명
    var price: Int! // 음식 가격
    
    // 스테퍼 관련
    @IBOutlet weak var stepperView: UIView! // 커스텀 스테퍼
    @IBOutlet weak var count: UILabel! // 스테의 카운트 값
    
    // 장바구니 관련
    @IBOutlet weak var resultPriceView: UIView! // 장바구니 뷰
    @IBOutlet weak var menuCount: UILabel! // 장바구니의 메뉴 개수
    @IBOutlet weak var totalPrice: UILabel! // 장바구니의 총 가격
    
    // 요청 사항 관련
    @IBOutlet weak var requestLabel: UILabel!
    let defaultString: String = "음식 조리 시 요청할 사항을 적어주세요(소스 추가, 양파 빼기 등)"
    
    // 제스쳐
    var pan: UIPanGestureRecognizer! // Pan Gesture 스크롤 DissMiss
    var tap: UITapGestureRecognizer! // Tap Gesture 요청사항 작성 이벤트
    
    
    // 네비게이션
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet private weak var navigationTitle : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        closeButton.setImage(UIImage(named: "btnClose")?.withRenderingMode(.alwaysTemplate),
                             for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(self.clickedCloseButton(_:)), for: .touchUpInside)
        
        if menuImageView?.image == nil {
            UIApplication.shared.statusBarStyle = .default
            menuImageView?.frame.size.height = 0
            menuNameTopConstraint.constant = menuNameTopConstraint.constant * 2.6
            closeButton.tintColor = .black
        }
        
        gestureCreate()
        requestReflecting()
        
        stepperView.layer.cornerRadius = 25
        stepperView.layer.borderWidth = 0.3
        
        totalPrice.text! = "₩" + String(price)

    }
    
    @objc func clickedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: 제스쳐 관련
    // 제스쳐 생성
    func gestureCreate() {
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(_:)))
        pan.delegate = self
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.selectMenuView.addGestureRecognizer(pan)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        self.requestLabel.addGestureRecognizer(tap)
        
    }
    
    // Pan 제스쳐 액션
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: scrollView)
        let translation = sender.translation(in: scrollView)
        
        guard abs(velocity.y) > abs(velocity.x) else { return }
        
        if translation.y > 0 {
            scrollView.frame.origin.y = translation.y
            
            self.backView.alpha = 0.7 - (translation.y / (self.view.bounds.height / 2))
        }
    
        if sender.state == .ended {
            self.backView.alpha = 0
            if scrollView.frame.origin.y > 150 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.scrollView.frame.origin = CGPoint.zero
                }
            }
        }
    }
    
    // Tap 제스쳐 액션
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "Request") as! RequestViewController
        
        nextViewController.requestText = requestLabel.text != defaultString ? requestLabel.text! : ""
        nextViewController.definesPresentationContext = true
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        present(nextViewController, animated: true)
    }
    
    //MARK: 스테퍼 관련
    // 스테퍼의 음식 개수 감소
    @IBAction func selectMenuMinus(_ sender: UIButton) {
        guard var count: Int = Int(count.text!) else { return }
        guard count > 1 else { return }
        
        count -= 1
        
        self.count.text = String(count)
        menuCount.text = "장바구니에 " + String(count) + "개 추가"
        totalPrice.text = "₩" + String(price * count)
        
    }
    
    // 스테퍼의 음식 개수 증가
    @IBAction func selectMenuPlus(_ sender: UIButton) {
        guard var count: Int = Int(count.text!) else { return }
        
        count += 1
        
        self.count.text = String(count)
        menuCount.text = "장바구니에 " + String(count) + "개 추가"
        totalPrice.text = "₩" + String(price * count)
    }
    
    func requestReflecting() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "noti"), object: nil, queue: nil) { (noti) in
            
            if self.defaultString != noti.object as? String {
                self.requestLabel.text = noti.object as? String
                self.requestLabel.font = .systemFont(ofSize: 13)
                self.requestLabel.textColor = .black
            } else {
                self.requestLabel.text = noti.object as? String
                self.requestLabel.font = .systemFont(ofSize: 12)
                self.requestLabel.textColor = .lightGray
            }
        }
    }
}

// UIScrollViewDelegate
extension SelectMenuViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 80 {
            UIView.animate(withDuration: 0.3) {
                self.navigationView.frame.origin.y = 0
                self.closeButton.tintColor = .black
            }
        } else if scrollView.contentOffset.y < 80 {
            UIView.animate(withDuration: 0.3) {
                self.navigationView.frame.origin.y = -80
                self.closeButton.tintColor = .white
            }
        }
    }
}

// UIGestureRecognizerDelegate
extension SelectMenuViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            
        return true
    }
}
