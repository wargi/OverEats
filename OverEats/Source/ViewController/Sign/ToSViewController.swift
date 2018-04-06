//
//  ToSViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class ToSViewController: UIViewController {
    
    @IBAction func nextButton(_ sender: UIButton) {
        if TosButtonSelected == true && PIPButtonSelected == true {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateIDViewController") as! CreateIDViewController
            present(vc, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "약관 동의 체크",message: "약관 동의 체크 해주세요", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController,animated: true,completion: nil)
        }
    }
    let checkedImage = UIImage(named: "jisu.jpg")! as UIImage
    let uncheckedImage = UIImage(named: "jisu1.jpg")! as UIImage
    var selectArray:[UIButton] = []
    var TosButtonSelected:Bool!
    var PIPButtonSelected:Bool!
//    var selectedBtn:UIButton!
    
    @IBAction func TosCheckButton(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            let index = selectArray.index(of: sender)!
            TosButtonSelected = false
            selectArray.remove(at: index)
            sender.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        } else {
            sender.isSelected = true
            TosButtonSelected = true
            selectArray.append(sender)
            sender.setBackgroundImage(checkedImage, for: UIControlState.normal)
        }
        
    }
    
    @IBAction func PIPCheckButton(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            let index = selectArray.index(of: sender)!
            PIPButtonSelected = false
            selectArray.remove(at: index)
            sender.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        } else {
            sender.isSelected = true
            PIPButtonSelected = true
            selectArray.append(sender)
            sender.setBackgroundImage(checkedImage, for: UIControlState.normal)
        }
    }
    
    @IBAction func OptionCheckButton(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            let index = selectArray.index(of: sender)!
//            selectedBtn = nil
            selectArray.remove(at: index)
            sender.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        } else {
            sender.isSelected = true
//            selectedBtn = sender
            selectArray.append(sender)
            sender.setBackgroundImage(checkedImage, for: UIControlState.normal)
        }
    }
        
        override func viewDidLoad() {
        super.viewDidLoad()
        
        
        }
        
        
}
