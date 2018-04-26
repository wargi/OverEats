//
//  CardEnrollmentViewController.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 26..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class CardEnrollmentViewController: UIViewController {

    @IBOutlet private weak var save : UIButton!
    @IBOutlet private weak var cardNumber : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        save.addTarget(self, action: #selector(self.saveEvent(_:)), for: .touchUpInside)
        cardNumber.addTarget(self, action: #selector(mobiletextField(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func saveEvent(_ sender: UIButton) {
        guard cardNumber.text?.count == 19 else { return }
        let cardNumberText = cardNumber.text!
        
        cardNumber.text = format(phoneNumber: cardNumberText)
        print(cardNumber.text)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cardNumber"), object: cardNumber.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" } // text가 있는지 확인
        
        // 패턴 정해주기
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        
        // 현재 text의 range
        let textRange = NSString(string: phoneNumber).range(of: phoneNumber)
        
        // String형식으로 위에 값들이 적용된 text
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: textRange, withTemplate: "")
        
        if number.count > 15 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 16)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        // 어디서든 지울때 맨 뒤에 글자가 지우게 만든 것
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count)
            number = String(number[number.startIndex..<end])
        }
        // 5개 이상 입력시 적용
        if number.count <= 4 {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{4})", with: "$1",
                                                 options: .regularExpression, range: range)
        }
        // 9개 이상 입력시 적용
        else if number.count <= 8 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{4})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)
        }
        // 13개 이상 입력시 적용
        else if number.count <= 12 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
        } else {
            // 16개 입력시 적용
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d{4})(\\d+)", with: "$1-$2-$3-$4", options: .regularExpression, range: range)
            
        }
        return number
    }

}

extension CardEnrollmentViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //textField에 텍스트가 있는지 검사
        guard let text = textField.text else {return false}
        
        // 실시간으로 텍스트 값 받기
        // 아래 editingChanged 와 비슷한 용도로 사용하지만 이런 방법으로도 사용 가능
//        let finalText = (text as NSString).replacingCharacters(in: range, with: string)

        return true // true로 return 해줘야 적용
    }
    
    @objc func mobiletextField(_ sender: UITextField) {
        
        guard let text = sender.text else { return }
        
        let formatNumber = self.format(phoneNumber: text, shouldRemoveLastDigit: true)
        cardNumber.text = formatNumber // 적용 된 부분을 text로 띄우기
        
    }
}
