//
//  detailMenuTableViewCell.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 10/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class detailMenuTableViewCell: UITableViewCell {
    
    var classHelper = helper()
    
    var dataPrice : NSArray!
    @IBOutlet var price_size : UILabel!
    @IBOutlet var price_value : UILabel!
    @IBOutlet var menu_qty_stepper  : UIStepper!
    @IBOutlet var menu_qty_lbl : UILabel!
    @IBOutlet var menu_package : UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // print("price : \(priceData)")
    }
    
    func dataPrice(data : NSArray){
        self.dataPrice = data
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        print("stepper change")
        menu_qty_lbl.text = Int(sender.value).description
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if menu_package.isOn  == true {
            let formater = classHelper.formatter(value: dataPrice.lastObject as! NSNumber)
            price_value.text = formater
        }else{
            let formater = classHelper.formatter(value: dataPrice.firstObject as! NSNumber)
            price_value.text = formater
            
        }
    }
}
