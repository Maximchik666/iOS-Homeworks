//
//  SavedPostsController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 20.12.2022.
//

import UIKit

class SavedPostsController: UITableViewController {
    
    var coordinator: SavedPostsTabCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.reloadData()
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        let clear = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clear))
        navigationItem.rightBarButtonItems = [clear, search]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    @objc func search() {
        
        showAlertWithTextField(title: "query:", actionHandler:  { text in
            if let result = text {
                CoreDataManager.defaultManager.getResults(query: result)
                self.tableView.reloadData()
            }
        })
    }
    
    @objc func clear() {
        CoreDataManager.defaultManager.getPosts()
        tableView.reloadData()
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
        
        return CoreDataManager.defaultManager.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
        cell.setupPostFromCoreData(post: CoreDataManager.defaultManager.posts[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath)
        ])
    }

    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            CoreDataManager.defaultManager.deleteFromFavorite(index: indexPath.row)
            CoreDataManager.defaultManager.getPosts()
            self.tableView.reloadData()
            completion(true)
        }
    }
    
}
