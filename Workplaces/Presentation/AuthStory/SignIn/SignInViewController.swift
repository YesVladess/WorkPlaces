//
//  SignInViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

protocol SignInViewControllerNavigationDelegate: AnyObject {
    func signInPassed(refreshToken: String)
    func needSignUpButtonTapped()
}

final class SignInViewController: KeyboardViewController {

    // MARK: - Public Properties

    weak var navigationDelegate: SignInViewControllerNavigationDelegate?

    // MARK: - Private Properties

    private let authService: AutorizationServiceProtocol

    // MARK: - Initializers

    init(
        authService: AutorizationServiceProtocol = ServiceLayer.shared.authorizationService
    ) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        congifure()
        configureTapOutside()
        configurePrimaryButton()
        configureTextFields()
    }

    // MARK: - IBOutlet

    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var primaryButton: PrimaryButton!
    @IBOutlet private var buttonsBottomConstraint: NSLayoutConstraint!

    override func updateKeyboardConstraints() {
        buttonsBottomConstraint.constant = buttonsBottomConstraintConstant
    }

    // MARK: - IBAction
    @IBAction private func secondaryButtonTapped(_ sender: Any) {
        navigationDelegate?.needSignUpButtonTapped()
    }

    @objc func tapOutside() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    @IBAction private func textfieldDidChange(_ sender: UITextField) {
        validatePrimaryButton()
    }

    // MARK: - Private Methods

    private func congifure() {
        title = "Вход по логину"
    }

    private func configureTextFields() {
        emailTextField.tintColor = .black
        emailTextField.tintColorDidChange()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tintColor = .black
        passwordTextField.tintColorDidChange()
    }

    private func configureTapOutside() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside))
        view.addGestureRecognizer(tapGesture)
    }

    private func configurePrimaryButton() {
        primaryButton.setTitle("Sign in".localized)
        primaryButton.onTap = { [weak self] in
            self?.signIn()
        }
        primaryButton.isEnabled = false
    }

    private func validatePrimaryButton() {
        if let emailText = emailTextField.text,
           !emailText.isEmpty,
           let passText = passwordTextField.text,
           !passText.isEmpty {
            primaryButton.isEnabled = true
        } else {
            primaryButton.isEnabled = false
        }
    }

    private func signIn() {
        showSpinner()
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return }
        authService.signIn(
            email: email,
            password: password,
            completion: { [weak self] result in
                switch result {
                case .success(let refreshToken):
                    self?.hideSpinner()
                    self?.tapOutside() 
                    self?.navigationDelegate?.signInPassed(refreshToken: refreshToken)
                case.failure(let error):
                    self?.hideSpinner()
                    self?.showError(error.localizedDescription)
                }
            })
    }

}
