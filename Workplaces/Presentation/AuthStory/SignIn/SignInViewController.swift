//
//  SignInViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit
import WorkplacesAPI

class SignInViewController: UIViewController {

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

    // MARK: - Private Methods

    private func congifure() {
        primaryButton.setTitle("Sign in By Mail Or Login".localized)
    }

    // MARK: - Navigation

    private func navigateToWelcomeScreen() {
        let welcomeViewController = WelcomeViewController()
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }

}

extension SignInViewController: PrimaryButtonViewDelegate {
    
    func primaryButtonTapped(_ button: PrimaryButton) {
        let userCreds = UserCredentials(email: "vladTest7@server.com", password: "Mypass12")
        authService.signIn(withCredentials: userCreds,
                           completion: { [weak self] result in
                            switch result {
                            case .success:
                                self?.navigateToWelcomeScreen()
                            case.failure(let error):
                                self?.showError(error.localizedDescription)
                            }
                           })
    }

}