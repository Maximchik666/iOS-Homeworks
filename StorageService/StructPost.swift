//
//  Struct Post.swift
//  Navigation
//
//  Created by Maksim Kruglov on 17.08.2022.
//

import Foundation
import UIKit

public struct Post {
    
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    public var id: Int
}

var post1 = Post(author: String(localized: "postDtfName"), description: String(localized: "postDtfText"), image: "IMG-1", likes: 350, views: 1000, id: 1)
var post2 = Post(author: String(localized: "postKinopoiskName"), description: String(localized: "postKinopoiskText"), image: "IMG-2", likes: 450, views: 1300, id: 2)
var post3 = Post(author: String(localized: "postKronenbergName"), description: String(localized: "postKronenbergText"), image: "IMG-3", likes: 300, views: 700, id: 3)

public var viewModel = [post1, post2, post3]

public var photoContainer = [UIImage(named:"IMG-5")!, UIImage(named:"IMG-6")!, UIImage(named:"IMG-7")!, UIImage(named:"IMG-8")!, UIImage(named:"IMG-9")!, UIImage(named:"IMG-10")!, UIImage(named:"IMG-11")!, UIImage(named:"IMG-12")!, UIImage(named:"IMG-13")!, UIImage(named:"IMG-14")!, UIImage(named:"IMG-15")!, UIImage(named:"IMG-16")!, UIImage(named:"IMG-17")!, UIImage(named:"IMG-18")!, UIImage(named:"IMG-19")!, UIImage(named:"IMG-20")!, UIImage(named:"IMG-21")!, UIImage(named:"IMG-22")!, UIImage(named:"IMG-23")!, UIImage(named:"IMG-24")!, UIImage(named:"IMG-25")!, UIImage(named:"IMG-26")!, UIImage(named:"IMG-27")!]

