//
//  SelectMenuViewController.swift
//  OverEats
//
//  Created by 박상욱 on 2018. 4. 2..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

final class SelectMenuViewController: UIViewController {

    var menuInfo: Section.Menu!
    @IBOutlet private weak var scrollView : UIScrollView! // 스크롤 뷰
    @IBOutlet private weak var selectMenuView : UIView! // 콘텐츠 뷰
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var closeButton : UIButton!
    
    // 음식 관련
    @IBOutlet private weak var menuImageView: UIImageView? // 음식 이미지
    @IBOutlet private weak var menuName: UILabel! // 음식 이름
    @IBOutlet private weak var menuDescription : UILabel! // 음식 설명
    var price: Int! // 음식 가격
    
    // 스테퍼 관련
    @IBOutlet private weak var stepperView: UIView! // 커스텀 스테퍼
    @IBOutlet private weak var count: UILabel! // 스테의 카운트 값
    
    
    // 장바구니 관련
    @IBOutlet private weak var resultPriceView: UIView! // 장바구니 뷰
    @IBOutlet private weak var menuCount: UILabel! // 장바구니의 메뉴 개수
    @IBOutlet private weak var totalPrice: UILabel! // 장바구니의 총 가격
    
    // 요청 사항 관련
    @IBOutlet weak var requestLabel: UILabel!
    let defaultString: String = "추가로 요청할 사항이 있을시 적어주세요(소스 추가, 양파 빼기 등)"
    
    var restaurantId: String!
    var restaurantName: String!
    var restaurantURL: String!
    var deliveryTime: EtaRange!
    
    @IBOutlet weak var gradientView: UIView!
    
    // 제스쳐
    var pan: UIPanGestureRecognizer! // Pan Gesture 스크롤 DissMiss
    var requestTap: UITapGestureRecognizer! // Request Tap Gesture 요청사항 작성 이벤트
    var cartAddTap: UITapGestureRecognizer! // Cart Add Tap Gesture
    @IBOutlet weak var menuImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        closeButton.setImage(UIImage(named: "btnClose")?.withRenderingMode(.alwaysTemplate),
                             for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(self.clickedCloseButton(_:)), for: .touchUpInside)
        
        if menuImageView?.image == nil {
            UIApplication.shared.statusBarStyle = .default
            closeButton.tintColor = .black
        }
        
        configure()
        setStatusAndBtnColor()
        gestureCreate()
        requestReflecting()
        setStepper()
        setGradient()
    }
    
    func configure() {
        
        menuName.text = menuInfo.name
        menuDescription.text = menuInfo.description
        if menuInfo.imageURL != "" {
            menuImageView?.loadImageUsingCacheWithUrl(urlString: menuInfo.imageURL,
                                                      completion: { _ in })
        } else {
            menuName.text = "\n" + menuName.text!
            gradientView.alpha = 0
            
        }
        self.price = menuInfo.price
        
    }
    
    func setStatusAndBtnColor() {
        UIApplication.shared.statusBarStyle = .lightContent
        
        if menuImageView?.image == nil {
            UIApplication.shared.statusBarStyle = .default
            closeButton.tintColor = .black
            
        }
        closeButton.setImage(UIImage(named: "btnClose")?.withRenderingMode(.alwaysTemplate),
                             for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(self.clickedCloseButton(_:)), for: .touchUpInside)
    }
    
    func setGradient() {
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.frame = CGRect(x: 0, y: 0, width: gradientView.bounds.width, height: gradientView.bounds.height / 3)
        gradient.locations = [0.01]
        
        gradientView.layer.addSublayer(gradient)
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
        
        requestTap = UITapGestureRecognizer(target: self, action: #selector(self.requestTapAction(_:)))
        self.requestLabel.addGestureRecognizer(requestTap)
        
        cartAddTap = UITapGestureRecognizer(target: self, action: #selector(self.cartAddTapAction(_:)))
        self.resultPriceView.addGestureRecognizer(cartAddTap)
        
    }
    
    // Pan 제스쳐 액션
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: scrollView)
        let translation = sender.translation(in: scrollView)
        
        guard abs(velocity.y) > abs(velocity.x) else { return }
        switch sender.state {
        case .began:
            self.scrollView.frame.origin = CGPoint.zero
        case .changed:
            if translation.y > 0 {
                scrollView.frame.origin.y = translation.y
            }
        case .ended:
            if scrollView.frame.origin.y > 150 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.scrollView.frame.origin = CGPoint.zero
                }
            }
        case .failed, .cancelled:
            UIView.animate(withDuration: 0.3) {
                self.scrollView.frame.origin = CGPoint.zero
            }
        case .possible:
            UIView.animate(withDuration: 0.3) {
                self.scrollView.frame.origin = CGPoint.zero
            }
            break
        }

    }
    
    // Tap 제스쳐 액션
    @objc func requestTapAction(_ sender: UITapGestureRecognizer) {
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "Request") as! RequestViewController
        
        nextViewController.notiKey = "menu"
        nextViewController.requestText = requestLabel.text != defaultString ? requestLabel.text! : ""
        nextViewController.modalPresentationStyle = .overCurrentContext
        
        present(nextViewController, animated: true)
    }
    
    func cartAdd() {
        let count: Int = Int(self.count.text!)!
        let sumPrice: Int = price * count
        
        CartManager.restaurantId = self.restaurantId
        CartManager.restaurantName = self.restaurantName
        CartManager.restaurantURL = self.restaurantURL
        CartManager.deliveryTime = self.deliveryTime
        CartManager.cartList.append(CartMenu(id: menuInfo.id, name: menuInfo.name, price: menuInfo.price,
                                             description: menuInfo.description, imageURL: menuInfo.imageURL,
                                             totalPrice: sumPrice, count: count,
                                             comment: requestLabel.text!))
    }
    
    func cartReset() {
        CartManager.cartList = []
    }
    
    @objc func cartAddTapAction(_ sender: UITapGestureRecognizer) {
        if CartManager.restaurantId == nil {
            cartAdd()
            self.dismiss(animated: true, completion: nil)
        } else if CartManager.restaurantId != restaurantId {
            let alertViewController = UIAlertController(title: "장바구니를 새로 열까요?",
                                                        message: "이미 장바구니에 다른 음식점의 메뉴가 있습니다. 장바구니를 비우고 이 메뉴를 대신 추가하시겠습니까?",
                                                        preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "새 장바구니", style: .default) { _ in
                self.cartReset()
                self.cartAdd()
                self.dismiss(animated: true, completion: nil)
            }
            
            alertViewController.addAction(okAction)
            alertViewController.addAction(cancelAction)
            self.present(alertViewController, animated: true, completion: nil)
            
        } else {
            cartAdd()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    //MARK: 스테퍼 관련
    func setStepper() {
        stepperView.layer.cornerRadius = 25
        stepperView.layer.borderWidth = 0.3
        
        totalPrice.text! = "₩" + String(price)
    }
    
    
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
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "menu"), object: nil, queue: nil) { [weak self] (noti) in
            
            if self?.defaultString != noti.object as? String {
                self?.requestLabel.text = noti.object as? String
                self?.requestLabel.font = .systemFont(ofSize: 13)
                self?.requestLabel.textColor = .black
            } else {
                self?.requestLabel.text = noti.object as? String
                self?.requestLabel.font = .systemFont(ofSize: 12)
                self?.requestLabel.textColor = .lightGray
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
