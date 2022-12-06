//
//  DataModel.swift
//  Navigation
//
//  Created by Maksim Kruglov on 04.12.2022.
//

import Foundation

struct DataForFileTab {
    
    var name: String
    var type: ContentType
    
}

enum ContentType: String {
    case file = "File"
    case folder = "Folder"
}
