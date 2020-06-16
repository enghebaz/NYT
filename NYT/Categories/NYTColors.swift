//
//  NYTColors.swift
//  NYT
//
//  Created by heba on 6/11/20.
//  Copyright © 2020 Heba. All rights reserved.
//


import UIKit

extension UIColor {
    
    class func  NYTBGColor()->UIColor {
        
        var color = hexStringToUIColor(hex:"#F7F7FE")
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            
            color = hexStringToUIColor(hex:"#F7F7FE")
        }
    
        return  color
    }
    
    class func  NYTOverlayColor()->UIColor {
        
        var color = hexStringToUIColor(hex:"#8A8D96")
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            
            color = hexStringToUIColor(hex:"#8A8D96")
        }
        
        return  color
    }
    
    class func  NYTTurquoiseColor()->UIColor {
        
        var color = hexStringToUIColor(hex:"#3DE0B4")
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            
            color = hexStringToUIColor(hex:"#3DE0B4")
        }
        
        return  color
    }
    

    //MARK:- Method
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
