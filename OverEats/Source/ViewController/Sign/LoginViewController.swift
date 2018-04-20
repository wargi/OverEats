//
//  LoginViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 13..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    var token:String! // 토큰 값
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Id와 passWord
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passWordLoginTextField: UITextField!
    
    // 완료 버튼
    @IBAction func completeButton(_ sender: UIButton) {
        
        // textField에 입력한 값을 서버에 보내기 위한 준비
        let  params: Parameters = [
            "username" : emailLoginTextField.text!,
            "password" : passWordLoginTextField.text!
        ]
        
        
        Alamofire
            .request("https://www.overeats.kr/api/login/", method: .post, parameters: params)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(_):
                    
                    do{
                        
                        // 회원 정보 받아오기
                        let json = response.data
                        var jsondata = try JSONSerialization.jsonObject(with: json!) as! [String:Any]
                        
                        // 토큰 값 저장
                        self.token = jsondata["token"] as! String
                        
                        // 이동할 페이지 이름적기
                        // self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        
                        // 데이터 저장
                        UserDefaults.standard.set("\(self.token)", forKey: "userToken")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                        self.present(nextViewController, animated: true, completion: nil)
                        
                    } catch {
                        
                        // 경고 창 띄우기
                        self.showAlert(alertTitle: "실패", alertMessage: "로그인 실패", actionTitle: "확인")
                        
                    }
                case .failure(_):
                    
                    // 걍고 창 띄우기
                    self.showAlert(alertTitle: "실패", alertMessage: "로그인 실패", actionTitle: "확인")
                    
                }
        }
    }
}
