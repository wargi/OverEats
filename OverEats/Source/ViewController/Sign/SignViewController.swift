//
//  SignViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 2..
//  Copyright © 2018년 taewoong bae. All rights reserved.
//

import UIKit
import Alamofire
class SignViewController: UIViewController {
    @IBOutlet weak var roundView: UIView!
    
    var token:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundView.layer.cornerRadius = roundView.frame.size.height/6
 
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        
        let  params: Parameters = [
            "username" : "over@naver.com",
            "password" : "qwe12"
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
                        
                        //                        self.performSegue(withIdentifier: "다음페이지", sender: nil)
                        
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
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ToSViewController") as! ToSViewController
        present(nextViewController, animated: true, completion: nil)
        
    }

}
