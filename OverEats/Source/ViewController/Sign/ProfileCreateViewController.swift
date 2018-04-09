//
//  ProfileCreateViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit
import Alamofire

class ProfileCreateViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var firstNameTf: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    let picker = UIImagePickerController()
    
    var firstNameCheck:Bool = false
    var lastNameCheck:Bool = false
    
    var signUpDic:[String:Any] = [:]
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        if firstNameCheck == true && lastNameCheck == true {
            
            guard let lastNameText = self.lastNameTf.text else {return}
            signUpDic.updateValue(lastNameText, forKey: "lastname")
            guard let firstNameText = self.firstNameTf.text else {return}
            signUpDic.updateValue(firstNameText, forKey: "firstname")
            
            let params: Parameters = [
                
                "username" : signUpDic["username"] as! String,
                "password" : signUpDic["password"] as! String,
                "first_name" : signUpDic["firstname"] as! String,
                "last_name" : signUpDic["lastname"] as! String,
                "phone_number" : signUpDic["phonenumber"] as! String
                
            ]
            
            Alamofire
                .request("https://www.overeats.kr/api/member/user/", method: .post, parameters: params)
                .validate()
                .responseData { (response) in
                    switch response.result {
                    case .success(let value):
                        print("회원가입 성공: ", value)
                        let alertController = UIAlertController(title: "성공",message: "회원가입 성공했습니다", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                        alertController.addAction(okAction)
                        self.present(alertController,animated: true,completion: nil)
                    case .failure(let error):
                        print("회원가입 실패: ", error.localizedDescription)
                    }
            }
            
            
        }
        if firstNameCheck == false && lastNameCheck == false {
            
            print("\(signUpDic)")
            let alertController = UIAlertController(title: "이름과 성 입력",message: "이름과 성 입력 해주세요", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController,animated: true,completion: nil)
            
        }
        if firstNameCheck == true || lastNameCheck == true {
            
            if lastNameCheck == false {
                
                let alertController = UIAlertController(title: "이름 입력",message: "이름을 입력 안했습니다", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController,animated: true,completion: nil)
                lastNameTf.text = ""
                firstNameTf.text = ""
                lastNameCheck = false
                firstNameCheck = false
            }
           else if firstNameCheck == false {
                
                let alertController = UIAlertController(title: "성 입력",message: "성을 입력 안했습니다", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController,animated: true,completion: nil)
                lastNameTf.text = ""
                firstNameTf.text = ""
                lastNameCheck = false
                firstNameCheck = false
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {return false}
        
        if textField.tag == 1 {
            
            if vaildText(textVaild: text) == false {
                
                lastNameCheck = false
                
            }else {
                
                lastNameCheck = true
                
            }
        }
        else if textField.tag == 2 {
            
            if vaildText(textVaild: text) == false {
                
                firstNameCheck = false
                
            }else {
                
                firstNameCheck = true
            }
        }
        return true
    }
    
    @objc func viewtap(_ sender: UITapGestureRecognizer) {
        
        let alert =  UIAlertController(title: "프로필 이미지", message: "프로필 이미지 추가 방법 선택", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func openLibrary(){
        
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
        
    }
    
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(.camera)) {
            
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
            
        }else {
            
            print("카메라 사용 불가")
            
        }
    }
    
    //한번 true값을 만들고 나면 지우고나서 왜 접속이 되는지 궁금
    func vaildText(textVaild: String) -> Bool {
        
        let textRegEx = "^[A-Za-z가-힣]+$"
        let textTest = NSPredicate(format:"SELF MATCHES %@", textRegEx)
        return textTest.evaluate(with: textVaild)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        profileImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewtap(_:)))
        profileImage.addGestureRecognizer(gesture)
        
        lastNameTf.delegate = self
        lastNameTf.tag = 1
        firstNameTf.delegate = self
        firstNameTf.tag = 2
        
    }
    
}
extension ProfileCreateViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profileImage.image = image
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
