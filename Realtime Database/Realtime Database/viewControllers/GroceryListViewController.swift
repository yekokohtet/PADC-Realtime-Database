//
//  GroceryListViewController.swift
//  Realtime Database
//
//  Created by Ye Ko Ko Htet on 25/10/2019.
//  Copyright © 2019 Ye Ko Ko Htet. All rights reserved.
//

import UIKit
import Firebase

class GroceryListViewController: UIViewController {
    
    static let identifier = "GroceryListViewController"
    
    @IBOutlet weak var tableViewGroceryItemList: UITableView!
    @IBOutlet weak var currentOnlineUser: UIBarButtonItem!
    
    var groceryItems: [GroceryItemVO] = []
    var user: UserVO!
  
    let groceryItemRef = Database.database().reference(withPath: "grocery-items")
    let onlineUserRef = Database.database().reference(withPath: "online-users")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewGroceryItemList.register(UINib(nibName: GroceryListItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GroceryListItemTableViewCell.identifier)
        
        tableViewGroceryItemList.dataSource = self
        tableViewGroceryItemList.delegate = self
            
        /**
         Read from Realtime Database
         */
        groceryItemRef.observe(.value) { (snapshot) in
            self.groceryItems.removeAll()
            for item in snapshot.children {
                
                let userItem = item as! DataSnapshot
                let currentUserItem = userItem.value as? [String: AnyObject]
                
                if Auth.auth().currentUser?.email == currentUserItem?["addedByUser"] as? String {
                    let groceryItem = GroceryItemVO(snapshot: item as! DataSnapshot)
                    
                    self.groceryItems.append(groceryItem ?? GroceryItemVO(name: "", addedByUser: "", completed: false))
                }
            }
            self.tableViewGroceryItemList.reloadData()
        }
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.user = UserVO(uid: user.uid, email: user.email ?? "")
                let currentUserRef = self.onlineUserRef.child(self.user.uid)
                currentUserRef.setValue(self.user.email)
                currentUserRef.onDisconnectRemoveValue()
            }
        }
        
        onlineUserRef.observe(.value) { (snapshot) in
            if snapshot.exists() {
                self.currentOnlineUser.title = snapshot.childrenCount.description
            } else {
                self.currentOnlineUser.title = "0"
            }
        }
        
    }
    
    @IBAction func btnAdd(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Grocery Item", message: "Add an Item", preferredStyle: .alert)
        
        alert.addTextField { (UITextField) in
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let add = UIAlertAction(title: "Save", style: .default) { (UIAlertAction) in
            
            /**
             Create new item to Realtime Database
             */
            
            let ref = self.groceryItemRef.child(alert.textFields?.first?.text?.lowercased() ?? "")
            
            let values: [String: Any] = ["name": alert.textFields?.first?.text ?? "", "addedByUser": Auth.auth().currentUser?.email ?? "", "completed": false]
            ref.setValue(values)
        
        }
        
        alert.addAction(cancel)
        alert.addAction(add)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func currentOnlineUser(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: OnlineUserListViewController.identifier) as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension GroceryListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GroceryListItemTableViewCell.identifier, for: indexPath) as! GroceryListItemTableViewCell
        cell.groceryItem = groceryItems[indexPath.row]
        return cell
        
    }
    
}

extension GroceryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /**
         Update
         */
        let groceryItem = groceryItems[indexPath.row]
        groceryItem.ref?.updateChildValues(["completed": !groceryItem.completed])

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            /**
             Delete
             */
            let groceryItem = groceryItems[indexPath.row]
            groceryItem.ref?.removeValue()

        }
    }
}
