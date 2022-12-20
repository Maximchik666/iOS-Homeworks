//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Maksim Kruglov on 20.12.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let defaultManager = CoreDataManager()
    var posts: [PostModel] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    init() {
        reloadPosts()
    }
    
    func addPost(author: String, likes: Int64, views: Int64, descr: String, image: String, id: Int64) {
        if posts.contains(where: { i in i.id == id}) {
            return
        } else {
            let newPost = PostModel(context: persistentContainer.viewContext)
            newPost.author = author
            newPost.likes = likes
            newPost.views = views
            newPost.descr = descr
            newPost.image = image
            newPost.id = id
            saveContext()
            reloadPosts()
        }
    }
    
    func reloadPosts(){
        
        let request = PostModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        do {
            let fetchedPosts = try persistentContainer.viewContext.fetch(request)
            posts = fetchedPosts
        } catch {
            print("error")
            posts = []
        }
    }
    
    func deleteAllPosts(){
        let answer = PostModel.fetchRequest ()
        do {
            let posts = try persistentContainer.viewContext.fetch(answer)
            let context = persistentContainer.viewContext
            for post in posts {
                context.delete(post)
            }
            saveContext ()
        } catch {
            print (error)
        }
    }
}
