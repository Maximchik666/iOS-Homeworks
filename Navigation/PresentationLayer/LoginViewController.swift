//
//  LogInViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 30.08.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    var authorizationService = LocalAuthorizationService()
    
    var realmManager = RealmManager.defaultManager
    var userInfo: UserService?
    var loginDelegate: LoginViewControllerDelegate?
    
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
        loginTextField.placeholder = String(localized: "EnterEmail")
        loginTextField.keyboardType = .emailAddress
        loginTextField.clearButtonMode = .whileEditing
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
        passwordTextField.placeholder = String(localized: "EnterPassword")
        passwordTextField.isSecureTextEntry = true
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
    
    private lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var button = CustomButton(title: "Log In")
    private lazy var closure: () throws -> Void = { [self] in
        loginDelegate?.checkCredential(self, login: self.loginTextField.text!, password: self.passwordTextField.text!)
    }
    
    
    private lazy var registrationButton = CustomButton(title: String(localized: "CreateUser"))
    private lazy var closureForGuessButton: () -> Void = { [self] in
        loginDelegate?.signUp(self, login: self.loginTextField.text!, password: self.passwordTextField.text!)
    }
    
    private lazy var faceIdButton = CustomButton(title: "Authorization")
    private lazy var closureForFaceIdButton: () -> Void = { [self] in
        evaluateAutorization()
        authorizationService.authorizeIfPossible { status, error in
            DispatchQueue.main.async {
                if status {
                    self.coordinator?.pushToTabBarController(tapBarController: MainTabBarController())
                } else {
                    self.alert(
                        title: "Error",
                        message: error?.localizedDescription ?? "Face ID/Touch ID may not be configured",
                        okActionTitle: "Ok!")
                    
                }
            }
        }
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray5)
        self.setupGestures()
        navigationController?.navigationBar.isHidden = true
        addingViews()
        addingConstraints()
        button.target = closure
        registrationButton.target = closureForGuessButton
        faceIdButton.target = closureForFaceIdButton
        realmManager.checkCredentials(viewController: self)
    }
    
    func setUserInfo(userInfo: UserService){
        self.userInfo = userInfo
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        evaluateAutorization()
        
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
    
    private func addingViews(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(vkLogo)
        credentialsStackView.addArrangedSubview(loginTextField)
        credentialsStackView.addArrangedSubview(separator)
        credentialsStackView.addArrangedSubview(passwordTextField)
        scrollView.addSubview(credentialsStackView)
        scrollView.addSubview(button)
        scrollView.addSubview(registrationButton)
        scrollView.addSubview(activityIndicator)
        scrollView.addSubview(faceIdButton)
    }
    
    func evaluateAutorization() {
        
        var biometryType = authorizationService.biometryTipeClarification()
        
        if biometryType == .none{
            self.alert(
                title: "Error",
                message: "Face ID/Touch ID may not be configured",
                okActionTitle: "Ok!")
        }
        
        switch biometryType {
        case .faceID: self.faceIdButton.setImage(UIImage(systemName: "faceid"), for: .normal)
        case .touchID: self.faceIdButton.setImage(UIImage(systemName: "touchid"), for: .normal)
        case .none: self.faceIdButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        }
    }
    
    
    func alert(
        title: String,
        message: String,
        okActionTitle: String
    ) {
        let alertView = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: okActionTitle,
            style: .default
        )
        alertView.addAction(okAction)
        present(
            alertView,
            animated: true
        )
    }
    
    func addingConstraints () {
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
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
            button.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 16),
            
            registrationButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            registrationButton.heightAnchor.constraint(equalToConstant: 50),
            registrationButton.centerXAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.centerXAnchor),
            registrationButton.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 16),
            
            activityIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            activityIndicator.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -16),
            
            faceIdButton.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 16),
            faceIdButton.heightAnchor.constraint(equalToConstant: 50),
            faceIdButton.centerXAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.centerXAnchor),
            faceIdButton.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 16),
            
        ])
    }
}

