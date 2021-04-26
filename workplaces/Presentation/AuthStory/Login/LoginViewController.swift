//
//  LoginViewController.swift
//  workplaces
//
//  Created by YesVladess on 18.04.2021.
//

import UIKit

class LoginViewController: UIViewController, CanShowSpinner {

    // MARK: - Public Properties

    var spinner: SpinnerView = SpinnerView(style: .large)

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

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var primaryButton: PrimaryButton!
    @IBOutlet private weak var fbButton: UIButton!
    @IBOutlet private weak var vkButton: UIButton!
    @IBOutlet private weak var googleButton: UIButton!

    // MARK: - IBActions

    @IBAction private func fbButtonTapped(_ sender: Any) {
        authService.signInWithFacebook(completion: { [weak self] result in
            switch result {
            case .success:
            self?.navigateToWelcomeScreen()
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    @IBAction private func vkButtonTapped(_ sender: Any) {
    }

    @IBAction private func googleButtonTapped(_ sender: Any) {
    }

    // MARK: - Private Methods

    private func congifure() {
        primaryButton.setTitle("Sign in By Mail Or Login".localized)
        imageView.image = Images.loginScreenImage
    }

    // MARK: - Navigation
    
    private func navigateToWelcomeScreen() {
        let welcomeViewController = WelcomeViewController()
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }

    private func navigateToSignInScreen() {
        let signInViewController = SignInViewController()
        navigationController?.pushViewController(signInViewController, animated: true)
    }

}

extension LoginViewController: PrimaryButtonViewDelegate {
    
    func primaryButtonTapped(_ button: PrimaryButton) {
        navigateToSignInScreen()
    }

}
