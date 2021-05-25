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

final class SignInViewController: UIViewController {

    // MARK: - Public Properties

    weak var navigationDelegate: SignInViewControllerNavigationDelegate?

    // MARK: - Private Properties

    private let authService: AutorizationServiceProtocol
    private let signInBottomConstrainFoldedValue: CGFloat = 0.0
    private let signInBottomConstraintExpandedValue: CGFloat = 0.0

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

    @IBOutlet private weak var emailLoginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var primaryButton: PrimaryButton!
    @IBOutlet private weak var signInButtonBottomConstraint: NSLayoutConstraint!

    // MARK: - IBAction
    @IBAction private func tapNavigateToSignUpButton(_ sender: Any) {
        navigationDelegate?.goToSignUp()
    }

    @objc func tapOutside(gesture: UITapGestureRecognizer) {
        emailLoginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    @IBAction private func emailTextfieldDidChange(_ sender: Any) {
        validatePrimaryButton()
    }

    @IBAction private func passwordTextFieldDidChange(_ sender: Any) {
        validatePrimaryButton()
    }

    @objc func keyboardNotification(_ notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo,
              let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        if endFrame.origin.y >= UIScreen.main.bounds.size.height {
            signInButtonBottomConstraint.constant = signInBottomConstraintExpandedValue
        } else {
            let height = endFrame.height + signInBottomConstrainFoldedValue
            signInButtonBottomConstraint.constant = height
        }
        UIView.animate(withDuration: 0.33,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { self.view.layoutIfNeeded() })
    }

    // MARK: - Private Methods

    private func congifure() {
        title = "Вход по логину"
    }

    private func configureTextFields() {
        emailLoginTextField.tintColor = .orange
        emailLoginTextField.tintColorDidChange()
        passwordTextField.tintColor = .orange
        passwordTextField.tintColorDidChange()
    }

    private func configureTapOutside() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func configurePrimaryButton() {
        primaryButton.setTitle("Sign in".localized)
        primaryButton.delegate = self
        primaryButton.setPrimaryButtonEnabled(false)
    }

    private func validatePrimaryButton() {
        if let emailText = emailLoginTextField.text,
           !emailText.isEmpty,
           let passText = passwordTextField.text,
           !passText.isEmpty {
            primaryButton.setPrimaryButtonEnabled(true)
        } else {
            primaryButton.setPrimaryButtonEnabled(false)
        }
    }

    private func configureObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardNotification(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }

}

extension SignInViewController: PrimaryButtonViewDelegate {
    
    func primaryButtonTapped(_ button: PrimaryButton) {
        signIn()
    }

    private func signIn() {
        guard let email = emailLoginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
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
