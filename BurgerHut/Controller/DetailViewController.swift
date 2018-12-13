//
//  DetailViewController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 11/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit
import  FontAwesome_swift

class DetailViewController: UIViewController {
    
    static let dataShared =  DetailViewController()
    var MenuId : String!
    var picID : String!
    var menuName : String!
    let classHelper = helper()
    var priceArray : [Price] = []
    var priceData : Price!
   
    
    
    @IBOutlet weak var foodSize: UISegmentedControl!
    @IBOutlet weak var food_name: UILabel!
    @IBOutlet weak var food_pic: UIImageView!
    @IBOutlet weak var priceTableView: UITableView!
    @IBOutlet weak var CartBtn: UIBarButtonItem!
    @IBOutlet weak var food_price : UILabel!
    @IBOutlet weak var addToCartBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    //    setupSubView()
        priceArray =  classHelper.getPrice(menuid: MenuId)
        priceTableView.tableFooterView = UIView()
        rightBarNav()
        setTopSection()
        setSegmentControl()
       
    }
    
   // 112221
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupSubView(){
    
    }
    
    
 
    
    func rightBarNav(){
        var rightIcon = UIImage.fontAwesomeIcon(name: .cartPlus, style: .solid, textColor: .white, size: CGSize(width: 30, height: 30))
        
        
        CartBtn.image = rightIcon
        CartBtn.tintColor = UIColor.white
    }
    
    
    func setTopSection(){
        food_name.text = menuName
        let image = UIImage(named: picID)
        food_pic.image = image
        food_pic.clipsToBounds = true
        food_pic.layer.cornerRadius = 10
    }
    
    func setSegmentControl(){
        foodSize.removeAllSegments()
        
     //
        var count = 0
        for price in priceArray{
          foodSize.insertSegment(withTitle: price.price_name, at: count, animated: true)
            count += 1
        }
        
        if   priceArray.count != 0 {
        foodSize.selectedSegmentIndex = 0
        priceData = priceArray[foodSize.selectedSegmentIndex]
        let formatPrice = classHelper.formatter(value: priceData.price_value)
        food_price.text = "\(formatPrice) /pcs"
            priceTableView.reloadData()
            
        }
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        let index = IndexPath(row: 0, section: 0)
        let cell = priceTableView.cellForRow(at: index) as! DetailTableViewCell
        
        let qty =  Int(cell.qtyStep.value)
        var total = qty * Int(priceData.price_value)
        
        let alert = UIAlertController(title: "Confirmation", message: "Add To Cart? ", preferredStyle: .alert)
        
        let alertActionOk = UIAlertAction.init(title: "Ok", style: .default, handler: { actionHandler in
            print("oke")
        })
        
        let alertActionCancl = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(alertActionOk)
        alert.addAction(alertActionCancl)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        print("masuk")
        priceData = priceArray[foodSize.selectedSegmentIndex]
        let formatPrice = classHelper.formatter(value: priceData.price_value)
        food_price.text = "\(formatPrice) /pcs"
        priceTableView.reloadData()
    }
}

extension DetailViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = priceTableView.dequeueReusableCell(withIdentifier: "DetailViewTableCell", for: indexPath) as! DetailTableViewCell
        
        
        cell.qtyStep.value = 0.0
        cell.qtyStep.autorepeat = true
        cell.qtyStep.wraps = true
        cell.qtyStep.maximumValue = 10
        cell.qtyText.text = "Qty"
        cell.priceValText.text = "Total"
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.lightGray.cgColor
        if  priceData != nil{
            cell.data(menuID: MenuId, pricePcs: Int(priceData.price_value) , priceSize: priceData.price_name)
        }
        
        return cell
    }
    
    
}






