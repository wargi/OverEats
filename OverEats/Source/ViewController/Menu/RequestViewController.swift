//
//  RequestViewController.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet weak var requestTextView : UITextView!
    var requestText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTextView.becomeFirstResponder()
        requestTextView.text = requestText
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        requestTextView.resignFirstResponder()
    }
    
    //MARK: 요청 사항
    @IBAction func request(_ sender: UIButton) {
        
        if let requsetText = requestTextView.text, requsetText != "" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "noti"),
                                            object: requsetText)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "noti"),
                                            object: "음식 조리 시 요청할 사항을 적어주세요(소스 추가, 양파 빼기 등)")
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension RequestViewController: UITextFieldDelegate {
    
}
