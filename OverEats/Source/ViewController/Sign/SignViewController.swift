//
//  SignViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 2..
//  Copyright © 2018년 taewoong bae. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {
    
    @IBOutlet weak var roundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //라운드 값 주기
        roundView.layer.cornerRadius = roundView.frame.size.height/6
        
    }
    
    //로그인 버튼
    @IBAction func signInButton(_ sender: UIButton) {
        
        //로그인 페이지로 넘어가기
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(nextViewController, animated: true, completion: nil)
        
    }
    
    //회원가입 버튼
    @IBAction func signUpButton(_ sender: UIButton) {
        
        //회원가입 첫 페이지 약관부분으로 넘어가기
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ToSViewController") as! ToSViewController
        present(nextViewController, animated: true, completion: nil)
        
    }
    
}
