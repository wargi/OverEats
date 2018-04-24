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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        locationTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TextFieldTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = locationTextField.text else { return false}
        
        PostService.locationIn(text: text) { (result) in
            switch result {
                
            case .success(let success):
                print("11111111111111111111",success)
//                UserManager.setlocation = success
//                print("2222222222222222222",success)
                
            case .error(let error):
                print(error)
                
                
            }
        }
//        let imageData = UIImageJPEGRepresentation(self.profileImage.image!, 0.1)
//
//        PostService.singUp(singUpData: signUpDic, imageData: imageData, completion: {(result) in
//            switch result {
//            case .success(let userData):
//
//                UserManager.setUser = userData
//                UserDefaults.standard.set("\(userData.token)", forKey: "userToken")
//
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let nextViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
//                self.present(nextViewController, animated: true, completion: nil)
//
//            case .error(let error):
//                print(error)
        
        return true
    }
    
}
