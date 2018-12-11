//
//  DetailMenuViewController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 10/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class DetailMenuViewController: UIViewController {
    
    var menuID : String!
    var data = ArrayCollection.sharedArray
    var classHelper = helper()
    
    
    @IBOutlet var menu_nameLbl : UILabel!
    @IBOutlet var menu_pic : UIImageView!
   
    @IBOutlet var detailTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let menuData = data.menuArray.filter{
            return $0.menu_id == menuID
        }.first
        
        let imageData = UIImage(named: menuData!.menu_pic)
       menu_nameLbl.text = menuData!.menu_name
       menu_pic.image = imageData
        
    }
    
  

   
    @IBAction func backButtonTapped(_ sender : UIButton){
         self.dismiss(animated: true, completion: nil)
    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DetailMenuViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int!
        
        count = data.priceArray.filter{
            return $0.price_id == menuID
        }.count
    
        
        return count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailTableViewCell") as! detailMenuTableViewCell
        
        let priceDatas = data.priceArray.filter{
            return $0.price_id ==  menuID
        }
        
        let priceData = priceDatas[indexPath.row]
        
        cell.price_size.text = priceData.price_size
        cell.menu_qty_stepper.wraps = true
        cell.menu_qty_stepper.maximumValue = 10
        cell.menu_qty_stepper.autorepeat = true
        if  priceData.price_package == false{
            cell.menu_package.isUserInteractionEnabled = false
        }else{
              cell.menu_package.isUserInteractionEnabled = true
        }
        
        if cell.menu_package.isOn {
            let  price = priceData.price_value.lastObject as! NSNumber
            let formatter = classHelper.formatter(value: price)
            cell.price_value.text = formatter
        }else{
            let  price = priceData.price_value.firstObject as! NSNumber
            let priceArray = priceData.price_value as! NSArray
            let formatter = classHelper.formatter(value: price)
            cell.price_value.text = formatter
            cell.dataPrice(data: priceArray)
            
          
        }
       
        
       
        
        return cell
    }
    
    
}
