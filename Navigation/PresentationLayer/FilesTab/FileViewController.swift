//
//  TableViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 04.12.2022.
//

import UIKit

class FileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var coordinator: FileTabCoordinator?
    var fileManager: FileManagerServiceProtocol?
    
    var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    var sortFromAToZ = UserDefaults.standard.bool(forKey: "SortPattern") 
    
    var content: [DataForFileTab] {
        if sortFromAToZ {
            let filteredContent = fileManager?.contentsOfDirectory(atPath: path) ?? []
            return filteredContent.sorted { (lhs: DataForFileTab, rhs: DataForFileTab) -> Bool in
                return lhs.name < rhs.name
            }
        } else {
            let filteredContent = fileManager?.contentsOfDirectory(atPath: path) ?? []
            return filteredContent.sorted { (lhs: DataForFileTab, rhs: DataForFileTab) -> Bool in
                return lhs.name > rhs.name
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setConstraints()
        view.backgroundColor = .white
        navBarSetup()
        if #available(iOS 16.0, *) {
            let url1 = URL(filePath: path)
            title = url1.lastPathComponent
        } else {
            
        }
        print(sortFromAToZ)
    }
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func navBarSetup () {
        if #available(iOS 16.0, *) {
            
            let createFolderButton = UIBarButtonItem(title: String(localized:"Create Folder"), image: UIImage(systemName: "folder.fill.badge.plus"), target: self, action: #selector(createFolder))
            let addPhotoButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhoto))
            let changePasswordButton = UIBarButtonItem(title: String(localized: "Change Password"), image: UIImage(systemName: "lock"), target: self, action: #selector(changePassword))
            let sortItemsButton = UIBarButtonItem(title: String(localized: "Sort Items"), image: UIImage(systemName: "arrow.up.and.down.text.horizontal"), target: self, action: #selector(sortItems))
            
            let group = UIBarButtonItemGroup(barButtonItems: [createFolderButton, addPhotoButton,changePasswordButton,sortItemsButton], representativeItem: nil)
            
            navigationItem.centerItemGroups = [group]
            
        } else {
            print("Device Is Old")
            return
        }
    }
    
    @objc func createFolder() {
        InputHandler.shared.alertWithText(in: self) { text in
            self.fileManager?.createDirectory(atPath: self.path, folderName: text)
            self.tableView.reloadData()
        }
    }
    
    @objc func addPhoto() {
        InputHandler.shared.addImage(in: self)
        self.tableView.reloadData()
    }
    
    @objc func changePassword() {
        let vc = FileLoginViewController()
        vc.modalAppearance = true
        vc.temporaryPassword = ""
        navigationController?.present(vc, animated: true)
    }
    
    @objc func sortItems() {
        sortFromAToZ = !sortFromAToZ
        UserDefaults.standard.set(sortFromAToZ, forKey: "SortPattern")
        tableView.reloadData()
    }
}

extension FileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return content.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = content[indexPath.row].name
        if content[indexPath.row].type == .folder {
            cell.accessoryType = .disclosureIndicator
            print("Folder: \(content[indexPath.row].name)")
        } else {
            cell.accessoryType = .checkmark
            print("File: \(content[indexPath.row].name)")
            
        }
        
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let urlOfPhoto = info[.imageURL] as? URL {
            fileManager?.createFile(fromUrl: urlOfPhoto, atPath: self.path, fileName: urlOfPhoto.lastPathComponent)
            picker.dismiss(animated: true)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if content[indexPath.row].type == .folder {
            let vc = FileViewController()
            vc.fileManager = FileManagerService()
            vc.path = path + "/" + content[indexPath.row].name
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fullPath = path + "/" + content[indexPath.row].name
            try? FileManager.default.removeItem(atPath: fullPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }
    }
}
