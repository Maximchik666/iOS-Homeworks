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

class CustomButton: UIButton {
    
    var target: () throws -> Void = { }
    
    init(backgroundColor: UIColor = UIColor(named: "VKColor")!, title: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        self.setTitle(title, for: .normal)
        self.tintColor = .white
        self.backgroundColor = backgroundColor
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton() throws {try target()}
}


class TextFieldWithPadding: UITextField {
   
    var textPadding = UIEdgeInsets(
        top: 0,
        left: 10,
        bottom: 0,
        right: 10
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
