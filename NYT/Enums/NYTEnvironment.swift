//
//  NYTLevel.swift
//  NYT
//
//  Created by heba on 6/11/20.
//  Copyright © 2020 Heba. All rights reserved.
//


import UIKit


enum Environment {
    case Production
    case Staging
    
    
    var url: String {
        
        switch self {
        case .Production:
            return "http://api.nytimes.com/svc/mostpopular/v2/"
        case .Staging:
            return "http://stgapi.nytimes.com/svc/mostpopular/v2"
        }
    }

}

