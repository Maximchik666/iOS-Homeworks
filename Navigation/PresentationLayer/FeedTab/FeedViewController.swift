//
//  FeedViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.08.2022.
//

import UIKit

var postTitle = "Your New Post"

class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    // MARK: UI Elements Creation
    
    private lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    private lazy var upperButton = CustomButton(backgroundColor: .brown, title: String(localized: "CreateNewPost"))
    private lazy var bottomButton = CustomButton(backgroundColor: .brown, title: String(localized:"ComingSoon"))
    private lazy var checkGuessButton = CustomButton(title:  String(localized: "Guess"))
   
    private lazy var gameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemYellow
        return label
    }()
    
    
    private lazy var closureForStackViewButtons = {
        print()
        self.coordinator?.openPostViewController()
    }
   
    private lazy var closureForCheckGuessButton = {
        var inputWord  = ""
        if  let i = self.gameTextField.text {
            inputWord = i
        }
        var checkResult = true // Убрал функционал
        if checkResult {
            self.checkLabel.backgroundColor = .systemGreen
        } else {
          //  self.checkLabel.backgroundColor = .systemRed
        }
    }
    
    
    // MARK: Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if DEBUG
        view.backgroundColor = UIColor.createColor(lightMode: .systemGray, darkMode: .systemGray2)
#else
        view.backgroundColor = .blue
#endif

        view.addSubview(stackView)
        view.addSubview(gameTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(checkLabel)
        stackView.addArrangedSubview(upperButton)
        stackView.addArrangedSubview(bottomButton)
        addingConstraints()
        upperButton.target = closureForStackViewButtons
        bottomButton.target = closureForStackViewButtons
        checkGuessButton.target = closureForCheckGuessButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navBarCustomization()
        
    }
    
    
    // MARK: Customization and Obj-C Runtime Functions
    
    func navBarCustomization () {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray5)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "VKColor")!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "VKColor")!]
        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = String(localized: "YourFeed")
    }
    
    
    func addingConstraints () {
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            upperButton.heightAnchor.constraint(equalToConstant: 50),
            upperButton.widthAnchor.constraint(equalToConstant: 200),
            
            bottomButton.heightAnchor.constraint(equalToConstant: 50),
            bottomButton.widthAnchor.constraint(equalToConstant: 200),
            
            gameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            gameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            gameTextField.heightAnchor.constraint(equalToConstant: 50),
            gameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            checkGuessButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: gameTextField.bottomAnchor, constant: 20),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 200),
            
            checkLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 20),
            checkLabel.heightAnchor.constraint(equalToConstant: 50),
            checkLabel.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
}
