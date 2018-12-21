//
//  loginViewController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 18/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Firebase

class loginViewController: UIViewController {
    
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var viewLogin : UIView!
    @IBOutlet weak var loginBtn : UIButton!
    @IBOutlet weak var emailText : UITextField!
    @IBOutlet weak var passText : UITextField!
    
    let helperCls  = helper()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
   //     backButton.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>) = UIImage.fontAwesomeIcon(name: .timesCircle, style: .solid, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
      
        let icon = UIImage.fontAwesomeIcon(name: .timesCircle, style: .solid, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        
        backButton.setImage(icon, for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        viewLogin.layer.cornerRadius = 10
        backButton.tintColor = UIColor.black
        loginBtn.layer.cornerRadius = 5
        
        //blureffect()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         // checkLogin()
    }
    
    
    
    
    func blureffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.addSubview(blurEffectView)
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginTapped(_ sender: Any) {
         print("enter login tapped")
        if  emailText.text == ""  && passText.text == "" {
          let  alert =   helperCls.alertHelper(alertMessage: "Please Enter Username And Password")
            present(alert, animated:  true , completion:  nil)
        }
        
        if emailText.text == "" {
            let  alert =   helperCls.alertHelper(alertMessage: "Please Enter Username")
            present(alert, animated:  true , completion:  nil)
        }
        
        if passText.text == "" {
            let  alert =   helperCls.alertHelper(alertMessage: "Please Enter Password")
            present(alert, animated:  true , completion:  nil)
        }
        
        
        if emailText.text != "" && passText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!, completion: {(user , error) in
                if let err = error {
                    print("ada error : \(err.localizedDescription)")
                }else{
                    print("testUser \(user)")
                }
            })
        }
        
        
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        if  emailText.text == ""  && passText.text == "" {
            let  alert =   helperCls.alertHelper(alertMessage: "Please Enter Username And Password")
            present(alert, animated:  true , completion:  nil)
        }
        
        if emailText.text == "" {
            let  alert =   helperCls.alertHelper(alertMessage: "Please Enter Username")
            present(alert, animated:  true , completion:  nil)
        }
        
        if passText.text == "" {
            let  alert =   helperCls.alertHelper(alertMessage: "Please Enter Password")
            present(alert, animated:  true , completion:  nil)
        }
        
        
        if emailText.text != "" && passText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passText.text!, completion: { (res, error)  in
                if let err = error {
                    print("ada error : \(err.localizedDescription)")
                }else{
                    print("testUser \(res)")
                }
            })
        }
        
    }
    
}
