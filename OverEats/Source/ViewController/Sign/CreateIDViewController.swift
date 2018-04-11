//
//  CreateIDViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class CreateIDViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    var emailCheck:Bool = false
    var mobileCheck:Bool = false
    var passWordCheck:Bool = false
    
    var signUpDic:[String:Any] = [:]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "profileSegue" {
            let vc = segue.destination as! ProfileCreateViewController
            vc.signUpDic = signUpDic
            
        }
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        if vaildNumber(mobileNumber: mobile.text!) == false {
            
            mobileCheck = false
            
        } else {
            
            mobileCheck = true
            
        }
        
        print(emailCheck)
        print(mobileCheck)
        print(passWordCheck)
        if emailCheck == true && mobileCheck == true && passWordCheck == true {
            
            guard let emailText = self.emailTF.text else {return}
            signUpDic.updateValue(emailText, forKey: "username")
            guard let mobileText = self.mobile.text else {return}
            signUpDic.updateValue(mobileText, forKey: "phonenumber")
            guard let passWordText = self.passWord.text else {return}
            signUpDic.updateValue(passWordText, forKey: "password")
            
            performSegue(withIdentifier: "profileSegue", sender: sender)
            
        }
        
        if emailCheck == false && mobileCheck == false && passWordCheck == false {
            
            let alertController = UIAlertController(title: "모두 작성해 주세요",message: "모두 작성해 주세요", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController,animated: true,completion: nil)
            
        }
        
        if emailCheck == true || mobileCheck == true || passWordCheck == true {
            
            if emailCheck == false {
                
                let alertController = UIAlertController(title: "E-mail 형식이 틀렸습니다.",message: "다시 작성해 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController,animated: true,completion: nil)
                
            }
                
            else if mobileCheck == false {
                
                let alertController = UIAlertController(title: "번호 입력이 틀렸습니다.",message: "숫자만 입력해 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController,animated: true,completion: nil)
                
            }
                
            else if passWordCheck == false {
                
                let alertController = UIAlertController(title: "비밀번호 입력이 틀렸습니다.",message: "5자 입력해 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
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
