//
//  ProfileViewController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 20/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var welcomeText  : UILabel?
    @IBOutlet weak var fullnameText : UITextField?
    @IBOutlet weak var emailText:UITextField?
    @IBOutlet weak var phoneText : UITextField?
    @IBOutlet weak var addrText : UITextView?
    @IBOutlet weak var mapView :  MKMapView?
    @IBOutlet weak var detailView : UIView?
    @IBOutlet weak var addView : UIView?
    @IBOutlet weak var editBtn : UIButton!
    @IBOutlet weak var saveBtn : UIButton!
    @IBOutlet weak var logoutBtn : UIBarButtonItem!
    
    let locMgr  =  CLLocationManager()
    let saveCls = saveData()
    let getCls = Getdata()
    let array = ArrayCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
       emailText?.isEnabled = false
       addrText?.isEditable = false
       mapView?.delegate = self
        locMgr.delegate = self
       setShadow()
       setBtnIcon()
       setTextState(state: false)
       checkLocAuth()
       setInitialValue()
      
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
    
    @IBAction func editTapped(_ sender: UIButton) {
        setTextState(state: true)
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
        
        mapView?.layer.cornerRadius = 5
        mapView?.layer.shadowColor = UIColor.lightGray.cgColor
        mapView?.layer.shadowOpacity = 5
        mapView?.layer.shadowOffset =  CGSize.zero
        mapView?.layer.shadowRadius = 5
    }
    
    func setBtnIcon(){
        let editIcon = UIImage.fontAwesomeIcon(name: .edit, style: .solid, textColor: UIColor.white, size: CGSize(width: 35, height: 35))
      editBtn.setImage(editIcon, for: .normal)

      editBtn.imageView?.contentMode = .scaleAspectFit
      editBtn.tintColor = UIColor.black
    }
    
    func setTextState(state: Bool){
       fullnameText?.isEnabled = state
       phoneText?.isEnabled = state
     //  addrText?.isEditable = state
       saveBtn.isHidden = !state
       logoutBtn.isEnabled = !state
       addMapTrackBtn(state : state)
    }
    
    func checkLocAuth(){
       if  CLLocationManager.authorizationStatus() != .authorizedWhenInUse{
         locMgr.requestWhenInUseAuthorization()
        }else{
        locMgr.startUpdatingLocation()
       // mapView?.setCenter(CLLocationCoordinate2D(latitude: locMgr.location!.coordinate.latitude, longitude: locMgr.location!.coordinate.longitude), animated: true)
        //Zoom to user location
        if let userLocation = locMgr.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView?.setRegion(viewRegion, animated: false)
        }
        }
    }
    
    
    @IBAction func saveTapped(_ sender: UIButton) {
        setTextState(state: false)
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName =  fullnameText?.text
        changeRequest?.commitChanges{(error ) in
            if  error == nil {
                let userData  : [String :Any] = [
                  "phone_number" : self.phoneText?.text ,
                  "address" : self.addrText?.text ,
                  "geoloc" : [
                    "longitude" : self.locMgr.location?.coordinate.longitude,
                    "latitude" : self.locMgr.location?.coordinate.latitude
                  ]
                ]
                let userID = Auth.auth().currentUser?.uid
                self.saveCls.userUpdateProfile(username: userID!, data: userData)
                self.setTextState(state: false)
            }
        }
    }
    
    func addMapTrackBtn(state : Bool){
        
        if  state == true {
            let btnItem = MKUserTrackingButton(mapView: mapView)
            btnItem.frame = CGRect(origin: CGPoint(x: 5, y:5
            ), size: CGSize(width: 35, height: 35))
            mapView?.addSubview(btnItem)
        }else{
            
        }
       
        
     //   btnItem.layer.borderWidth = 2
      //  btnItem.layer.borderColor = UIColor(red: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0).cgColor
       // btnItem.layer.borderColor = UIColor.black.cgColor
      //  btnItem.layer.cornerRadius = 5
      //  btnItem.mapView?.tintColor = UIColor.blue
        
        
    }
    
    func setInitialValue(){
        fullnameText?.text = Auth.auth().currentUser?.displayName
        emailText?.text = Auth.auth().currentUser?.email
        
        if   fullnameText?.text != nil {
            let username = fullnameText?.text
            welcomeText?.text = "Welcome,\(username!)"
        }else{
            welcomeText?.text = "Welcome,"
        }
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

extension ProfileViewController : MKMapViewDelegate , CLLocationManagerDelegate{
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(userLocation.location!, completionHandler: {(place , error) in
            let pm = place! as [CLPlacemark]
            if pm.count > 0 {
                let pm = place![0]
                var addr : String = ""
                
                addr = "\(pm.locality!) \(pm.thoroughfare!) \(pm.postalCode!) \(pm.subAdministrativeArea!) \(pm.subThoroughfare!) \(pm.subLocality!)"
                
               self.addrText?.text = addr
            }
        })
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    
}
