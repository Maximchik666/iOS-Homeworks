//
//  PlayerButton.swift
//  Navigation
//
//  Created by Maksim Kruglov on 22.11.2022.
//

import Foundation
import UIKit

class PlayerButton: UIButton {
    
    var action: ()-> Void = {}
    
    init(tintColor: UIColor = UIColor(named: "VKColor")!, image: UIImage) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = tintColor
        self.layer.borderColor =  UIColor(named: "VKColor")!.cgColor
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.setImage(image, for: .normal)
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton() {action()}
}
