//
//  cart.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 14/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation

struct cart {
    var cart_id : String
    var cart_qty : Int
    var cart_value : NSNumber
    var food_name : String
    var food_size : String
    var user_id  :String
    
    init(dictionary : cartJSON) {
        self.cart_id = dictionary["cart_id"] as! String
        self.cart_qty = dictionary["cart_qty"] as! Int
        self.cart_value = dictionary["cart_value"] as! NSNumber
        self.food_name = dictionary["food_name"] as! String
        self.food_size = dictionary["food_size"] as! String
        self.user_id = dictionary["user_id"] as! String
    }
}
