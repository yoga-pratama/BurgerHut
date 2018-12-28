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
import Firebase

class HomeViewController: UIViewController {
  
    @IBOutlet var barButtonItem : UIBarButtonItem!
    @IBOutlet var barButtonItemRight : UIBarButtonItem!
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
            
            self.data.getCartData(username: "username1")
            
            let uid = Auth.auth().currentUser?.uid
            if uid != nil{
              self.data.getUserData(userid: uid!)
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
        
        var leftIcon = UIImage.fontAwesomeIcon(name: .userCircle, style: .solid, textColor: .white, size: CGSize(width: 40, height: 40))
        
         var rightIcon = UIImage.fontAwesomeIcon(name: .cartPlus, style: .solid, textColor: .white, size: CGSize(width: 30, height: 30))
        
        
        barButtonItem.image = leftIcon
        barButtonItem.tintColor = UIColor.white
        barButtonItemRight.image = rightIcon
        barButtonItemRight.tintColor = UIColor.white
    }
    
    
    
    func setTableView(){
        
     //   homeTableView.rowHeight = UITableView.automaticDimension
     //homeTableView.estimatedRowHeight = 300
      //  homeTableView.backgroundColor = UIColor.lightGray
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

    @IBAction func accountTapped(_ sender: UIBarButtonItem) {
      checkLogin()
    }
    
    
    
    func checkLogin(){
        if  Auth.auth().currentUser != nil{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "profileID") as! ProfileViewController
            //    self.present(newViewController, animated: true, completion: nil)
          self.navigationController!.pushViewController(newViewController, animated: true)
          //  self.navigationController!.showDetailViewController(newViewController, sender: nil)
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginID") as! loginViewController
            self.present(newViewController, animated: true, completion: nil)
        }
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
    
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
      
        
       // headerView.backgroundColor = UIColor(red: 236, green: 240, blue: 240, alpha: 1.0)
        let view = UIView()

        let label = UILabel()
        label.text = "Menu"
        label.frame = CGRect(x: 15, y: 5, width: 100, height: 35)
        view.addSubview(label)
        
        return view
    } */
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var text = ""
        switch section {
        case 0:
             text = "Latest Promo"
        case 1 :
             text = "Menu"
        case 2 :
             text = "News"
        default:
            break
        }
       
      return text
    }
   
}
