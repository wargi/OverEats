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
            print(lastNameText)
            guard let firstNameText = self.firstNameTf.text else {return}
            signUpDic.updateValue(firstNameText, forKey: "firstname")
            print(firstNameText)
  
            let email = signUpDic["username"] as! String
            let emailData = email.data(using: .utf8)
            let password = signUpDic["password"] as! String
            let passwordData = password.data(using: .utf8)
            let firstName = signUpDic["firstname"] as! String
            let firstNameData = firstName.data(using: .utf8)
            let lastName = signUpDic["lastname"] as! String
            let lastNameData = lastName.data(using: .utf8)
            let phoneNumber = signUpDic["phonenumber"] as! String
            let phoneNumberData = phoneNumber.data(using: .utf8)
            let imageData = UIImageJPEGRepresentation(self.profileImage.image!, 0.1)
            
            Alamofire.upload(
                multipartFormData: { multipartform in
                    multipartform.append(emailData!, withName: "username")
                    multipartform.append(passwordData!, withName: "password")
                    multipartform.append(firstNameData!, withName: "first_name")
                    multipartform.append(lastNameData!, withName: "last_name")
                    multipartform.append(phoneNumberData!, withName: "phone_number")
                    multipartform.append(imageData!, withName: "img_profile", fileName: "profileImage.jpeg", mimeType: "image/jpeg")
             
            },
                to: "https://www.overeats.kr/api/member/user/",
                method: .post,
                encodingCompletion: { result in
                    switch result {
                    case .success(let request, _,_ ):
                        request.responseJSON(completionHandler: { (response) in
                            
                            let alertController = UIAlertController(title: "성공",message: "회원가입 성공했습니다", preferredStyle: UIAlertControllerStyle.alert)
                            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                            alertController.addAction(okAction)
                            self.present(alertController,animated: true,completion: nil)
                            }
                        )
                    case .failure(let error):
                        print("회원가입 실패: ", error.localizedDescription)
                    }
                }
            )
            
            
            
        }
        if firstNameCheck == false && lastNameCheck == false {
            
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

            }
           else if firstNameCheck == false {
                
                let alertController = UIAlertController(title: "성 입력",message: "성을 입력 안했습니다", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController,animated: true,completion: nil)
           
            }
        }
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
        
        picker.allowsEditing = true
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
        
        lastNameTf.addTarget(self, action: #selector(lastNameCheck(_:)), for: .editingChanged)
        firstNameTf.addTarget(self, action: #selector(firstNameCheck(_:)), for: .editingChanged)
    }
    
}
extension ProfileCreateViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profileImage.image = image
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func lastNameCheck(_ sender: UITextField){
        guard let text = sender.text else { return }
        lastNameCheck = vaildText(textVaild: text)
    }
    
    @objc func firstNameCheck(_ sender: UITextField){
        guard let text = sender.text else { return }
        firstNameCheck = vaildText(textVaild: text)
    }
    
}
