//
//  InfoViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    weak var coordinator: PostViewCoordinator?
    
    let alertController = UIAlertController(title: "Hi!", message: "Have a good day!", preferredStyle: .alert)
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor  = .brown
        button.layer.cornerRadius = 14
        button.setTitle("Just Click It", for: .normal)
        button.addTarget(self, action: #selector(self.addTarget), for: .touchUpInside)
        return button
    }()
    
    private lazy var jsonLabel: UILabel = {
       let label = UILabel(frame: CGRect(x: 200, y: 200, width: 200, height: 50))
        label.text = "SomeText"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        self.view.addSubview(self.button)
        self.button.center = self.view.center
        setupAlertConfiguration()
    }
    
    @objc func addTarget() {
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            print("alert") }))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("alert") }))
    }
    
}

