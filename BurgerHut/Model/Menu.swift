//
//  Menu.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 07/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation

struct Menu {
    
    var menu_id  : String
    var menu_name : String
    var menu_pic : String
    var menu_type : String
    
    init(dictionary : menuJSON) {
        self.menu_id = dictionary["menu_id"] as! String
        self.menu_name = dictionary["menu_name"] as! String
        self.menu_pic = dictionary["menu_pic"] as! String
        self.menu_type = dictionary["menu_type"] as! String
    }
}
