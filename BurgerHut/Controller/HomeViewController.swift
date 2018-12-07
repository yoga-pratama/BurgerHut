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
  
    @IBOutlet var barButtonItem : UIBarButtonItem!
    @IBOutlet var homeTableView : UITableView!
    
    var dataPromo : [promo] = []
    let data = Getdata.sharedInstance
    var countindex : Int = 0
    var countSection : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHeader()
        setTableView()
        setReload()
        
        data.getPromoData{
            self.data.getMenu {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }
         
            
        }
    
         
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
        
        var rightIcon = UIImage.fontAwesomeIcon(name: .userCircle, style: .solid, textColor: .white, size: CGSize(width: 40, height: 40))
        
        
        barButtonItem.image = rightIcon
        barButtonItem.tintColor = UIColor.white
    }
    
    
    
    func setTableView(){
        
     //   homeTableView.rowHeight = UITableView.automaticDimension
     //homeTableView.estimatedRowHeight = 300
    }
    
    func setReload(){
     NotificationCenter.default.addObserver(self, selector: #selector(reload), name:NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func reload(notification: NSNotification){
        //self.favoritesCV.reloadData()
        //  self.collView.reloadSections(IndexSet(integer: 0))
        self.homeTableView.reloadData()
        print("reload data")
    }


}


extension HomeViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableCellTableViewCell
        cell.homeCollectionView.reloadData()
       
        switch indexPath.section {
        case 0:
             cell.TableSize = "small_banner"
        case 1 :
             cell.TableSize = "menu_banner"
        case 2 :
             cell.TableSize = "large_banner"
        default:
            cell.TableSize = ""
        }
        
      return cell
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
 /*   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    } */
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       
        var size : CGFloat!
    
      switch indexPath.section {
        case 0:
          size  = 175
        case 1:
          size =  200
        case 2:
          size = 250
        default:
            size = UITableView.automaticDimension
        }
         

        return size
        
    
        
       
    }
}
