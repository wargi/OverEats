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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpButton.layer.borderWidth = 1
        self.signUpButton.layer.cornerRadius = 3
    }
    
    // Id와 passWord
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // 이전 화면으로 dismiss 하는 버튼
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        //회원가입 첫 페이지 약관부분으로 넘어가기
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ToSViewController") as! ToSViewController
        present(nextViewController, animated: true, completion: nil)
    }
    
    // 완료 버튼
    @IBAction func completeButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else { return }
        
        PostService.signIn(email: email, password: password) { (result) in
            switch result {
            case .success(let userData):
                
                UserManager.setUser = userData
                UserDefaults.standard.set("\(userData.token)", forKey: "userToken")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nextViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                self.present(nextViewController, animated: true, completion: nil)
                
            case .error(let error):
                self.showAlert(alertTitle: "로그인 정보 오류", alertMessage: "Email과 Password를 확인 후 다시 로그인 해주십시오.", actionTitle: "확인")
                print(error.localizedDescription)
            }
        }
        
    }
}
