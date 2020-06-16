//
//  ViewUtils.swift
//  NYT
//
//  Created by heba on 6/11/20.
//  Copyright © 2020 Heba. All rights reserved.
//

import UIKit

class ViewUtils: NSObject {

    //MARK:- View Style
    class func updateViewWithShadow(view:UIView) {
        
        view.layer.shadowColor = UIColor.NYTOverlayColor().cgColor;
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize.init(width: 0, height: 5.0)
        view.layer.shadowRadius = 5.0
    }
}


