//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Maksim Kruglov on 05.09.2022.
//

import UIKit
import SnapKit

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
    
    var isImageViewIncreased = false
    
    // MARK: Initializators
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addingSubviews()
        addingConstraints()
        addGesture()
        addObserver()
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
    
    // Changing Text with Button
    @objc private func didTapButton() {
        if statusText != "" {
            statusLabel.text = statusText
        } else {statusLabel.text  = "Put Some Words In It First!"}
    }
    
    // MARK: Addind Subviews function
    
    func addingSubviews () {
        addSubview(statusButton)
        addSubview(nameLabel)
        addSubview(profileImage)
        addSubview(statusLabel)
        addSubview(textField)
        
    }
    
    
    // MARK: Setting Up The Constraints
    
    func addingConstraints () {
        
        //SnapKit Constraints Realization
        
        profileImage.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(100)
            make.top.equalTo(self.snp.top).offset(16)
            make.left.equalTo(self.snp.left).offset(16)
        }
        
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(27)
            make.left.equalTo(self.snp.left).offset(140)
        }
        
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(54)
            make.left.equalTo(self.snp.left).offset(140)
        }
        
        textField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(80)
            make.left.equalTo(self.snp.left).offset(140)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(40)
        }
        
        statusButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.top.equalTo(self.snp.top).offset(132)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(50)
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
