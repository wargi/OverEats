//
//  CreateIDViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class CreateIDViewController: UIViewController, UITextFieldDelegate {

    // 회원정보 TextField
    @IBOutlet weak var emailTF: UITextField! // E-mail
    @IBOutlet weak var mobile: UITextField! // PhoneNumber
    @IBOutlet weak var passWord: UITextField! // PassWord
    
    // 정규식의 Bool값
    var emailCheck:Bool = false // E-mail의 정규식 Check값
    var mobileCheck:Bool = false // PhoneNumber의 정규식 Check값
    var passWordCheck:Bool = false // PassWord의 정규식 Check값
    
    // 회원정보를 저장
    var signUpDic:[String:Any] = [:]
    
    // TextField값을 다음 view에 넘겨주기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "profileSegue" {
            let vc = segue.destination as! ProfileCreateViewController // 데스티니를 이용하여 뷰에 접근
            vc.signUpDic = signUpDic // 해당 뷰에 접근이 가능해졌으니 원하는 값 옮기기
            
        }
    }
    
    // 다음 버튼
    @IBAction func nextButton(_ sender: UIButton) {
        
        // PhoneNumber 정규식 적용
        if vaildNumber(mobileNumber: mobile.text!) == false {
            
            mobileCheck = false // 정규식이 틀렸을 경우 false
            
        } else {
            
            mobileCheck = true // 정규식이 맞을 경우 true
            
        }
    
        // 모든 TextField의 정규식이 true일 때
        if emailCheck == true && mobileCheck == true && passWordCheck == true {
            
//            guard let emailText = self.emailTF.text else {return}
            signUpDic.updateValue(emailTF.text!, forKey: "username") // E-mail 입력 값을 Dic 형태로 저장
//            guard let mobileText = self.mobile.text else {return}
            signUpDic.updateValue(mobile.text!, forKey: "phonenumber") // PhoneNumber 입력 값을 Dic 형태로 저장
//            guard let passWordText = self.passWord.text else {return}
            signUpDic.updateValue(passWord.text!, forKey: "password") // PassWord 입력 갑을 Dic 형태로 저장
            
            performSegue(withIdentifier: "profileSegue", sender: sender) // 다음 view로 이동하기
            
        }
        
        // 모든 TextField의 정규식이 false일 때
        if emailCheck == false && mobileCheck == false && passWordCheck == false {
            
            // 경고창 띄우기
            let alertController = UIAlertController(title: "모두 작성해 주세요",message: "모두 작성해 주세요", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            alertController.addAction(okAction) // 확인 버튼
            self.present(alertController,animated: true,completion: nil)
            
        }
        
        // 1개라도 정규식이 true일 때
        if emailCheck == true || mobileCheck == true || passWordCheck == true {
            
            // E-mail TextField가 false일 때
            if emailCheck == false {
                
                // 경고 창 띄우기
                let alertController = UIAlertController(title: "E-mail 형식이 틀렸습니다.",message: "다시 작성해 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                alertController.addAction(okAction) // 확인 버튼
                self.present(alertController,animated: true,completion: nil)
                
            }
            
            // PhoneNumber TextField가 false일 때
            else if mobileCheck == false {
                
                // 경고 창 띄우기
                let alertController = UIAlertController(title: "번호 입력이 틀렸습니다.",message: "숫자만 입력해 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                alertController.addAction(okAction) // 확인 버튼
                self.present(alertController,animated: true,completion: nil)
                
            }
            // passWord TextField가 false일 때
            else if passWordCheck == false {
                
                // 경고 창 띄우기
                let alertController = UIAlertController(title: "비밀번호 입력이 틀렸습니다.",message: "5자 입력해 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                alertController.addAction(okAction) // 확인 버튼
                self.present(alertController,animated: true,completion: nil)
                
            }
        }
    }
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {return false}

        let finalText = (text as NSString).replacingCharacters(in: range, with: string)
        
        
        if textField.tag == 1 {
            
            if vaildEmail(emailID: finalText) == false {
                
                emailCheck = false
                
            } else {
                
                emailCheck = true
                
            }
            
        }
        
        return true
    }
//강제전환
    func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        print("format =========\(phoneNumber)")
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")

        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 11)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }

        if shouldRemoveLastDigit {

                let end = number.index(number.startIndex, offsetBy: number.count)
                number = String(number[number.startIndex..<end])

        }

        if number.count <= 3 {

            let end = number.index(number.startIndex, offsetBy: number.count-1)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})", with: "$1", options: .regularExpression, range: range)
         
        }
        
        else if number.count <= 6 {
            
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)

        }
        else if number.count <= 9 {
            print(number.count)
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            
        } else {
            
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            
        }
        return number
    }

    func vaildEmail(emailID: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
        
    }
    
    
    func vaildNumber(mobileNumber: String) -> Bool {
        
        let mobileRegEx = "[0-9]{3}+-[0-9]{3,4}+-[0-9]{4}"
        let mobileTest = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
    
        return mobileTest.evaluate(with: mobileNumber)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.delegate = self
        emailTF.tag = 1
        
//        emailTF.addTarget(self, action: #selector(textField(_:)), for: .editingChanged)
        
        mobile.addTarget(self, action: #selector(mobiletextField(_:)), for: .editingChanged)
        passWord.addTarget(self, action: #selector(passWordTextField(_:)), for: .editingChanged)
    }

    // 텍스트필드 실시간검사
//
//    @objc func textField(_ sender: UITextField) {
//        guard let text = sender.text else { return }
//        self.emailCheck = vaildEmail(emailID: text)
//    }

    @objc func mobiletextField(_ sender: UITextField) {
        guard let text = sender.text else { return }

            let formatNumber = format(phoneNumber: text, shouldRemoveLastDigit: true)
            mobile.text = formatNumber
        
    }
   
    @objc func passWordTextField(_ sender: UITextField) {
        
            let newLength = sender.text!.count
        
            if newLength >= 5 {

                passWordCheck = true
                
            }else {
                
                passWordCheck = false
                
            }
            
        
    }
}
