//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Maksim Kruglov on 17.08.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
    private lazy var statusButton: UIButton = {
        
        let button = UIButton()
        button.layer.cornerRadius = 14
        button.setTitle("Show Status", for: .normal)
        button.backgroundColor = .brown
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
        let image = UIImageView(frame: CGRect(x: 16, y: 16, width: 100, height: 100))
        image.image = UIImage(named: "IMG")
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    private lazy var textField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 150, y: 96, width: 220, height: 40))
        textField.placeholder = "  Enter text here"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "HelveticaNeue", size: 15.0)
        
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addingConstraints()
        addingSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func statusTextChanged(_ textField: UITextField){
        if let i = textField.text {
            statusText = i
        }
        
    }
    
    @objc private func didTapButton() {
        if statusText != "" {
            statusLabel.text = statusText
        } else {statusLabel.text  = "Put Some Words In It First!"}
    }
    
    func addingSubviews () {
        addSubview(statusButton)
        addSubview(nameLabel)
        addSubview(profileImage)
        addSubview(statusLabel)
        addSubview(textField)
    }
    
    func addingConstraints () {
        NSLayoutConstraint.activate([
            
            statusButton.topAnchor.constraint(equalTo:self.profileImage.bottomAnchor, constant: 32),
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            nameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            
            statusLabel.bottomAnchor.constraint(equalTo: self.statusButton.topAnchor, constant: -55),
            statusLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 34),
            statusLabel.leadingAnchor.constraint(equalTo: self.profileImage.trailingAnchor, constant: 34)
            
        ])
    }
}



