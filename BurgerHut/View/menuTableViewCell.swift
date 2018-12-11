//
//  menuTableViewCell.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 10/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class menuTableViewCell: UITableViewCell {
    
    @IBOutlet var menuimageView : UIImageView!
    @IBOutlet var menuText : UILabel!
    @IBOutlet var menuStartFrom : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
