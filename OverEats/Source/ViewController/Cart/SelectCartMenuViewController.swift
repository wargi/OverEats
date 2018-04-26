//
//  SelectCartMenuViewController.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 24..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class SelectCartMenuViewController: UIViewController {
    
    @IBOutlet private weak var scrollView : UIScrollView! // 스크롤 뷰
    @IBOutlet private weak var selectMenuView : UIView! // 콘텐츠 뷰
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
    
    var cartMenuNumber: Int!
    var restaurantId: String!
    var restaurantName: String!
    var restaurantURL: String!
    var deliveryTime: EtaRange!
    
    @IBOutlet private weak var gradientView : UIView!
    
    // 제스쳐
    var requestTap: UITapGestureRecognizer! // Request Tap Gesture 요청사항 작성 이벤트
    var cartAddTap: UITapGestureRecognizer! // Cart Add Tap Gesture
    
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
        
        menuName.text = CartManager.cartList[cartMenuNumber].name
        menuDescription.text = CartManager.cartList[cartMenuNumber].description
        requestLabel.text = CartManager.cartList[cartMenuNumber].comment
        
        if CartManager.cartList[cartMenuNumber].imageURL != "" {
            menuImageView?.loadImageUsingCacheWithUrl(urlString: CartManager.cartList[cartMenuNumber].imageURL,
                                                      completion: { _ in })
        } else {
            menuName.text = "\n" + menuName.text!
            gradientView.alpha = 0
        }
        self.price = CartManager.cartList[cartMenuNumber].price
        self.count.text = String(CartManager.cartList[cartMenuNumber].count)
        
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
    
    @objc func clickedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: 제스쳐 관련
    // 제스쳐 생성
    func gestureCreate() {
        
        requestTap = UITapGestureRecognizer(target: self, action: #selector(self.requestTapAction(_:)))
        self.requestLabel.addGestureRecognizer(requestTap)
        
        cartAddTap = UITapGestureRecognizer(target: self, action: #selector(self.cartAddTapAction(_:)))
        self.resultPriceView.addGestureRecognizer(cartAddTap)
        
    }
    
    // Tap 제스쳐 액션
    @objc func requestTapAction(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "Request") as! RequestViewController
        
        nextViewController.notiKey = "menu"
        nextViewController.requestText = requestLabel.text != defaultString ? requestLabel.text! : ""
        nextViewController.modalPresentationStyle = .overCurrentContext
        
        present(nextViewController, animated: true)
    }
    
    func cartAdd() {
        let count: Int = Int(self.count.text!)!
        let sumPrice: Int = price * count

        CartManager.cartList[cartMenuNumber].count = count
        CartManager.cartList[cartMenuNumber].totalPrice = sumPrice
        CartManager.cartList[cartMenuNumber].comment = requestLabel.text!
    }
    
    @objc func cartAddTapAction(_ sender: UITapGestureRecognizer) {
        
        cartAdd()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: 스테퍼 관련
    func setStepper() {
        stepperView.layer.cornerRadius = 25
        stepperView.layer.borderWidth = 0.3
        
        totalPrice.text! = "₩" + String(CartManager.cartList[cartMenuNumber].totalPrice)
    }
    
    
    // 스테퍼의 음식 개수 감소
    @IBAction func selectMenuMinus(_ sender: UIButton) {
        guard var count: Int = Int(count.text!) else { return }
        guard count > 1 else { return }
        
        count -= 1
        
        self.count.text = String(count)
        totalPrice.text = "₩" + String(price * count)
        
    }
    
    // 스테퍼의 음식 개수 증가
    @IBAction func selectMenuPlus(_ sender: UIButton) {
        guard var count: Int = Int(count.text!) else { return }
        
        count += 1
        
        self.count.text = String(count)
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
    
    func setGradient() {
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.frame = CGRect(x: 0, y: 0, width: gradientView.bounds.width, height: gradientView.bounds.height / 3)
        gradient.locations = [0.01]
        
        gradientView.layer.addSublayer(gradient)
    }
}

// UIGestureRecognizerDelegate
extension SelectCartMenuViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            
            return true
    }
}
