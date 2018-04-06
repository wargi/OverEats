//
//  ProfileCreateViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class ProfileCreateViewController: UIViewController{

    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var firstNameTf: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBAction func nextButton(_ sender: UIButton) {
        
        firstName = firstNameTf.text
        lastName = lastNameTf.text
        
        if firstName.isEmpty == false && lastName.isEmpty == false {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
            present(vc, animated: true, completion: nil)
        }else {
            let alertController = UIAlertController(title: "이름과 성 입력",message: "이름과 성 입력 해주세요", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController,animated: true,completion: nil)
        }
    }
    
    let picker = UIImagePickerController()
    
    var firstName:String!
    var lastName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        profileImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewtap(_:)))
        profileImage.addGestureRecognizer(gesture)
        
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
    
}
extension ProfileCreateViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profileImage.image = image
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }

}
