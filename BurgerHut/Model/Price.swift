//
//  Price.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 07/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation

struct Price {
    var price_id      : String
    var  price_package : Bool
    var price_size : String
    var price_value : NSArray

    
    init(dictionary : priceJSON) {
         self.price_id = dictionary["price_id"] as! String
         self.price_package =  dictionary["price_package"] as! Bool
         self.price_size = dictionary["price_size"] as! String
         self.price_value = dictionary["price_value"] as!  NSArray
    }
}
