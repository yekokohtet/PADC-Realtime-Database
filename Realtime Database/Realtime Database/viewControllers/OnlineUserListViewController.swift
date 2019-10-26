//
//  OnlineUserListViewController.swift
//  Realtime Database
//
//  Created by Ye Ko Ko Htet on 25/10/2019.
//  Copyright © 2019 Ye Ko Ko Htet. All rights reserved.
//

import UIKit
import Firebase

class OnlineUserListViewController: UIViewController {
    
    static let identifier = "OnlineUserListViewController"

    @IBOutlet weak var tableViewOnlineUserList: UITableView!
    
    let onlineUserRef = Database.database().reference(withPath: "online-users")
    
    var userList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOnlineUserList.register(UINib(nibName: OnlineUserTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OnlineUserTableViewCell.identifier)

        tableViewOnlineUserList.dataSource = self
                
        onlineUserRef.observe(.childAdded, with: { snap in
          guard let email = snap.value as? String else { return }
          self.userList.append(email)
          let row = self.userList.count - 1
          let indexPath = IndexPath(row: row, section: 0)
          self.tableViewOnlineUserList.insertRows(at: [indexPath], with: .top)
        })

        onlineUserRef.observe(.childRemoved, with: { snap in
          guard let emailToFind = snap.value as? String else { return }
          for (index, email) in self.userList.enumerated() {
            if email == emailToFind {
              let indexPath = IndexPath(row: index, section: 0)
              self.userList.remove(at: index)
              self.tableViewOnlineUserList.deleteRows(at: [indexPath], with: .fade)
            }
          }
        })
        
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        let user = Auth.auth().currentUser!
        let onlineRef = self.onlineUserRef.child(user.uid)
        onlineRef.removeValue { (err, _) in
          if let err = err {
            print(err.localizedDescription)
            return
          }
          do {
            try Auth.auth().signOut()
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
          } catch let err {
            print(err.localizedDescription)
          }
        }
    }
    
}

extension OnlineUserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OnlineUserTableViewCell.identifier, for: indexPath) as! OnlineUserTableViewCell
        cell.lblOnlineUser.text = userList[indexPath.row]
        return cell
    }
}

