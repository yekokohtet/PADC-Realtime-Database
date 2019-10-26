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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewGroceryItemList.register(UINib(nibName: GroceryListItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GroceryListItemTableViewCell.identifier)
        
        tableViewGroceryItemList.dataSource = self
        tableViewGroceryItemList.delegate = self
        
    }
    
    @IBAction func btnAdd(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Grocery Item", message: "Add an Item", preferredStyle: .alert)
        
        alert.addTextField { (UITextField) in
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let add = UIAlertAction(title: "Save", style: .default) { (UIAlertAction) in
            
          
        
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GroceryListItemTableViewCell.identifier, for: indexPath) as! GroceryListItemTableViewCell
//        cell.groceryItem = groceryItems[indexPath.row]
        return cell
        
    }
    
}

extension GroceryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
    

        }
    }
}
