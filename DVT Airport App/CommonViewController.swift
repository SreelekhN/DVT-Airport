//
//  CommonViewController.swift
//  DVT Airport App
//
//  Created by Exalture Software Labs on 10/09/19.
//  Copyright © 2019 Teenu Abraham. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController,SharedAlertDelegate {
    
    var param: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setClearNavigationBar()
        SharedAlertController.sharedAlert.alertdelegate = self
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
}
