//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Maksim Kruglov on 05.09.2022.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private var statusText: String = ""
    
    // MARK: UI Elements Creation
    
    private lazy var statusButton: UIButton = {
        
        let button = UIButton()
        button.layer.cornerRadius = 14
        button.setTitle("Show Status", for: .normal)
        button.backgroundColor = UIColor(named: "VKColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.cornerRadius = 4
        button.layer.shadowColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.7
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for Something"
        label.textColor = .gray
        label.font = UIFont(name: "HelveticaNeue-Regular", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "IMG")
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var textField : TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Enter text here"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "HelveticaNeue", size: 15.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return textField
    }()
    
    // MARK: Initializators
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addingSubviews()
        addingConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Obj-C Runtime Functions
    
    @objc func statusTextChanged(_ textField: TextFieldWithPadding){
        if let i = textField.text {
            statusText = i
        }
        
    }
    
    @objc private func didTapButton() {
        if statusText != "" {
            statusLabel.text = statusText
        } else {statusLabel.text  = "Put Some Words In It First!"}
    }
    
    // MARK: Addind Subwiews function
    
    func addingSubviews () {
        addSubview(statusButton)
        addSubview(nameLabel)
        addSubview(profileImage)
        addSubview(statusLabel)
        addSubview(textField)

    }
    
    // MARK: Setting Up The Constraints
    
    func addingConstraints () {
        NSLayoutConstraint.activate([
            
            statusButton.topAnchor.constraint(equalTo:self.profileImage.bottomAnchor, constant: 32),
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            nameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            
            statusLabel.bottomAnchor.constraint(equalTo: self.statusButton.topAnchor, constant: -55),
            statusLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 34),
            statusLabel.leadingAnchor.constraint(equalTo: self.profileImage.trailingAnchor, constant: 34),
            
            profileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.widthAnchor.constraint(equalToConstant: 220),
            textField.leadingAnchor.constraint(equalTo: self.profileImage.trailingAnchor, constant: 34),
            textField.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 4)
            
        ])
    }
}
