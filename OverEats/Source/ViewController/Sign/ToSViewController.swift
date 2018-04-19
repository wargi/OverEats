//
//  ToSViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class ToSViewController: UIViewController {
    
    // 이용약관 버튼
    @IBOutlet weak var TosButton: UIButton! // 첫번째 약관
    @IBOutlet weak var PIPButton: UIButton! // 두번째 약관
    @IBOutlet weak var OptionButton: UIButton! // 선택 약관
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 버튼 관련 이벤트 처리
        TosButton.addTarget(self, action: #selector(self.clickedButton(_:)), for: .touchUpInside)
        PIPButton.addTarget(self, action: #selector(self.clickedButton(_:)), for: .touchUpInside)
        OptionButton.addTarget(self, action: #selector(self.clickedButton(_:)), for: .touchUpInside)
        
    }
    
    // 버튼 클릭 이벤트
    @objc func clickedButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            //            sender.setImage(UIImage(named: "nil"), for: .normal)
        } else {
            sender.isSelected = true
            //            sender.setImage(UIImage(named: "Check"), for: .selected)
        }
    }
    
    // 전체 선택 이벤트
    @IBAction func allTrue(_ sender: UIButton) {
        
        TosButton.isSelected = true
        PIPButton.isSelected = true
        OptionButton.isSelected = true
        
        //        TosButton.setImage(UIImage(named: "Check"), for: .selected)
        //        PIPButton.setImage(UIImage(named: "Check"), for: .selected)
        //        OptionButton.setImage(UIImage(named: "Check"), for: .selected)
    }
    
    // 다음 버튼 이벤트
    @IBAction func nextButton(_ sender: UIButton) {
        
        // 필수 약관 2개 선택이 아닐경우
        guard TosButton.isSelected && PIPButton.isSelected else {
            
            // 경고 창 띄우기
            showAlert(alertTitle: "필수 약관 체크", alertMessage: "필수 약관 체크", actionTitle: "확인")
            
            return
            
        }
        
        // 필수 약관 2개 선택 시 다음 view로 이동
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "CreateIDViewController") as! CreateIDViewController
        present(nextViewController, animated: true, completion: nil)
        
    }
    
}

extension UIViewController {
    
    func showAlert (alertTitle: String, alertMessage: String, actionTitle: String) {
        
        // 경고 창 띄우기
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default)
        alertController.addAction(okAction) // 확인
        
        self.present(alertController,animated: true,completion: nil)
        
    }
    
}

