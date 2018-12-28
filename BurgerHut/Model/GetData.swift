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

                        for doc in snapPrice!.documents{
                            let price_data = doc.data()["price_data"] as! NSArray
                            print("appending price data....")
                            for i  in 0..<price_data.count{
                                let price_dict = price_data[i] as! [String:Any]
                                let priceData = [
                                    "price_id" : document.documentID,
                                    "size_id" : price_dict["size_id"],
                                    "price_name" : price_dict["price_name"],
                                    "price_value" : price_dict["price_value"]
                                ]
                                
                                var priceDataList = Price(dictionary: priceData)
                            
                                self.sharedArray.priceArray.append(priceDataList)
                            }
                          
                
                        }
                    
                    }
                }
               completion()
            
            }
            
         }
        
      
        
    }
    
    
    func getCartData(username : String){
        config()
  db.collection("cart").document("username1").collection("cart_detail").getDocuments(){ (docs, err) in
        if let err = err {
            print("error get cart document: \(err)")
        }else{
            print("appending cart items...")
            self.sharedArray.cartArray.removeAll()
            for doc in docs!.documents {
                var cart_detail : [String:Any] = [
                            "cart_id" : doc.documentID,
                            "cart_qty" : doc.data()["cart_qty"],
                            "cart_value" :doc.data()["cart_value"],
                            "food_name" : doc.data()["food_name"],
                            "food_size" : doc.data()["food_size"],
                            "user_id"      : doc.data()["user_id"]
                ]
                let CartDataList = cart(dictionary: cart_detail)
                self.sharedArray.cartArray.append(CartDataList)
            }
        }
            
         }
        
    }
    
    
    func getUserData(userid : String){
        config()
        db.collection("userData").document(userid).getDocument(){
            (document, error ) in
            if let err = error {
                print("error get user document: \(err)")
            }else{
                print("get userprofile data....")
                var userData : [String : Any ] = [
                    "phone_number" : document?.get("phone_number"),
                    "address" : document?.get("address"),
                    "coord" : [document?.get("geoloc")]
                ]
                
                let userDetail = userprofile(dictionary: userData)
                self.sharedArray.userArray.append(userDetail)
            }
        }
    }
    
    
    func config(){
        db = Firestore.firestore()
    
    }
    
    
}
