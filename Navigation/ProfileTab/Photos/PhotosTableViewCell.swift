//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Maksim Kruglov on 08.09.2022.
//

import UIKit

let smallCollection = [UIImage(named: "IMG-4"), UIImage(named: "IMG-5"), UIImage(named: "IMG-6"), UIImage(named: "IMG-7")]

class PhotosTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 4
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Photos"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.right")
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        
        self.addSubview(label)
        self.addSubview(arrow)
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            
            arrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            arrow.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photo =  collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        photo.setupImage(image: smallCollection[indexPath.item]!)
        return photo
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0

        let width = collectionView.frame.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = floor(width / Constants.numberOfItemsInLine)

        print("🍏 \(itemWidth)")

        return CGSize(width: itemWidth, height: itemWidth)
        
        
    }
    
}
