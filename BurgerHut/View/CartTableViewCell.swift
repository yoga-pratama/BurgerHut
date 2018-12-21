//
//  CartTableViewCell.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 17/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var food_name : UILabel!
    @IBOutlet weak var cart_detail : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
