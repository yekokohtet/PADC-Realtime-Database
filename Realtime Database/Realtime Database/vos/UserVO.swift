//
//  UserVO.swift
//  Realtime Database
//
//  Created by Ye Ko Ko Htet on 25/10/2019.
//  Copyright © 2019 Ye Ko Ko Htet. All rights reserved.
//

import Foundation
import Firebase

struct UserVO {
  
  let uid: String
  let email: String
    
  init(uid: String, email: String) {
    self.uid = uid
    self.email = email
  }
}
