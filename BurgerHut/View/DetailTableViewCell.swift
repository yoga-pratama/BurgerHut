//
//  DetailTableViewCell.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 12/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    var menuID  : String!
    var pricePcs : Int!
    var priceSize : String!
    var helperC  = helper()
    @IBOutlet weak var priceValText : UILabel!
    @IBOutlet weak var qtyText : UILabel!
    @IBOutlet weak var qtyStep : UIStepper!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func data(menuID : String , pricePcs : Int , priceSize : String){
        self.menuID = menuID
        self.pricePcs = pricePcs
        self.priceSize = priceSize
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func stepperChanged(_ sender: UIStepper) {
        var stepValue =  Int(qtyStep.value)
        var total =  stepValue * pricePcs as NSNumber
     
        var formatter = helperC.formatter(value: total)
        qtyText.text  = "Qty \(stepValue)"
        priceValText.text = "Total : \(formatter)"
    }
}
