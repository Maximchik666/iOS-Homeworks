//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationController?.navigationBar.isHidden = true
        
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
               
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
            cell.setupPost(post: viewModel[indexPath.row])
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return ProfileTableHeaderView()
        } else {
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.section == 0 {
                navigationController?.pushViewController(PhotosViewController(), animated: true)
            }
        }
    
    
    
    
    
}
