//
//  FileLoginController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 10.12.2022.
//

import Foundation
import UIKit
import KeychainSwift

class FileLoginViewController: UIViewController {
    
    weak var coordinator: FileTabCoordinator?
    var temporaryPassword = KeychainSwift().get("Password") ?? ""
    var modalAppearance = false
    
    private lazy var passwordTextField: TextFieldWithPadding = {
        
        let passwordTextField = TextFieldWithPadding()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "CreatePassword"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.layer.borderWidth = 3
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = UIColor.systemGray.cgColor
        return passwordTextField
    }()
    
    
    private lazy var button = CustomButton(title: "Ok")
    private lazy var closure: () throws -> Void = {
        
        
        if self.passwordTextField.text != "", (self.passwordTextField.text?.count)! >= 4 {
            if self.temporaryPassword == "" {
                self.temporaryPassword = (self.passwordTextField.text)!
                self.passwordTextField.text = ""
                self.passwordTextField.placeholder = "Re-Enter Password"
            } else {
                if self.temporaryPassword == (self.passwordTextField.text)! {
                    KeychainSwift().set(self.temporaryPassword, forKey: "Password")
                    self.passwordTextField.text = ""
                    self.passwordTextField.placeholder = "Enter Password"
                    
                    if self.modalAppearance == false {
                        self.coordinator?.pushToFilesTab(filesViewController: FileViewController())
                    } else {
                        self.dismiss(animated: true)
                    }
                } else {
                    let alertController = UIAlertController(title: "Sorry!", message: "Passwords did not Match", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok! Let me Try Again", style: .default, handler: { _ in
                        self.temporaryPassword = KeychainSwift().get("Password") ?? ""
                        self.passwordTextField.text = ""
                        self.passwordTextField.placeholder = "Enter Password"
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            let alertController = UIAlertController(title: "Sorry!", message: "Password is Empty, Or Shorter Then 4 Symbols", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok! Let me Try Again", style: .default, handler: { _ in
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(passwordTextField)
        view.addSubview(button)
        addingConstraints()
        button.target = closure
        print("Temporary Password: \(temporaryPassword)")
        
        if temporaryPassword != "" {
            passwordTextField.placeholder = "Enter The Password"
        }
    }
    
    func addingConstraints() {
        
        NSLayoutConstraint.activate([
            
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
}
