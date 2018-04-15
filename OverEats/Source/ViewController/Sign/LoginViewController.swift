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
    
    var token:String!
    
    @IBOutlet weak var emailLoginTextField: UITextField!
   
    @IBOutlet weak var passWordLoginTextField: UITextField!
    
    @IBAction func completeButton(_ sender: UIButton) {
        
        
        let  params: Parameters = [
            "username" : emailLoginTextField.text!,
            "password" : passWordLoginTextField.text!
        ]
        
        
        Alamofire
            .request("https://www.overeats.kr/api/login/", method: .post, parameters: params)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    print("로그인 성공: ", value)
                    do{
                        let json = response.data
                        var jsondata = try JSONSerialization.jsonObject(with: json!) as! [String:Any]
                        self.token = jsondata["token"] as! String
                        print(self.token)
                        
                        //이동할 페이지 이름적기
//                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        
                        // 데이터 저장
                        UserDefaults.standard.set("\(self.token)", forKey: "userToken")
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print("로그인 실패: ", error.localizedDescription)
                    let alertController = UIAlertController(title: "실패",message: "로그인 실패했습니다", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                    alertController.addAction(okAction)
                    self.present(alertController,animated: true,completion: nil)
                }
                
        }
        
        
        let caches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        
        let fileManager = FileManager()
        
        if !fileManager.fileExists(atPath: caches) {
            try? fileManager.createDirectory(atPath: caches,
                                             withIntermediateDirectories: true,
                                             attributes: nil)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}
