//
//  AlertUtils.swift
//  NYT
//
//  Created by heba on 6/11/20.
//  Copyright © 2020 Heba. All rights reserved.
//
import Foundation
import UIKit

class AlertUtils: NSObject {
    
    class func showErrorAlertWith(title:String, message:String, vc:UIViewController, actionBlock: ActionBlock!) {
        
        AlertUtils.showOneButtonAlertWith(title: title, message: message, buttonTitle: NSLocalizedString("OK", comment: ""), vc: vc, actionBlock: actionBlock)
    }
    
    class func showOneButtonAlertWith(title:String, message:String, buttonTitle:String, vc:UIViewController, actionBlock: ActionBlock!) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
       
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: { (action) in
            
            if (actionBlock != nil) {
                actionBlock()
            }
        }))
        
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    class func showMultiButtonsAlertWith(title:String, message:String, buttonTitles:Array<String>, vc:UIViewController, actionBlock: AlertCompletionBlock!) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        
        buttonTitles.forEach { (bTitle) in
            alert.addAction(UIAlertAction(title: bTitle, style: UIAlertAction.Style.default, handler: { (action) in
                
                if (actionBlock != nil) {
                    let index=buttonTitles.firstIndex(of: bTitle)
                    actionBlock(index!)
                }
            }))
        }
        
        
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    class func showOfflineAlertWith(vc:UIViewController, actionBlock: AlertCompletionBlock!) {
        
        let buttons=[NSLocalizedString("SETTINGS_BUTTON", comment: ""),NSLocalizedString("RETRY_BUTTON", comment: ""), NSLocalizedString("DISCARD_BUTTON", comment: "")]
        AlertUtils.showMultiButtonsAlertWith(title: NSLocalizedString("NETWORK_PROBLEM_TITLE", comment: ""), message: NSLocalizedString("NETWORK_PROBLEM_MESSAGE", comment: ""), buttonTitles: buttons, vc: vc, actionBlock: actionBlock)
        
    }
    
    
}
