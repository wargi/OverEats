//
//  CreateIDViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class CreateIDViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    @IBAction func nextButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileCreateViewController") as! ProfileCreateViewController
        present(vc, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

   

}
