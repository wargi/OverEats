//
//  SignViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 2..
//  Copyright © 2018년 taewoong bae. All rights reserved.
//

import UIKit
class SignViewController: UIViewController {
    @IBOutlet weak var roundView: UIView!
    
    @IBAction func signInButton(_ sender: UIButton) {
   
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ToSViewController") as! ToSViewController
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundView.layer.cornerRadius = roundView.frame.size.height/6
 
    }

 

}
