//
//  barTabBarController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 05/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class barTabBarController: UITabBarController {
    
    @IBOutlet var tabbar : UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabBar()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupTabBar(){
        let home = (self.tabbar.items?[0])! as UITabBarItem
        
        home.image = UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: UIColor.blue, size: CGSize(width: 40 , height: 40))
        
        home.titlePositionAdjustment = UIOffset(horizontal: 0.0,vertical: 1.0)
        
        let menu = (self.tabbar.items?[1])! as UITabBarItem
        
         menu.image = UIImage.fontAwesomeIcon(name: .list, style: .solid, textColor: UIColor.blue, size: CGSize(width: 40 , height: 40))
        
         menu.titlePositionAdjustment = UIOffset(horizontal: 0.0,vertical: 1.0)
        
        
        let order = (self.tabbar.items?[2])! as UITabBarItem
        
        order.image = UIImage.fontAwesomeIcon(name: .utensils, style: .solid, textColor: UIColor.blue, size: CGSize(width: 40 , height: 40))
        
        order.titlePositionAdjustment = UIOffset(horizontal: 0.0,vertical: 1.0)
        
        
    }

}
