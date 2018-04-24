//
//  TextFieldTableViewCell.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 23..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var locationTextField: UITextField!
    
    var source: LocationData!
    var totalArray: [String] = []
    var returnTrue = true
    let tagNumberTwo = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        locationTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

extension TextFieldTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = locationTextField.text else { return false}
        
        PostService.locationIn(text: text) { (result) in
            switch result {
                
            case .success(let success):
                
                self.source = success
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notiTagTwo"), object: self.tagNumberTwo)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notiKey"), object: self.source)
                
         
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notiBool"), object: self.returnTrue)
            
            case .error(let error):
                print(error)
                
                
            }
        }
        return true
    }
    
}
