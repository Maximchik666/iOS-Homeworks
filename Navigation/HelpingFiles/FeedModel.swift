//
//  FeedModel.swift
//  Navigation
//
//  Created by Maksim Kruglov on 23.10.2022.
//

import Foundation
import UIKit

class FeedModel {
    
    var password: String = "123"
    
    func check (word: String) -> Bool {
        if word == password {return true} else {return false}
    }
}
