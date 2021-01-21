//
//  LoginViewController.swift
//  assessment-ios
//
//  Created by Vignesh on 22/01/21.
//  Copyright © 2021 Vignesh. All rights reserved.
//

import UIKit
import XMPPFramework

class LoginViewController: UIViewController {

    // MARK: - Properties
    private var jidTextField = UITextField()
    private var passwordTextField = UITextField()
    private weak var loginButton: UIButton!
    var xmppController: XMPPController!
    private var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle
    
    // Custom initializers go here

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - User Interactions
    
    @objc
    func  loginButtonAction(sender: UIButton) {
        self.view.endEditing(true)
        
        guard let jid = jidTextField.text, let password = passwordTextField.text, !jid.isEmpty || !password.isEmpty else {
            self.showAlert(title: "XMPP", message: "Credentials missing, Please fill the fields")
            return
        }
        
        self.activityIndicator.startAnimating()
        do {
            try self.xmppController = XMPPController(userJIDString: jid,
                                                     password: password)
            self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
            self.xmppController.connect()
            
        } catch {
            self.activityIndicator.stopAnimating()
            showAlert(title: "XMPP", message: "Something went wrong")
        }
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
    private func showAlert(title: String, message: String, isUserConneted: Bool = false) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler:  { _ in
                                        
                                        if isUserConneted {
                                            /*let weatherViewController = WeatherListViewController()
                                            self.navigationController?.pushViewController(weatherViewController, animated: true)*/
                                        }
          
        }))
        self.present(alert, animated: true)
    }
    
    // MARK: - UI and Constraints methods

    private func setupViews() {
        view.backgroundColor = .white
        
        let jidTextField = UITextField()
        jidTextField.translatesAutoresizingMaskIntoConstraints = false
        jidTextField.placeholder = "Enter your JID"
        jidTextField.delegate = self
        jidTextField.textColor = .black
        jidTextField.textAlignment = .center
        jidTextField.autocapitalizationType = UITextAutocapitalizationType.none
        jidTextField.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        jidTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        jidTextField.leftViewMode = .always
        jidTextField.layer.cornerRadius = 15.0
        jidTextField.layer.borderWidth = 1.0
        jidTextField.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.5)
        
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.delegate = self
        passwordTextField.textColor = .black
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.cornerRadius = 15.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.5)
        
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor.black
        loginButton.layer.cornerRadius = 15.0
        loginButton.addTarget(self, action: #selector(loginButtonAction(sender:)), for: .touchUpInside)
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = .gray
        
        self.view.addSubview(jidTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(activityIndicator)

        self.jidTextField = jidTextField
        self.passwordTextField = passwordTextField
        self.loginButton = loginButton
        self.activityIndicator = activityIndicator

        setupConstraints()
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            jidTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            jidTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jidTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            jidTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            jidTextField.heightAnchor.constraint(equalToConstant: 50),
                        
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension LoginViewController: XMPPStreamDelegate {

    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("XMPP => Success \(sender.hostName ?? "")")
        self.activityIndicator.stopAnimating()
        self.showAlert(title: "XMPP", message: "User Authenticated and Connected with \(sender.hostName ?? "HOST")")
    }
    
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        self.showAlert(title: "XMPP", message: "Wrong JID or Password")
    }
}
