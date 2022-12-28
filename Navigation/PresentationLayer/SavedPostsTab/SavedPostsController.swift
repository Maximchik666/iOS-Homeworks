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
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
}
