//
//  NYTFont.swift
//  NYT
//
//  Created by heba on 6/11/20.
//  Copyright © 2020 Heba. All rights reserved.
//


import UIKit

struct AppEnglishFontName {
    static let regular = "OpenSans-Regular"
    static let bold = "OpenSans-Bold"
    static let italic = "OpenSans-Italic"
}

extension UIFont {
    
    class func  NYTRegularFont()->UIFont {
        
        let fontName = AppEnglishFontName.regular
        
        if let font = UIFont(name:fontName, size: 17) {
            return font

        }
        return UIFont.systemFont(ofSize: 17)
    }
    
    class func  NYTBoldFont()->UIFont {
                
        let fontName = AppEnglishFontName.bold
        
        if let font = UIFont(name:fontName, size: 17) {
            return font
            
        }
        return UIFont.boldSystemFont(ofSize: 17.0)
    }

    class func  NYTItalicFont()->UIFont {
        
        let fontName = AppEnglishFontName.italic

        if let font = UIFont(name:fontName, size: 17) {
            return font
            
        }
        return UIFont.italicSystemFont(ofSize: 17)
    }
    
    class func getFontFactor() -> CGFloat{
        
        var factor:CGFloat = 0.003
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
               // Ipad
            factor = 0.0012
        }
        return factor;
    }
}
