//
//  InfoViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.08.2022.
//

import UIKit

class InfoViewController: UIViewController {

let alertController = UIAlertController(title: "Hi!", message: "Have a good day!", preferredStyle: .alert)
    
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
           print("alert") }))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
           print("alert") }))
    }
    
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .yellow
        self.view.addSubview(self.button)
    self.button.center = self.view.center
    setupAlertConfiguration()
    }
    

    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor  = .gray
        button.setTitle("Just Click It", for: .normal)
        button.addTarget(self, action: #selector(self.addTarget), for: .touchUpInside)
        return button
    }()
    
    @objc func addTarget() {
        self.present(alertController, animated: true, completion: nil)
        }
    
}

