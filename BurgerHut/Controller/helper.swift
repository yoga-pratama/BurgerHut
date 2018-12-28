//
//  helper.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 11/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation
import UIKit



class helper {
    
    let data = ArrayCollection.sharedArray
    
    func formatter(value : NSNumber) -> String {
        let formatter = NumberFormatter()
        let  price = value as NSNumber
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id-ID")
        let returnValue = formatter.string(from: price)
        return returnValue!
    }
    
    func getPrice(menuid : String)->[Price]{
        let pricePerId = data.priceArray.filter{
             return $0.price_id == menuid
        }
        return pricePerId
    }
    
    func alertHelper(alertMessage : String) -> UIAlertController{
       let alertController = UIAlertController(title: "Notification", message:alertMessage , preferredStyle: .alert)
       let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        
        return alertController
    }
    
    
   
   
    
    
}
