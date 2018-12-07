//
//  GetData.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 06/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation
import Firebase

class Getdata{

    var db: Firestore!
    static let sharedInstance = Getdata()
    
    let sharedArray = ArrayCollection.sharedArray
    
    func getPromoData(completion : @escaping () ->Void){
        config()
       
        db.collection("promo").order(by: "promo_name").getDocuments() { (snapshot , err) in
            if let err = err {
                print("error get document: \(err)")
            }else{
                
                for document in snapshot!.documents{
                    // print("\(document.documentID) => \ (document.data())")
                    
                    var promoData:[String:Any] = [
                        "promo_id" : document.documentID,
                        "promo_name" :document.data()["promo_name"],
                        "promo_type" : document.data()["promo_type"],
                        "promo_pic" : document.data()["promo_pic"]
                        ]
                   
                   let promoDataList = promo(dictionary: promoData)
                   self.sharedArray.promoArray.append(promoDataList)
                   print("appending promo data...")
                    
                
                 
                }
                
               completion()
               
              
            }
           
        }
      
        
    }
    
    func getMenu( completion : @escaping () -> Void){
        config()
        
          db.collection("menu").order(by: "menu_name").getDocuments() { (snapshot , err) in
            if let err = err {
                print("error get document: \(err)")
            }else{
                
                for document in snapshot!.documents{
                    
                    var menuData : [String : Any] = [
                        "menu_id" : document.documentID,
                        "menu_name" : document.data()["menu_name"],
                        "menu_type" : document.data()["menu_type"],
                        "menu_pic" : document.data()["menu_pic"]
                    ]
                    
                    var menuDataList = Menu(dictionary: menuData)
                    self.sharedArray.menuArray.append(menuDataList)
                    print("appending menu data...")
                    self.db.collection("menu").document(document.documentID).collection("price").getDocuments() { (snapPrice , errPrice) in
                        for docPrice in snapPrice!.documents{
                            var priceData : [String:Any] = [
                                "price_id" : document.documentID,
                                "price_package" : docPrice.data()["price_package"],
                                "price_size"  : docPrice.data()["price_size"],
                                "price_value" : docPrice.data()["price_value"]
                            ]
                            
                            var priceDataList = Price(dictionary: priceData)
                            self.sharedArray.priceArray.append(priceDataList)
                             print("appending price data...")
                            
                        }
                    }
                }
               completion()
            
            }
            
         }
        
      
        
    }
    
    
    func config(){
        db = Firestore.firestore()
    }
    
    
}