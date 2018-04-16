//
//  ProfileCreateViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit
import Alamofire

class ProfileCreateViewController: UIViewController {
    
    // regular 인스턴스 만들기
    let regular = Regularexpression()
    
    // 회원정보 textField와 profileImage
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var firstNameTf: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    // picker 인스턴스 만들기
    let picker = UIImagePickerController()
    
    // 정규식의 Bool 값
    var firstNameCheck:Bool = false
    var lastNameCheck:Bool = false
    
    // 회원정보 저장 Dic
    var signUpDic:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate 연결
        picker.delegate = self
        
        // 이부분을 true로 바꿔줘야 선택한 image를 적용할지 확인 단계가 생긴다
        profileImage.isUserInteractionEnabled = true
        
        //imageView에 gesture 적용
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewtap(_:)))
        profileImage.addGestureRecognizer(gesture)
        
        lastNameTf.addTarget(self, action: #selector(lastNameCheck(_:)), for: .editingChanged) // 실시간 적용
        firstNameTf.addTarget(self, action: #selector(firstNameCheck(_:)), for: .editingChanged) // 실시간 적용
    }
    
    // 다음 버튼
    @IBAction func nextButton(_ sender: UIButton) {
        
        // 모든 TextField의 정규식이 true일 때
        if firstNameCheck == true && lastNameCheck == true {
            
            // textField의 text를 회원정보 Dic에 저장하기
            signUpDic.updateValue(lastNameTf.text!, forKey: "lastname")
            signUpDic.updateValue(firstNameTf.text!, forKey: "firstname")
            
            // multipartFormData를 사용하기 위해서 utf8로 변환시키기
            // image를 보내기 위해서는 multipartFormData가 필요하다
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
                
                // 서버에서 받을때 필요한 Key로 보내주기
                multipartFormData: { multipartform in
                    multipartform.append(emailData!, withName: "username")
                    multipartform.append(passwordData!, withName: "password")
                    multipartform.append(firstNameData!, withName: "first_name")
                    multipartform.append(lastNameData!, withName: "last_name")
                    multipartform.append(phoneNumberData!, withName: "phone_number")
                    multipartform.append(imageData!, withName: "img_profile", fileName: "profileImage.jpeg", mimeType: "image/jpeg") // fileName: 서버에서 저장 할 imageName을 적용
                    // mimType: image 확장자 적용
                    
            },
                to: "https://www.overeats.kr/api/member/user/",
                method: .post,
                encodingCompletion: { result in
                    switch result {
                    case .success(let request, _,_ ):
                        request.responseJSON(completionHandler: { (response) in
                            
                            self.showAlert(alertTitle: "성공", alertMessage: "회원가입 성공했습니다", actionTitle: "확인")
                            
                        }
                        )
                    case .failure(let error):
                        
                        self.showAlert(alertTitle: "실패", alertMessage: "회원가입 실패", actionTitle: "확인")
                        print("회원가입 실패: ", error.localizedDescription)
                        
                    }
            }
            )
        }
        
        // 모든 TextField의 정규식이 false일 때
        if firstNameCheck == false && lastNameCheck == false {
            
            showAlert(alertTitle: "이름과 성 입력", alertMessage: "이름과 성을 입력 해주세요", actionTitle: "확인")
            
        }
        
        // TextField중 하나가 true일 때
        if firstNameCheck == true || lastNameCheck == true {
            
            // lastNameTf가 false일 때
            if lastNameCheck == false {
                
                showAlert(alertTitle: "이름 입력", alertMessage: "이름을 잘못 입력했습니다.", actionTitle: "확인")
                
            }
                
                // firstNameTf가 false일 때
            else if firstNameCheck == false {
                
                showAlert(alertTitle: "성 입력", alertMessage: "성을 잘못 입력했습니다.", actionTitle: "확인")
                
            }
        }
    }
    
    // 앨범 열기
    func openLibrary(){
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
        
    }
    
    // 카메라 열기
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(.camera)) {
            
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
            
        }else {
            
            print("카메라 사용 불가")
            
        }
    }
    
    //imageView에 gesture 적용 내용
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
}

extension ProfileCreateViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 에디팅된 imagefile 가져오기
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profileImage.image = image // 이미지 넣기
            
        }
        
        dismiss(animated: true, completion: nil) // 이미지 선택 후 뒤로 가기
        
    }
    
    // lastName 정규식 적용
    @objc func lastNameCheck(_ sender: UITextField){
        guard let text = sender.text else { return }
        lastNameCheck = regular.vaildText(textVaild: text)
    }
    
    // firstName 정규식 적용
    @objc func firstNameCheck(_ sender: UITextField){
        guard let text = sender.text else { return }
        firstNameCheck = regular.vaildText(textVaild: text)
    }
    
}
