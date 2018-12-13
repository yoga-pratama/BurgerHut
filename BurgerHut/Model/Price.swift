//
//  Price.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 07/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation

struct Price{
    var price_id   : String
    var price_name : String
    var price_value : NSNumber
    var size_id     : NSNumber
   
    
    init(dictionary : priceJSON) {
         self.price_id = dictionary["price_id"] as! String
         self.price_name = dictionary["price_name"] as! String
         self.price_value = dictionary["price_value"] as! NSNumber
         self.size_id = dictionary["size_id"] as! NSNumber
    }
}






