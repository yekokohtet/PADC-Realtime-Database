//
//  GroceryListItemTableViewCell.swift
//  Realtime Database
//
//  Created by Ye Ko Ko Htet on 25/10/2019.
//  Copyright © 2019 Ye Ko Ko Htet. All rights reserved.
//

import UIKit

class GroceryListItemTableViewCell: UITableViewCell {
    
    static let identifier = "GroceryListItemTableViewCell"

    @IBOutlet weak var lblGroceryItemName: UILabel!
    @IBOutlet weak var lblAddedUser: UILabel!
    @IBOutlet weak var ivCompleted: UIImageView!
    
    var groceryItem: GroceryItemVO? {
        didSet {
            if let groceryItem = groceryItem {
                
                lblGroceryItemName.text = groceryItem.name
                lblAddedUser.text = groceryItem.addedByUser
                ivCompleted.isHidden = groceryItem.completed == true ? false : true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
