//
//  helper.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 11/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation


class helper {
    
    func formatter(value : NSNumber) -> String {
        let formatter = NumberFormatter()
        let  price = value as NSNumber
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id-ID")
        let returnValue = formatter.string(from: price)
        return returnValue!
    }
    
    
}
