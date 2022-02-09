//
//  LoginViewController.swift
//  Instagram
//
//  Created by Admin on 23.01.2022.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius = 8.0
    }

    private let usernameEmailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or email..."
        field.layer.masksToBounds = true
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = Constants.cornerRadius
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.layer.masksToBounds = true
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = Constants.cornerRadius
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms Of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccount: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an account!", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "inst")
        header.addSubview(backgroundView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccount.addTarget(self,
                              action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self,
                              action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        self.view.backgroundColor = .systemBackground
        usernameEmailTextField.delegate = self
        passwordTextField.delegate = self
        addSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: view.height / 3)
        
        usernameEmailTextField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: 52)
        
        passwordTextField.frame = CGRect(
            x: 25,
            y: usernameEmailTextField.bottom + 10,
            width: view.width - 50,
            height: 52)
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordTextField.bottom + 10,
            width: view.width - 50,
            height: 52)
        
        createAccount.frame = CGRect(
            x: 25,
            y: loginButton.bottom,
            width: view.width - 50,
            height: 52)
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height-view.safeAreaInsets.top-100,
            width: view.width - 20,
            height: 50)
        
        privacyButton.frame = CGRect(
            x: 10,
            y: termsButton.bottom,
            width: view.width - 20,
            height: 50)
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {return}
        
        guard let backgroundView = headerView.subviews.first else {return}
        backgroundView.frame = headerView.bounds
        
        let logoView = UIImageView()
        headerView.addSubview(logoView)
        logoView.image = UIImage(named: "instlogo")
        logoView.contentMode = .scaleAspectFit
        logoView.frame = CGRect(x: headerView.frame.width / 4,
                                y: view.safeAreaInsets.top,
                                width: headerView.frame.width / 2,
                                height: headerView.frame.height - view.safeAreaInsets.top)
        
    }

    
    private func addSubviews() {
        view.addSubview(usernameEmailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccount)
    }
    
    @objc func didTapLoginButton() {
        
        usernameEmailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let usernameOrEmail = usernameEmailTextField.text, !usernameOrEmail.isEmpty, let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {return}
        
        var username: String?
        var email: String?
        
        if usernameOrEmail.contains("@"), usernameOrEmail.contains(".") {
            email = usernameOrEmail
        } else {
            username = usernameOrEmail
        }
        
        AuthManager.shared.loginUser(username: username,
                                     email: email,
                                     password: password) { succes in
            DispatchQueue.main.async {
                if succes {
                    self.dismiss(animated: true)
                } else {
                    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in!", preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true)
                }
            }
        }
        // login functionality
    }
    
    @objc func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875/?maybe_redirect_pol=0") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapLoginButton()
        }
        return true
    }
    
}
