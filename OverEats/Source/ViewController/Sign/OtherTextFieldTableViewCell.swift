//
//  OtherTextFieldTableViewCell.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 24..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class OtherTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var otherTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func tagInt (tag: Int) {
    if tag == 1 {
    otherTextField.placeholder = "건물 이름과 동/호/층"
    } else {
    otherTextField.placeholder = "회사명 (예시: 오버이츠)"
    }
    print("cell안에서의 tag",tag)
    }
}

extension OtherTextFieldTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = otherTextField.text else { return false}
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "otherText"), object: text)
        
        return true
    }
}

