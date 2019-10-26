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
        
//        let groceryItemsRef = Database.database().reference(withPath: "grocery-items")
//        let milkRef = groceryItemsRef.child("milk")
//
//        let values: [String: Any] = ["name": "Milk", "addedByUser": "David", "completed": false]
//
//        milkRef.setValue(values)
//
//        groceryItemsRef.observe(.value) { (dataSnapshot) in
//            print(dataSnapshot)
//        }
//
//        milkRef.observe(.value) { (dataSnapshot) in
//            print(dataSnapshot)
//        }
        
//        let listener = Auth.auth().addStateDidChangeListener { (auth, user) in
//            if user != nil {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(identifier: "GroceryListViewController") as! UINavigationController
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
//            }
//        }
//        Auth.auth().removeStateDidChangeListener(listener)
        
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
    
        Auth.auth().signIn(withEmail: tfUsername.text ?? "", password: tfPassword.text ?? "") { (result, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "GroceryListViewController") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
            self.tfUsername.text = ""
            self.tfPassword.text = ""
        }
    
    }
    
    @IBAction func btnSignup(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register", message: "Please register your account.", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            
            let email = alert.textFields?[0].text
            let password = alert.textFields?[1].text
            
            Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { (result, err) in
                if let err = err {
                    if let errCode = AuthErrorCode(rawValue: err._code) {
                        switch errCode {
                        case .weakPassword:
                            print("Please provide a strong password!")
                        default:
                            print(err.localizedDescription)
                        }
                        return
                    }
                }
                
                if let result = result {
                    result.user.sendEmailVerification { (err) in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                    }
                    
                    Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { (result, err) in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "GroceryListViewController") as! UINavigationController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                
            }
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

