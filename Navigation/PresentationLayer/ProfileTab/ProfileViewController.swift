//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.08.2022.
//

import UIKit
import StorageService
import iOSIntPackage

class ProfileViewController: UIViewController {
    
    var user: User?
    weak var coordinator: ProfileTabCoordinator?
    
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
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var secondProfileImage: UIImageView = {
        let image = UIImageView()
        image.image = self.user?.avatar
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.isHidden = true
        return image
    }()
    
    private lazy var cross: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "xmark")
        image.isHidden = true
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled  = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        addingSubViewsAndConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
        addGesture()
    }
    
    private func addingSubViewsAndConstraints () {
        view.addSubview(tableView)
        view.addSubview(iconView)
        view.addSubview(secondProfileImage)
        view.addSubview(cross)
        
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            self.iconView.topAnchor.constraint(equalTo: view.topAnchor),
            self.iconView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.iconView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.iconView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            self.secondProfileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.secondProfileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.secondProfileImage.heightAnchor.constraint(equalToConstant: 100),
            self.secondProfileImage.widthAnchor.constraint(equalToConstant: 100),
            
            cross.heightAnchor.constraint(equalToConstant: 30),
            cross.widthAnchor.constraint(equalToConstant: 30),
            cross.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            cross.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
            
        ])
    }
 
    // Observer for tapping on Small Profile Image
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(profileImageAnimation (_:)),
                                               name: Notification.Name("ProfileClick"),
                                               object: nil)
    }
    
    
    // Adding Gesture Recogniser for cross above Big Profile Image
    private func addGesture(){
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(profileImageReverseAnimation(_: )))
        self.cross.addGestureRecognizer(tapGestureRecogniser)
    }
    
    
    @objc private func profileImageAnimation (_ notification: Notification) {
        
        let scaleCoef = (self.iconView.frame.width - 32) / self.secondProfileImage.frame.width
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut){
            self.iconView.alpha = 0.5
            self.secondProfileImage.isHidden = false
            self.secondProfileImage.center = self.iconView.center
            self.secondProfileImage.transform = CGAffineTransform(scaleX: scaleCoef, y: scaleCoef)
            self.secondProfileImage.layer.cornerRadius = 0
        } completion: { _ in
            self.cross.isHidden = false
        }
    }
    
    @objc private func profileImageReverseAnimation (_ gestureRecognizer: UITapGestureRecognizer ){
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseInOut){
            self.iconView.alpha = 0
            self.cross.isHidden = true
            self.secondProfileImage.isHidden = true
            self.secondProfileImage.center = CGPoint(x: 66, y: 86)
            self.secondProfileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.secondProfileImage.layer.cornerRadius = 50
        } completion: { _ in
            NotificationCenter.default.post(name: Notification.Name("bigProfileImage is Hidden"), object: nil)
        }
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
            let profileView = ProfileTableHeaderView()
            profileView.profileImage.image = user?.avatar
            profileView.statusLabel.text = user?.status
            profileView.nameLabel.text = user?.fullName
            return profileView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            self.coordinator?.openPhotosViewController()
        }
    }
}

