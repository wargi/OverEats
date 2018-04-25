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
    let regular = RegularExpression()
    
    // 회원정보 textField와 profileImage
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
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
        
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
        //imageView에 gesture 적용
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewtap(_:)))
        profileImage.addGestureRecognizer(gesture)
        
        lastNameTextField.addTarget(self, action: #selector(lastNameCheck(_:)), for: .editingChanged) // 실시간 적용
        firstNameTextField.addTarget(self, action: #selector(firstNameCheck(_:)), for: .editingChanged) // 실시간 적용
    }
    
    // 이전 화면으로 dismiss 하는 버튼
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 다음 화면 호출 버튼
    @IBAction func nextButton(_ sender: UIButton) {
        
        // 모든 TextField의 정규식이 true일 때
        if firstNameCheck == true && lastNameCheck == true {
            
            // textField의 text를 회원정보 Dic에 저장하기
            signUpDic.updateValue(lastNameTextField.text!, forKey: "last_name")
            signUpDic.updateValue(firstNameTextField.text!, forKey: "first_name")
            
            let imageData = UIImageJPEGRepresentation(self.profileImage.image!, 0.1)
            
            PostService.singUp(singUpData: signUpDic, imageData: imageData, completion: {(result) in
                switch result {
                case .success(let userData):
                    
                    UserManager.setUser = userData
                    UserDefaults.standard.set("\(userData.token)", forKey: "userToken")
                    
                    let storyboard = UIStoryboard(name: "Sign", bundle: nil)
                    let nextViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
                    self.present(nextViewController, animated: true, completion: nil)
                    
                case .error(let error):
                    print(error)
                }
            })
            
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
            
            self.profileImage.image = image.resized(toWidth: 100) // 이미지 사이즈 조절 후 넣기
            
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


extension UIImage {
    // image size 줄이는 함수 width 크기를 기준으로 비율에 맞게
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
