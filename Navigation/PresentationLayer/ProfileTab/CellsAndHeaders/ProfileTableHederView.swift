//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Maksim Kruglov on 05.09.2022.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private var statusText: String = ""
    
    private let counts = 7
    private var count = 0
    
    // MARK: UI Elements Creation
    
    private lazy var statusButton = CustomButton(title: String(localized: "ShowStatus"))
    private lazy var closure: () -> Void = {
        
        self.changeStatus(newStatus: self.textField.text ?? "") { result in
            switch result {
            case .success(let status):
                self.statusLabel.text = status
                
            case .failure:
                self.statusLabel.text  = String(localized: "PutSomeWordsInItFirst")
            }
        }
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for Something"
        label.textColor = .gray
        label.font = UIFont(name: "HelveticaNeue-Regular", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "IMG")
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var textField : TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = String(localized: "EnterTextHere")
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "HelveticaNeue", size: 15.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return textField
    }()
    
    var isImageViewIncreased = false
    
    // MARK: Initializators
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addingSubviews()
        addingConstraints()
        addGesture()
        addObserver()
        changeStatusButtonColour()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    // MARK: Obj-C Runtime Functions
    
    
    // Saving text from textField to the Container statusText
    @objc func statusTextChanged(_ textField: TextFieldWithPadding){
        if let i = textField.text {
            statusText = i
        }
    }
    
    // MARK: Addind Subviews function
    
    func addingSubviews () {
        addSubview(statusButton)
        addSubview(nameLabel)
        addSubview(profileImage)
        addSubview(statusLabel)
        addSubview(textField)
        statusButton.target = closure
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
    
    func changeStatus(newStatus status : String, complition: @escaping (Result<String, AppErrors>)-> Void ) {
        
        if status == "" {
            complition(.failure(.statusNotEntered))
        } else {
            complition(.success(status))
        }
    }
    
    private func changeStatusButtonColour () {
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            
            if self.count % 2 == 0 {
                self.statusButton.backgroundColor = .systemGreen
            } else {
                self.statusButton.backgroundColor = UIColor(named: "VKColor")!
            }
            
            if self.count == self.counts {
                timer.invalidate()
            }
            
            self.count += 1
        }
    }
    
    // Recogniser for tap on a Profile Image
    private func addGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideProfileImageAndSendNotification(_:)))
        self.profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Observer for taping on closing Icon, above big Profile Image
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(returnProfileImage(_ : )),
                                               name: Notification.Name("bigProfileImage is Hidden"),
                                               object: nil)
    }
    
    
    @objc private func hideProfileImageAndSendNotification(_ gestureRecognizer: UITapGestureRecognizer) {
        
        NotificationCenter.default.post(name: Notification.Name("ProfileClick"), object: nil)
        profileImage.isHidden = true
    }
    
    
    @objc private func returnProfileImage (_ gestureRecognizer: UITapGestureRecognizer) {
        profileImage.isHidden = false
    }
    
    
}
