//
//  CreateIDViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class CreateIDViewController: UIViewController{
    
    // regular 인스턴스 만들기
    let regular = RegularExpression()
    
    // 회원정보 TextField
    @IBOutlet weak var emailTextField: UITextField! // E-mail
    @IBOutlet weak var mobileTextField: UITextField! // PhoneNumber
    @IBOutlet weak var passWordTextField: UITextField! // PassWord
    
    // 정규식의 Bool 값
    var emailCheck:Bool = false // E-mail의 정규식 Check값
    var mobileCheck:Bool = false // PhoneNumber의 정규식 Check값
    var passWordCheck:Bool = false // PassWord의 정규식 Check값
    
    // 회원정보를 저장
    var signUpDic:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tag로 사용 해보기
        emailTextField.delegate = self
        emailTextField.tag = 1
        
        
        // textField 에서 tag로 적용하는 방법을 사용했기에 주석으로 빼놓기
        // emailTextField.addTarget(self, action: #selector(textField(_:)), for: .editingChanged)
        mobileTextField.addTarget(self, action: #selector(mobiletextField(_:)), for: .editingChanged) // 실시간 적용
        passWordTextField.addTarget(self, action: #selector(passWordTextField(_:)), for: .editingChanged) // 실시간 적용
        
    }
    
    // TextField값을 다음 view에 넘겨주기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "profileSegue" {
            let nextViewController = segue.destination as! ProfileCreateViewController // 데스티니를 이용하여 뷰에 접근
            
            nextViewController.signUpDic = signUpDic // 해당 뷰에 접근이 가능해졌으니 원하는 값 옮기기
        }
    }
    
    // 다음 버튼
    @IBAction func nextButton(_ sender: UIButton) {
        
        // PhoneNumber 정규식 적용
        // 버튼 누르는 순간에 검사
        mobileCheck = regular.vaildNumber(mobileNumber: mobileTextField.text!)
        
        // 모든 TextField의 정규식이 true일 때
        if emailCheck == true && mobileCheck == true && passWordCheck == true {
            
            signUpDic.updateValue(emailTextField.text!, forKey: "username") // E-mail 입력 값을 Dic 형태로 저장
            signUpDic.updateValue(mobileTextField.text!, forKey: "phone_number") // PhoneNumber 입력 값을 Dic 형태로 저장
            signUpDic.updateValue(passWordTextField.text!, forKey: "password") // PassWord 입력 갑을 Dic 형태로 저장
            
            performSegue(withIdentifier: "profileSegue", sender: sender) // 다음 view로 이동하기

        }
        
        // 모든 TextField의 정규식이 false일 때
        if emailCheck == false && mobileCheck == false && passWordCheck == false {
            
            // 경고창 띄우기
            showAlert(alertTitle: "모두 작성해 주세요", alertMessage: "모두 작성해 주세요", actionTitle: "확인")
            
        }
        
        // 1개라도 정규식이 true일 때
        if emailCheck == true || mobileCheck == true || passWordCheck == true {
            
            // E-mail TextField가 false일 때
            if emailCheck == false {
                
                // 경고 창 띄우기
                showAlert(alertTitle: "E-mail 형식이 틀렸습니다.", alertMessage: "다시 작성해 주세요", actionTitle: "확인")
                
            }
                
                // PhoneNumber TextField가 false일 때
            else if mobileCheck == false {
                
                // 경고 창 띄우기
                showAlert(alertTitle: "번호 입력이 틀렸습니다.", alertMessage: "숫자만 입력해 주세요", actionTitle: "확인")
                
            }
                // passWord TextField가 false일 때
            else if passWordCheck == false {
                
                // 경고 창 띄우기
                showAlert(alertTitle: "비밀번호 입력이 틀렸습니다.", alertMessage: "5자 이상 입력해 주세요", actionTitle: "확인")
                
            }
        }
    }
    
    // 이전 화면으로 dismiss 하는 버튼
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateIDViewController: UITextFieldDelegate {
    // textField에 입력된 값 정보를 알 수 있다
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //textField에 텍스트가 있는지 검사
        guard let text = textField.text else {return false}
        
        // 실시간으로 텍스트 값 받기
        // 아래 editingChanged 와 비슷한 용도로 사용하지만 이런 방법으로도 사용 가능
        let finalText = (text as NSString).replacingCharacters(in: range, with: string)
        
        // E-mail textField가 사용중인지 확인
        if textField.tag == 1 {
            
            emailCheck = regular.vaildEmail(emailID: finalText)
            
        }
        
        return true // true로 return 해줘야 적용
    }
    
    // 텍스트필드 실시간검사
    //    @objc func textField(_ sender: UITextField) {
    //        guard let text = sender.text else { return }
    //        self.emailCheck = vaildEmail(emailID: text)
    //    }
    
    // editingChanged로 받은 text를 입력 순간 format에 적용시키기
    @objc func mobiletextField(_ sender: UITextField) {
        
        guard let text = sender.text else { return }
        
        let formatNumber = regular.format(phoneNumber: text, shouldRemoveLastDigit: true)
        mobileTextField.text = formatNumber // 적용 된 부분을 text로 띄우기
        
    }
    
    // editingChanged로 받은 text를 입력 순간 count 찾기
    @objc func passWordTextField(_ sender: UITextField) {
        
        let newLength = sender.text!.count
        
        if newLength >= 5 {
            
            passWordCheck = true
            
        }else {
            
            passWordCheck = false
            
        }
    }
}
