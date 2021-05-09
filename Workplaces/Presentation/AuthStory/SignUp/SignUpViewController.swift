//
//  SignUpViewController.swift
//  Workplaces
//
//  Created by YesVladess on 05.05.2021.
//

import UIKit

final class SignUpViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var dataBirthTextField: UITextField!
    @IBOutlet private weak var signUpButton: PrimaryButton!

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
        title = "Регистрация"
        signUpButton.delegate = self
        signUpButton.setTitle("Зарегистрироваться")
    }

    // MARK: - Navigation

    private func navigateToWelcomeScreen() {
        let welcomeViewController = WelcomeViewController()
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}

extension SignUpViewController: PrimaryButtonViewDelegate {

    func primaryButtonTapped(_ button: PrimaryButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return }
        authService.signUp(email: email, password: password, completion: { [weak self] result in
            switch result {
            case .success:
                self?.navigateToWelcomeScreen()
            case.failure(let error):
                self?.showError(error.localizedDescription)
            }
        })
    }

}
