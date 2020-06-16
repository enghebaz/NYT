//
//  AppManager.swift
//  NYT
//
//  Created by heba on 6/11/20.
//  Copyright © 2020 Heba. All rights reserved.
//


import UIKit

class AppManager: NSObject {

    
    //MARK:- Initilization
    static let shared = AppManager();
    
    private override init() {
        
    }
    
    //MARK:- Methods
    func handleAppLaunch(fromVC:UIViewController) {
      
        ServerManager.shared.refreshAppInfo { (objects, error) in
            
            ViewControllerUtils.pushListVCOn(navigationController: fromVC.navigationController!)
            
        }
    }
    
    
}
