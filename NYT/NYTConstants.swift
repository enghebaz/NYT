//
//  NYTConstants.swift
//  NYT
//
//  Created by heba on 2/4/20.
//  Copyright © 2020 Heba. All rights reserved.
//

import Foundation

let environment:Environment = .Production

let APIKey = "9bexX2y8VGzad5QSShZDTJ73RTu3kKx0"

typealias ActionBlock = () -> Void
typealias SucessBlock = (Any?) -> Void
typealias ErrorBlock = (Error?) -> Void
typealias ViewCompletionBlock = (Any?, Bool, Error?) -> Void
typealias RequestCompletionBlock = (Any?, Error?) -> Void
typealias AlertCompletionBlock = (Int) -> Void
