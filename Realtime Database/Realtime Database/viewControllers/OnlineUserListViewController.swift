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
    
    var userList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOnlineUserList.register(UINib(nibName: OnlineUserTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OnlineUserTableViewCell.identifier)

        tableViewOnlineUserList.dataSource = self
                
        
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        
    }
    
}

extension OnlineUserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userList.count
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OnlineUserTableViewCell.identifier, for: indexPath) as! OnlineUserTableViewCell
        cell.lblOnlineUser.text = userList[indexPath.row]
        return cell
    }
}

