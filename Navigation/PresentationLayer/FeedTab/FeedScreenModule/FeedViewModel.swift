//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Maksim Kruglov on 30.10.2022.
//

import Foundation


class FeedViewModel {
    
    var feedModel = FeedModel()
    
    func check (word: String) -> Bool {
        word == feedModel.password
        
    }
}
