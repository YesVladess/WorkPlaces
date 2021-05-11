//
//  SignInViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

protocol SignInViewControllerNavigationDelegate: class {
    func signedIn()
    func goToSignUp()
}

final class SignInViewController: UIViewController {

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
        primaryButton.delegate = self
    }

    // MARK: - IBOutlet

    @IBOutlet private weak var emailLoginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var primaryButton: PrimaryButton!

    // MARK: - IBAction
    @IBAction private func tapNavigateToSignUpButton(_ sender: Any) {
        navigationDelegate?.goToSignUp()
    }

    // MARK: - Private Methods

    private func congifure() {
        primaryButton.setTitle("Sign in By Mail Or Login".localized)
        title = "Вход по логину"
    }

}

extension SignInViewController: PrimaryButtonViewDelegate {
    
    func primaryButtonTapped(_ button: PrimaryButton) {
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
