//
//  PickerSizeViewController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 11/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class PickerSizeViewController: UIViewController {

    @IBOutlet weak var pickerPrice: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
