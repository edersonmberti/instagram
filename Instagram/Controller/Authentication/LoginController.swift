//
//  LoginController.swift
//  Instagram
//
//  Created by Ederson Machado Berti on 03/08/21.
//

import UIKit

protocol AuthenticationDelegate: AnyObject {
    func authenticationDidComplete()
}

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationDelegate?
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emailTextField: CustomTaxtField = {
        let textField = CustomTaxtField(placeholder: "E-mail")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: CustomTaxtField = {
        let textField = CustomTaxtField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: CustomButton = {
        let button = CustomButton(placeholder: "Log In")
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in")
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sing Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        
        updateForm()
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text?.lowercased() else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to log user in \(error.localizedDescription)")
                return
            }
            
            self.delegate?.authenticationDidComplete()
        }
    }
    
    // MARK: - Helpers
    
    func setupLayout() {
        view.backgroundColor = .white
        
        setupNavigationBar()
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    func setupNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - FormViewModel

extension LoginController: FormViewModel {
    
    func updateForm() {
        loginButton.isEnabled = viewModel.formIsValid
        loginButton.backgroundColor =  viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
}
