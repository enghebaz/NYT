//
//  MBProgressManager.swift
//  NYT
//
//  Created by heba on 2/24/20.
//  Copyright © 2020 Heba. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class MBProgressManager: NSObject {
    
//    let hud:MBProgressHUD?
    
    //MARK:- Initilization
    static let shared = MBProgressManager();
    
    private override init() {
        
    }
    
    //MARK:- Methods
    func showProgress(vc:UIViewController) {
        
        let hud = MBProgressHUD.showAdded(to: vc.view, animated: true)
        hud.mode = .determinate
    }
    
    func hideProgrss(vc:UIViewController) {
        
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
    
}
