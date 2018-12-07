//
//  promo.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 06/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation


struct promo {
    var promo_id : String
    var promo_name : String
    var promo_pic : String
    var promo_type : String
    
    init(dictionary : promoJSON) {
       self.promo_id = dictionary["promo_id"] as! String
       self.promo_name = dictionary["promo_name"] as! String
       self.promo_pic = dictionary["promo_pic"] as! String
       self.promo_type = dictionary["promo_type"] as! String
    }
}
