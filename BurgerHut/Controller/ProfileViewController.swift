//
//  ProfileViewController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 20/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var fullnameText : UITextField?
    @IBOutlet weak var emailText:UITextField?
    @IBOutlet weak var phoneText : UITextField?
    @IBOutlet weak var addrText : UITextView?
    @IBOutlet weak var MapView :  MKMapView?
    @IBOutlet weak var fullnameBtn : UIButton?
    @IBOutlet weak var phoneBtn : UIButton?
    @IBOutlet weak var addrBtn : UIButton?
    @IBOutlet weak var detailView : UIView?
    @IBOutlet weak var addView : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       setShadow()
    }
    
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
       self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
             self.navigationController?.popToRootViewController(animated: true)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    func setShadow(){
        detailView?.layer.cornerRadius = 5
        detailView?.layer.shadowColor = UIColor.lightGray.cgColor
        detailView?.layer.shadowOpacity = 5
        detailView?.layer.shadowOffset =  CGSize.zero
        detailView?.layer.shadowRadius = 5
        addView?.layer.cornerRadius = 5
        addView?.layer.shadowColor = UIColor.lightGray.cgColor
        addView?.layer.shadowOpacity = 5
        addView?.layer.shadowOffset =  CGSize.zero
        addView?.layer.shadowRadius = 5
        
        MapView?.layer.cornerRadius = 5
        MapView?.layer.shadowColor = UIColor.lightGray.cgColor
        MapView?.layer.shadowOpacity = 5
        MapView?.layer.shadowOffset =  CGSize.zero
        MapView?.layer.shadowRadius = 5
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
