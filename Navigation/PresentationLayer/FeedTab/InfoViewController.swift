//
//  InfoViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    weak var coordinator: PostViewCoordinator?
    
    let alertController = UIAlertController(title: "Hi!", message: "Have a good day!", preferredStyle: .alert)
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor  = .brown
        button.layer.cornerRadius = 14
        button.setTitle("Just Click It", for: .normal)
        button.addTarget(self, action: #selector(self.addTarget), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var jsonLabelForCase1: UILabel = {
       let label = UILabel()
        label.text = titleForCase1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var jsonLabelForCase2: UILabel = {
       let label = UILabel()
        label.text = "Orbital Period is \(titleForCase2)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetup()
        setupAlertConfiguration()
        addingConstraints()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//        
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                self.tableView.reloadData()
//            }
//        }
//    
    
    @objc func addTarget() {
        self.present(alertController, animated: true, completion: nil)
    }
    
    func screenSetup() {
        view.backgroundColor = .systemYellow
        view.addSubview(button)
        view.addSubview(jsonLabelForCase1)
        view.addSubview(jsonLabelForCase2)
        view.addSubview(tableView)
    }
    
    func addingConstraints() {
        NSLayoutConstraint.activate([
        
            button.topAnchor.constraint(equalTo: jsonLabelForCase1.bottomAnchor, constant: 10),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            jsonLabelForCase1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            jsonLabelForCase1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            jsonLabelForCase1.widthAnchor.constraint(equalToConstant: 200),
            jsonLabelForCase1.heightAnchor.constraint(equalToConstant: 50),
            
            
            jsonLabelForCase2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            jsonLabelForCase2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            jsonLabelForCase2.widthAnchor.constraint(equalToConstant: 200),
            jsonLabelForCase2.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
    
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            print("alert") }))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("alert") }))
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residents.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
        cell.textLabel?.text = "Loading... Please Be patient!"
        
        let URLSession = URLSession.shared
        if  let url = URL(string: residents[indexPath.row]) {
            let request = URLRequest(url: url)

            let dataTask1 = URLSession.dataTask(with: request, completionHandler: {data, responce, error in
                if let unwrapedData = data {
                    do {
                        let currentResident = try JSONDecoder().decode(TatooineResident.self, from: unwrapedData)
                        DispatchQueue.main.sync {cell.textLabel?.text = currentResident.name}
                        print(currentResident.name)
                    } catch {print(error)}
                }
        })
            dataTask1.resume()
    }
        
        return cell
    }
}
