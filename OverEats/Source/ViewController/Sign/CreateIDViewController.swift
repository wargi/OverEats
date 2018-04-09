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

        if textField.tag == 1 {
            
            if vaildEmail(emailID: text) == false {
                
                emailCheck = false
                
            } else {
                
                emailCheck = true
                
            }
            
        }
        
        if textField.tag == 2 {
           
            var fullString = textField.text ?? ""
            fullString.append(string)
            
            if range.length == 1 {
           
                if vaildNumber(mobileNumber: text) == false {
           
                    mobileCheck = false
                    textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: true)
                    
                }else {
           
                    mobileCheck = true
                    textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: true)
                    
                }
                
            } else {
                
                if vaildNumber(mobileNumber: text) == false {
                
                    mobileCheck = false
                    textField.text = format(phoneNumber: fullString)
                    
                }else {
                
                    mobileCheck = true
                    textField.text = format(phoneNumber: fullString)
                    
                }
            }
            return false
        }
        
        if textField.tag == 3 {
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            
            if range.location == 5{
                
                passWordCheck = true
                
            }else {
                
                passWordCheck = false
                
            }
            return newLength <= 5
        }
        return true
    }

    func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")

        if number.count > 11 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 11)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }

        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }

        if number.count < 7 {
            
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)

        }
        if number.count <= 10 {
            
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
        
        let mobileRegEx = "[0-9]{3}+-[0-9]{3,}+-[0-9]{4}"
        let mobileTest = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        return mobileTest.evaluate(with: mobileNumber)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.delegate = self
        emailTF.tag = 1
        mobile.delegate = self
        mobile.tag = 2
        passWord.delegate = self
        passWord.tag = 3
        emailTF.addTarget(self, action: #selector(textField(_:)), for: .editingChanged)
    }
    
    @objc func textField(_ sender: UITextField) {
        guard let text = sender.text else { return }
        print(text)
        self.emailCheck = vaildEmail(emailID: text)
    }

   

}
