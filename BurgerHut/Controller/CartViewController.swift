//
//  CartViewController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 17/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit
import  FontAwesome_swift
import  Firebase

class CartViewController: UIViewController {
    
    @IBOutlet weak var backBtn : UIBarButtonItem!
    @IBOutlet weak var tableCart : UITableView!
    
    let data = ArrayCollection.sharedArray
    let help = helper()
    let query = saveData()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func orderFood(_ sender: Any) {
        if  Auth.auth().currentUser != nil{
            print(Auth.auth().currentUser?.email)
        }else{
            let alertCon = UIAlertController(title: "User Authentication", message: "Please Login to order ", preferredStyle: .alert)
            
            let GoToLogin = UIAlertAction(title: "Go to Login", style: .default, handler: {(alert: UIAlertAction!) in
                 print("clicked")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginID") as! loginViewController
                self.present(newViewController, animated: true, completion: nil)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertCon.addAction(GoToLogin)
            alertCon.addAction(cancelAction)
            
            present(alertCon, animated: true, completion: nil)
        }
    }
    
    @IBAction func BackAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}


extension CartViewController  : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableCart.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
         let dataCart = data.cartArray[indexPath.row]
        
        let food_name = "\(dataCart.food_name) - \(dataCart.food_size)"
        let Qty = "Qty : \(dataCart.cart_qty)"
        let Val =  help.formatter(value: dataCart.cart_value)
        let detail = "\(Qty) \(Val)"
         cell.food_name.text = food_name
         cell.cart_detail.text = detail
        
        
        return cell
        
    }
    
 /*   func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "", handler: {
            (action , view , completion) in
     
     
        })
     
        action.image =  UIImage.fontAwesomeIcon(name: .trash, style: .solid, textColor: UIColor.blue, size: CGSize(width: 40 , height: 40))
     
        action.backgroundColor = UIColor.red
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    } */
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "", handler: {
            (action , view , completion) in
            let dataCart = self.data.cartArray[indexPath.row]
            self.query.deleteCart(dataCart.cart_id, username: dataCart.user_id, retVal: {(ret) in
                if  ret != 0 {
                    print("error deleting cart data")
                }else{
                    self.data.cartArray.remove(at: indexPath.row)
                    self.tableCart.deleteRows(at: [indexPath], with: .fade)
                }
            })
        })
        
        action.image =  UIImage.fontAwesomeIcon(name: .trash, style: .solid, textColor: UIColor.blue, size: CGSize(width: 40 , height: 40))
        
        action.backgroundColor = UIColor.red
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
    
  /*  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
           // self.tableArray.remove(at: indexPath.row)
         //   tableView.deleteRows(at: [indexPath], with: .fade)
          //  print(self.tableArray)
        }
        
        return [delete]
    } */
    
    
    
}
