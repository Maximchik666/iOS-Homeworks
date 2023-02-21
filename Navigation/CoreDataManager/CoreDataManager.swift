//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Maksim Kruglov on 20.12.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let defaultManager = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
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
    
    func saveBackgroundContext () {
        let context = backgroundContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addKey () {
        let fetchRequest = RealmKey.fetchRequest()
        if ((try? persistentContainer.viewContext.fetch(fetchRequest))?.first) == nil {
            let realmKey = RealmKey(context: persistentContainer.viewContext)
            realmKey.key = Data(count: 64)
            saveContext()
            print ("GO GO GO GO GO GO")
        } else {
            print ("NO NO NO NO NO NO")
            return
        }
    }
    
    func addPost(author: String, likes: Int64, views: Int64, descr: String, image: String, id: Int64) {
        let fetchRequest = PostModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "author == %@", author)
        if ((try? backgroundContext.fetch(fetchRequest) )?.first) != nil {
            return
        } else {
            let newPost = PostModel(context: backgroundContext)
            newPost.author = author
            newPost.likes = likes
            newPost.views = views
            newPost.descr = descr
            newPost.image = image
            newPost.id = id
            saveBackgroundContext()
        }
    }
    
    func deleteAllPosts(){
        
        let fetchRequest = PostModel.fetchRequest()
        for post in (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? [] {
            deletePost(post: post)
        }
        
    }

    func deletePost (post: PostModel) {
        persistentContainer.viewContext.delete(post)
        saveContext()
    }
    
    
    
    func getPosts() -> [PostModel] {
        let request = PostModel.fetchRequest()
        do {
            let answer = try persistentContainer.viewContext.fetch(request)
            return answer
        } catch {
            print(error)
        }
        return []
    }

     func getResults(query : String) -> [PostModel]{
        let request = PostModel.fetchRequest()
        request.predicate = NSPredicate(format: "author LIKE %@", query)
        do {
            let answer = try persistentContainer.viewContext.fetch(request)
            return answer
        } catch {
            print(error)
        }
        return []
    }
}
