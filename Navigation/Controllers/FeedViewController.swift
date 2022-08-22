//
//  FeedViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.08.2022.
//

import UIKit

var postTitle = Post(title: "Your New Post")

class FeedViewController: UIViewController {
    
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor  = .brown
        button.setTitle("Create a New Post", for: .normal)
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        self.view.addSubview(self.button)
        self.button.center = self.view.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navBarCustomization()
        
    }
        
        func navBarCustomization () {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            appearance.titleTextAttributes = [.foregroundColor: UIColor.brown]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
            navigationController?.navigationBar.tintColor = .brown
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.navigationItem.title = "Your Feed"
        }
    
    
    @objc private func didTapButton() {
        let vc = PostViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



