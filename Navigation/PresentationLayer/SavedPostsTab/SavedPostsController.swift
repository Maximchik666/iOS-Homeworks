//
//  SavedPostsController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 20.12.2022.
//

import UIKit
import CoreData

class SavedPostsController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var coordinator: SavedPostsTabCoordinator?
    var searchedPosts: [PostModel]?
    
    let fetchResultController: NSFetchedResultsController = {
        let fetchRequest  = PostModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clear))
        
        
        navigationItem.rightBarButtonItems = [delete, search]
       
        fetchResultController.delegate = self
        try? fetchResultController.performFetch()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete: tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move: tableView.reloadData()
        case .update: tableView.reloadRows(at: [indexPath!], with: .automatic)
        @unknown default:
            print("Error")
        }
    }
    
    
    @objc func search() {
        
        showAlertWithTextField(title: "query:", actionHandler:  { text in
            if let result = text {
                self.searchedPosts = CoreDataManager.defaultManager.getResults(query: result)
                self.navigationItem.rightBarButtonItems?.remove(at: 1)
                self.tableView.reloadData()
            }
        })
    }
    
    @objc func clear() {
        
        if searchedPosts == nil {
            CoreDataManager.defaultManager.deleteAllPosts()
            self.tableView.reloadData()
        } else {
            searchedPosts = nil
            let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
            self.navigationItem.rightBarButtonItems?.append(search)
            self.tableView.reloadData()
        }
    }
    
    func showAlertWithTextField(title:String? = nil,
                                subtitle:String? = nil,
                                actionTitle:String? = "Search",
                                cancelTitle:String? = "Cancel",
                                inputPlaceholder:String? = nil,
                                inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                                cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                                actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchedPosts == nil {
            return fetchResultController.sections?[section].numberOfObjects ?? 0
        } else {
            return searchedPosts!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
        if searchedPosts == nil {
            let post = fetchResultController.object(at: indexPath)
            cell.setupPostFromCoreData(post: post)
            return cell
        } else {
            let post = searchedPosts![indexPath.row]
            cell.setupPostFromCoreData(post: post)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath)
        ])
    }
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            if self.searchedPosts == nil {
                let post = self.fetchResultController.object(at: indexPath)
                CoreDataManager.defaultManager.deletePost(post: post)
            } else {
                self.searchedPosts?.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            completion(true)
        }
    }
    
}
