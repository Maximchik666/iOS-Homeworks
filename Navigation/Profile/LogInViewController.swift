//
//  LogInViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 30.08.2022.
//


import UIKit

class LoginViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var vkLogo: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "VKImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var loginTextField: TextFieldWithPadding = {
        
        let loginTextField = TextFieldWithPadding()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Email or Phone Number"
        loginTextField.clearButtonMode = .whileEditing
        //    loginTextField.delegate = self
        return loginTextField
    }()
    
    private lazy var separator: UIView = {
        
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    private lazy var passwordTextField: TextFieldWithPadding = {
        
        let passwordTextField = TextFieldWithPadding()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.isSecureTextEntry = true
        //    passwordTextField.delegate = self
        passwordTextField.clearButtonMode = .whileEditing
        return passwordTextField
    }()
    
    private lazy var credentialsStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.backgroundColor = .systemGray6
        return stackView
    }()
    
    private lazy var button: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = UIColor(named: "VKColor")
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupGestures()
        navigationController?.navigationBar.isHidden = true
        addinsViews()
        addingConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    
    private func setupGestures() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func didShowKeyboard(_ notification: Notification) {
        
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = self.button.frame.origin.y + button.frame.height
            
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 32
            : 0
            
            print("🍋 \(loginButtonBottomPointY), \(keyboardOriginY)")
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    @objc func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    @objc private func didTapButton() {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func addinsViews(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(vkLogo)
        credentialsStackView.addArrangedSubview(loginTextField)
        credentialsStackView.addArrangedSubview(separator)
        credentialsStackView.addArrangedSubview(passwordTextField)
        scrollView.addSubview(credentialsStackView)
        scrollView.addSubview(button)
    }
    
    
    func addingConstraints () {
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            vkLogo.centerXAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.centerXAnchor),
            vkLogo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),
            
            credentialsStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120),
            credentialsStackView.centerXAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.centerXAnchor),
            credentialsStackView.leadingAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.centerXAnchor),
            button.topAnchor.constraint(equalTo: credentialsStackView.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 16)
        ])
    }
}
