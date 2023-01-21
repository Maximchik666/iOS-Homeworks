//
//  AlertController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 05.12.2022.
//

import Foundation
import UIKit

class InputHandler {
    
    static let shared = InputHandler()
    
    
    func alertWithText(in vc: UIViewController,  completion: @escaping (_: String) -> ()){
        let alertController = UIAlertController(title: "Create a Folder", message: "Please Enter Folder's name", preferredStyle: .alert)
        alertController.addTextField()
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default){ _ in
            if let text = alertController.textFields?[0].text, text != "" {
                completion(text)
            }
        }
        alertController.addAction(okAction)
        vc.present(alertController, animated: true)
    }
    
    func addImage (in vc: UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        
        let picker = UIImagePickerController()
        picker.delegate = vc
        picker.allowsEditing = true
        vc.present(picker, animated: true)
        
    }
    
}
