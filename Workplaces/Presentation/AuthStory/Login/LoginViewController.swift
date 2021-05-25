//
//  LoginViewController.swift
//  workplaces
//
//  Created by YesVladess on 18.04.2021.
//

import VK_ios_sdk

protocol LoginViewControllerNavigationDelegate: AnyObject {
    func navigateToSignIn()
    func navigateToSignUp()
    func navigateToWelcome()
}

final class LoginViewController: UIViewController, CanShowSpinner {

    // MARK: - Public Properties

    var spinner: SpinnerView = SpinnerView(style: .large)
    weak var navigationDelegate: LoginViewControllerNavigationDelegate?

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
        configure()
        configurePrimaryButton()
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
                self?.navigationDelegate?.navigateToWelcome()
            case.failure(let error):
                self?.showError(error.localizedDescription)
            }
        })
    }

    @IBAction private func vkButtonTapped(_ sender: Any) {
        authService.signInWithVK(vkUIDelegate: self, completion: { [weak self] result in
            switch result {
            case .success:
                self?.navigationDelegate?.navigateToWelcome()
            case.failure(let error):
                self?.showError(error.localizedDescription)
            }
        })
    }

    @IBAction private func googleButtonTapped(_ sender: Any) {
        authService.signInWithGoogle(presentingViewController: self, completion: { [weak self] result in
            switch result {
            case .success:
                self?.navigationDelegate?.navigateToWelcome()
            case.failure(let error):
                self?.showError(error.localizedDescription)
            }
        })
    }

    @IBAction private func singUpButtonTapped(_ sender: Any) {
        navigationDelegate?.navigateToSignUp()
    }

    // MARK: - Private Methods

    private func configure() {
        imageView.image = #imageLiteral(resourceName: "Illustration_01")
        fbButton.cropView()
        vkButton.cropView()
        googleButton.cropView()
    }

    private func configurePrimaryButton() {
        primaryButton.setTitle("Sign in By Mail Or Login".localized)
        primaryButton.delegate = self
        primaryButton.setPrimaryButtonEnabled(true)
    }

}

extension LoginViewController: PrimaryButtonViewDelegate {
    
    func primaryButtonTapped(_ button: PrimaryButton) {
        navigationDelegate?.navigateToSignIn()
    }

}

extension LoginViewController: VKSdkUIDelegate {

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.present(controller, animated: true)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let vcCaptchaViewController = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vcCaptchaViewController?.present(in: self)
    }

}
