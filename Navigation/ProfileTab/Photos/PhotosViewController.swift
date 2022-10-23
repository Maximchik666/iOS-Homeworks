//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 08.09.2022.
//

import UIKit
import iOSIntPackage

let bigCollection = ["IMG-4", "IMG-5", "IMG-6", "IMG-7", "IMG-8", "IMG-9", "IMG-10", "IMG-11", "IMG-12", "IMG-13", "IMG-14", "IMG-15","IMG-16", "IMG-17", "IMG-18", "IMG-19", "IMG-20", "IMG-21", "IMG-22", "IMG-23", "IMG-24", "IMG-25", "IMG-26", "IMG-27"]

private enum Constants {
    
    static let numberOfItemsInLine: CGFloat = 3
}

class PhotosViewController: UIViewController {
    
    
    var imagePublisher = ImagePublisherFacade()
    var imagesBank = [UIImage]()
    var itemInSection = 0
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDidLoad()
        
        imagePublisher.subscribe(self)
        imagePublisher.addImagesWithTimer(time: 1, repeat: 20)
        
    }
    
    override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            if parent == nil {
                imagePublisher.removeSubscription(for: self)
                imagePublisher.rechargeImageLibrary()
            }
        }
    
    func setupViewDidLoad (){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        itemInSection
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photo =  collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        photo.setupImage(image: imagesBank[indexPath.item])
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

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        imagesBank = images
        itemInSection = imagesBank.count
        collectionView.reloadData()
    }

}
