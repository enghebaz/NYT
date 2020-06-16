//
//  ViewController.swift
//  NYT
//
//  Created by heba on 10/28/19.
//  Copyright © 2020 Heba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.NYTBGColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        AppManager.shared.handleAppLaunch(fromVC: self)
    }


}

