//
//  SignInViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

protocol SignInViewControllerNavigationDelegate: AnyObject {
    func signedIn()
    func goToSignUp()
}

final class SignInViewController: UIViewController, CanShowKeyboard {

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
        configureObservers()
        configurePrimaryButton()
        configureTextFields()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeObservers()
    }

    // MARK: - IBOutlet

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var primaryButton: PrimaryButton!
    @IBOutlet internal weak var buttonsBottomConstraint: NSLayoutConstraint!

    // MARK: - IBAction
    @IBAction private func tapNavigateToSignUpButton(_ sender: Any) {
        navigationDelegate?.goToSignUp()
    }

    @objc func tapOutside(gesture: UITapGestureRecognizer) {
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
        passwordTextField.tintColor = .black
        passwordTextField.tintColorDidChange()
    }

    private func configureTapOutside() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside(gesture:)))
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
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return }
        authService.signIn(
            email: email,
            password: password,
            completion: { [weak self] result in
                switch result {
                case .success:
                    self?.navigationDelegate?.signedIn()
                case.failure(let error):
                    self?.showError(error.localizedDescription)
                }
            })
    }

}
