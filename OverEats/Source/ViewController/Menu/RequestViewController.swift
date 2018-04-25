//
//  RequestViewController.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet private weak var requestView : UIView!
    @IBOutlet weak var requestTextView : UITextView!
    var requestText: String?
    var notiKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.alpha = 0.5
        
        requestTextView.becomeFirstResponder()
        requestTextView.text = requestText
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.requestView.frame.origin.y)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.requestTextView.resignFirstResponder()
    }
    
    //MARK: 요청 사항
    @IBAction func request(_ sender: UIButton) {
        
        if let requsetText = self.requestTextView.text, requsetText != "" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.notiKey),
                                            object: requsetText)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.notiKey),
                                            object: "추가로 요청할 사항이 있을시 적어주세요(소스 추가, 양파 빼기 등)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension RequestViewController: UITextFieldDelegate {
    
}


