//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Admin on 23.01.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius = 8.0
    }

    private let usernameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
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
    
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address..."
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
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        
        signUpButton.addTarget(self, action: #selector(signUpDidTapped), for: .touchUpInside)
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self

        
        self.view.backgroundColor = .systemBackground
        
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameTextField.frame = CGRect(
            x: 25,
            y: view.safeAreaInsets.top + 100,
            width: view.width - 50,
            height: 52)
        
        emailTextField.frame = CGRect(
            x: 25,
            y: usernameTextField.bottom + 10,
            width: view.width - 50,
            height: 52)
        
        passwordTextField.frame = CGRect(
            x: 25,
            y: emailTextField.bottom + 10,
            width: view.width - 50,
            height: 52)
        
        signUpButton.frame = CGRect(
            x: 25,
            y: passwordTextField.bottom + 10,
            width: view.width - 50,
            height: 52)
    }
    
    @objc func signUpDidTapped() {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty , password.count >= 8 else {return}
        print("proshek")
        AuthManager.shared.registerUser(username: username, email: email, password: password) { successRegister in
            DispatchQueue.main.async {
                if successRegister {
                    print("ok")
                } else {
                    print("some error")
                }
            }
            
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            signUpDidTapped()
        }
        return true
    }
}
