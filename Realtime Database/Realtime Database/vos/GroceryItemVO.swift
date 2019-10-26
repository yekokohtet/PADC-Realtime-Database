//
//  GroceryVO.swift
//  Realtime Database
//
//  Created by Ye Ko Ko Htet on 25/10/2019.
//  Copyright © 2019 Ye Ko Ko Htet. All rights reserved.
//

import Foundation
import Firebase

struct GroceryItemVO {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let addedByUser: String
    var completed: Bool
    
    init(name: String, addedByUser: String, completed: Bool) {
      self.ref = nil
      self.key = ""
      self.name = name
      self.addedByUser = addedByUser
      self.completed = completed
    }
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let name = value["name"] as? String,
        let addedByUser = value["addedByUser"] as? String,
        let completed = value["completed"] as? Bool else {
        return nil
      }

      self.ref = snapshot.ref
      self.key = snapshot.key
      self.name = name
      self.addedByUser = addedByUser
      self.completed = completed
    }
    
}
