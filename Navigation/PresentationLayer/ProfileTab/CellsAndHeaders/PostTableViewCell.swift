//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Maksim Kruglov on 05.09.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.text = "1232345"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "IMG-1")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()
        label.text = "350 Likes"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var postViewsLabel: UILabel = {
        let label = UILabel()
        label.text = "350 Likes"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var postText: UILabel = {
        let text = UILabel()
        text.contentMode = .scaleAspectFill
        text.textColor = .black
        text.text = "sgjsfbjdfpbjdfpobjdpobjdo[bdobkdobk"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 14, weight: .regular)
        text.textColor = .systemGray
        text.numberOfLines = 0
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(postLabel)
        addingViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addingViews(){
        self.addSubview(postLabel)
        self.addSubview(postImage)
        self.addSubview(postText)
        self.addSubview(postLikesLabel)
        self.addSubview(postViewsLabel)
    }
    
    func addConstraints () {
        
        NSLayoutConstraint.activate([
            
            postLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            postLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            postImage.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 12),
            postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            postText.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12),
            postText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            postText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            postLikesLabel.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 16),
            postLikesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            postLikesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            postViewsLabel.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 16),
            postViewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            postViewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
            
        ])
        
    }
    
    func setupPost(post: Post) {
        postLabel.text = post.author
        postImage.image = UIImage(named: post.image)
        postText.text = post.description
        postLikesLabel.text = "Likes: \(post.likes)"
        postViewsLabel.text = "Views: \(post.views)"
        
    }
}
