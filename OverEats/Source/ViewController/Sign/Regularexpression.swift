//
//  Format.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 16..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

class RegularExpression {
    
    // 자동으로 - 잡아주기
    func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        
        guard !phoneNumber.isEmpty else { return "" } // text가 있는지 확인
        
        // 패턴 정해주기
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        
        // 현재 text의 range
        let textRange = NSString(string: phoneNumber).range(of: phoneNumber)
        
        // String형식으로 위에 값들이 적용된 text
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: textRange, withTemplate: "")
        
        // offset은 전화번호 최대인 11자 까지 지정해주고 패턴 적용은 10까지 해줘야 한다
        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 11)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        // 어디서든 지울때 맨 뒤에 글자가 지우게 만든 것
        if shouldRemoveLastDigit {
            
            let end = number.index(number.startIndex, offsetBy: number.count)
            number = String(number[number.startIndex..<end])
            
        }
        
        // 4개 이상 입력시 적용
        if number.count <= 3 {
            
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})", with: "$1",
                                                 options: .regularExpression, range: range)
            
        }
            
        // 7개 이상 입력시 적용
        else if number.count <= 6 {
            
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)
            
        }
            
        // 10개 이상 입력시 적용
        else if number.count <= 10 {
            print(number.count)
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            
        } else {
            
            // 11개 입력시 적용
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            
        }
        return number
    }
    
    // E-mail 정규식
    func vaildEmail(emailID: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
        
    }
    
    // PhoneNumer 정규식
    func vaildNumber(mobileNumber: String) -> Bool {
        
        let mobileRegEx = "[0-9]{3}+-[0-9]{3,4}+-[0-9]{4}"
        let mobileTest = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        
        return mobileTest.evaluate(with: mobileNumber)
        
    }
    
    // Name 정규식
    func vaildText(textVaild: String) -> Bool {
        
        let textRegEx = "^[A-Za-z가-힣]+$"
        let textTest = NSPredicate(format:"SELF MATCHES %@", textRegEx)
        return textTest.evaluate(with: textVaild)
        
    }
}
