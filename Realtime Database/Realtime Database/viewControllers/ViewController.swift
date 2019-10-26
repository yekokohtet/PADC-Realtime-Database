//
//  ViewController.swift
//  Realtime Database
//
//  Created by Ye Ko Ko Htet on 17/10/2019.
//  Copyright © 2019 Ye Ko Ko Htet. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
    
    
    }
    
    @IBAction func btnSignup(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register", message: "Please register your account.", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (email) in
            email.placeholder = "Enter your email"
        }
        
        alert.addTextField { (password) in
            password.placeholder = "Enter your password"
            password.isSecureTextEntry = true
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

