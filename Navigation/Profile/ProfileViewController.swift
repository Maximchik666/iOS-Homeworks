//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: UI Elements Creation
    
    private let profileHeaderView: UIView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var someButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBrown
        button.setTitle("Only God Knows What For Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadCustomization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarCustomization()
    }
    
    // MARK: Customization and Grouping Functions
    
    func navBarCustomization () {
        // self.navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.brown]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
        navigationController?.navigationBar.tintColor = .brown
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = "Profile"
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            someButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            someButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            someButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            someButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func viewDidLoadCustomization () {
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        view.addSubview(someButton)
        addConstraints()
    }
}
