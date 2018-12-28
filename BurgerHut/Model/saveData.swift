//
//  saveData.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 13/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation
import Firebase

class saveData{
    var db: Firestore!
    static let sharedInstance = saveData()
    let dataShared = ArrayCollection.sharedArray
    let getData = Getdata.sharedInstance
    
    func config(){
        db = Firestore.firestore()
    }
    
    
    func saveCart(cart_qty : Int , cart_value : Int,food_name : String , food_size : String,username : String ){
        config()
       
      /*  if documentId.isEmpty == false{
            let prevCart = dataShared.cartArray.filter{
                 return $0.user_id == username && $0.food_name == food_name && $0.food_size == food_size
            }
            if  prevCart.count != 0 {
                for cart in prevCart{
                    let cartData : [String:Any] = [
                        "cart_id" : cart.cart_id,
                        "cart_qty" : cart_qty ,
                        "cart_value" : cart_value ,
                        "food_name" : food_name,
                        "food_size" : food_size,
                        "last_update" : NSDate(),
                        "user_id"  : username
                        ]
                    db.collection("cart").document(username).collection("cart_detail").document(documentId).setData(["cart_detail" : [cartData]])
                }
            }else{
                var cart_dataID = UUID().uuidString
                let cartData : [String:Any] = [
                    "cart_id" : cart_dataID ,
                    "cart_qty" : cart_qty ,
                    "cart_value" : cart_value ,
                    "food_name" : food_name,
                    "food_size" : food_size ,
                    "last_update" : NSDate(),
                    "user_id" : username
                ]
                
        db.collection("cart").document(username).collection("cart_detail").document(documentId).updateData(["cart_detail" : FieldValue.arrayUnion([cartData])])
            }
           
            
        }else{
            var cart_dataID = UUID().uuidString
            let cartData : [String:Any] = [
                "cart_id" : cart_dataID ,
                "cart_qty" : cart_qty ,
                "cart_value" : cart_value ,
                "food_name" : food_name,
                "food_size" : food_size ,
                "last_update" : NSDate(),
                "user_id" : username
            ]

            db.collection("cart").document(username).collection("cart_detail").document().setData(["cart_detail" : [cartData]])
            
            getData.getCartData(username: username)
            
        } */
        
        let prevData = dataShared.cartArray.filter(){
             return $0.food_name == food_name && $0.food_size == food_size && $0.user_id == username
        }
        
        if  prevData.isEmpty{
            db.collection("cart").document(username).collection("cart_detail").addDocument(data: [
                "cart_id" : "",
                "cart_qty" : cart_qty ,
                "cart_value" : cart_value ,
                "food_name" : food_name,
                "food_size" : food_size ,
                "last_update" : NSDate(),
                "user_id" : username])
            
        }else{
            for prev in prevData{
       db.collection("cart").document(username).collection("cart_detail").document(prev.cart_id).setData([
            "cart_id" : prev.cart_id,
            "cart_qty" : cart_qty ,
            "cart_value" : cart_value ,
            "food_name" : food_name,
            "food_size" : food_size ,
            "last_update" : NSDate(),
            "user_id" : username
            ])
                
            }
        }
  
         getData.getCartData(username: username)
    }
    
    func deleteCart(_ docid : String, username : String, retVal: @escaping (_ val : Int) -> Void){
        config()
      
        db.collection("cart").document(username).collection("cart_detail").document(docid).delete(){(err) in
            if err != nil {
               retVal(1)
            }else{
                print("Doc : \(docid) deleted")
                retVal(0)
            }
        }
        
    }
    
    
    func userUpdateProfile(username : String , data : [String:Any]){
            config()
          db.collection("userData").document(username).setData(data)
    }
  
}
