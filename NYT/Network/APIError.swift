//
//  APIError.swift
//  NYT
//
//  Created by Heba on 3/28/18.
//  Copyright © 2020 Heba. All rights reserved.
//

import UIKit

enum APIError: String {
    case ReadMore = "YOU_DONNOT_HAVE_ENOUGH_COINS"
    case GameUnlockedAlready = "GAME_ALREADY_AVAILABLE"
    case WrongUserName = "STUDENT_IS_NOT_EXIST"
    case B2BUser = "STUDENT_EMAIL_IS_NOT_EXIST"
    case CategoryDisabled = "CATEGORY_DISABLED_FOR_THIS_STUDENT"
    case SavedExsit = "SAVED_FOR_LATER_EXIST"
    case Unknown

    init(rawValue: String) {
        switch rawValue.uppercased() {
            case "YOU_DONNOT_HAVE_ENOUGH_COINS":
                self = .ReadMore
            case "GAME_ALREADY_AVAILABLE":
                self = .GameUnlockedAlready
            case "STUDENT_IS_NOT_EXIST":
                self = .WrongUserName
            case "STUDENT_EMAIL_IS_NOT_EXIST":
                self = .B2BUser
            case "CATEGORY_DISABLED_FOR_THIS_STUDENT":
                self = .CategoryDisabled
        default:
            self = .Unknown
        }
    }
    
}
