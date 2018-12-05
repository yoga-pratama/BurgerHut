//
//  HomeViewController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 05/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit
import Foundation
import FontAwesome_swift


class HomeViewController: UIViewController {
  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHeader()
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
    
    func setHeader(){
     /*   let logo = UIImage(named: "bugerhut3")
        let imageView = UIImageView(image: logo)
       imageView.contentMode = .scaleAspectFit // set imageview's content mode
        self.navigationItem.titleView = imageView */
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    
    /*    let imageView2 = UIImageView(image: UIImage.fontAwesomeIcon(name: .userCircle, style: .solid, textColor: .white, size: CGSize(width: 30, height: 30)))
        imageView2.contentMode = .scaleAspectFill
        let item = UIBarButtonItem(customView: imageView2)
        self.navigationItem.rightBarButtonItem = item */
        
       
    }

}
