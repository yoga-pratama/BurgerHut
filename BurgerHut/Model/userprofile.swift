//
//  userprofile.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 28/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation


struct userprofile {
    let phone_number : String
    let address : String
    let coord : [Any]
    
    init(dictionary : userprofileJSON) {
       self.phone_number = dictionary["phone_number"] as! String
       self.address = dictionary["address"] as! String
       self.coord    = dictionary["coord"] as! [Any]
    }
}
