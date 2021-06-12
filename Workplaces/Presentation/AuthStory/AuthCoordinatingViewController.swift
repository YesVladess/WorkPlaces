//
//  AuthCoordinatingViewController.swift
//  Workplaces
//
//  Created by YesVladess on 12.05.2021.
//

import UIKit

class AuthCoordinatingViewController: UIViewController {

    // MARK: - Private Properties

    private var authNavigationController: UINavigationController?
    private let keychainStorage: KeychainStorageProtocol

    // MARK: - UIViewController

    init(
        keychainStorage: KeychainStorageProtocol = ServiceLayer.shared.keychainStorage
    ) {
        self.keychainStorage = keychainStorage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        instantiateNavigationController()
        configureNavigationController()
        checkIfAutorized()
    }

    // MARK: - Navigation

    private func navigateToWelcomeScreen() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.navigationDelegate = self
        authNavigationController?.pushViewController(welcomeViewController, animated: true)
    }

    private func navigateToSignInScreen() {
        let signInViewController = SignInViewController()
        signInViewController.navigationDelegate = self
        authNavigationController?.pushViewController(signInViewController, animated: true)
    }

    private func navigateToSignUpScreen() {
        let signUpViewController = SignUpViewController()
        signUpViewController.navigationDelegate = self
        authNavigationController?.pushViewController(signUpViewController, animated: true)
    }

    private func navigateToFeedScreen() {
        let tabBarController = WorkplaceTabBarController()
        tabBarController.navigationDelegate = self
        authNavigationController?.pushViewController(tabBarController, animated: true)
    }

    private func navigateToPinCodeScreen(withRefreshToken refreshToken: String, animated: Bool = true) {
        let pinCodeViewController = PinCodeViewController()
        pinCodeViewController.navigationDelegate = self
        pinCodeViewController.refreshToken = refreshToken
        authNavigationController?.pushViewController(pinCodeViewController, animated: animated)
    }

    private func navigateToPinCodeScreen(animated: Bool = true) {
        let pinCodeViewController = PinCodeViewController()
        pinCodeViewController.navigationDelegate = self
        authNavigationController?.pushViewController(pinCodeViewController, animated: animated)
    }

    private func navigateToLoginScreen() {
        authNavigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Private Methods

    private func instantiateNavigationController() {
        let loginViewController = LoginViewController()
        loginViewController.navigationDelegate = self
        let authNavigationController = UINavigationController(rootViewController: loginViewController)
        authNavigationController.delegate = self
        add(child: authNavigationController)
        self.authNavigationController = authNavigationController
    }

    private func configureNavigationController() {
        guard let authNavigationController = authNavigationController else { return }
        authNavigationController.navigationBar.barStyle = .default
        authNavigationController.navigationBar.barTintColor = .white
        authNavigationController.navigationBar.tintColor = .middleGrey
        authNavigationController.navigationBar.isTranslucent = false
        authNavigationController.navigationBar.titleTextAttributes =
            [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont(name: "IBMPlexSans", size: 16)!
            ]
    }

    private func checkIfAutorized() {
        if keychainStorage.checkIfRefreshTokenIsSetInKeychain() {
            navigateToPinCodeScreen(animated: false)
        }
    }

}

extension AuthCoordinatingViewController: LoginViewControllerNavigationDelegate {

    func navigateToSignInButtonTapped() {
        navigateToSignInScreen()
    }

    func navigateToSignUpButtonTapped() {
        navigateToSignUpScreen()
    }

    func authPassed() {
        navigateToPinCodeScreen()
    }

}

extension AuthCoordinatingViewController: SignInViewControllerNavigationDelegate {

    func signInPassed(refreshToken: String) {
        navigateToPinCodeScreen(withRefreshToken: refreshToken)
    }

    func needSignUpButtonTapped() {
        navigateToSignUpScreen()
        guard let controllersCount = authNavigationController?.viewControllers.count else { return }
        authNavigationController?.viewControllers.remove(at: controllersCount - 2)
    }

}

extension AuthCoordinatingViewController: SignUpNavigationDelegate {

    func needSignInButtonTapped() {
        navigateToSignInScreen()
        guard let controllersCount = authNavigationController?.viewControllers.count else { return }
        authNavigationController?.viewControllers.remove(at: controllersCount - 2)
    }

    func signUpPassed(refreshToken: String) {
        navigateToPinCodeScreen(withRefreshToken: refreshToken)
    }

}

extension AuthCoordinatingViewController: PinCodeViewControllerNavigationDelegate {

    func secondFactorPassed() {
        navigateToWelcomeScreen()
    }

    func resetPinCode() {
        navigateToLoginScreen()
    }
    
}

extension AuthCoordinatingViewController: WelcomeViewControllerNavigationDelegate {

    func navigateToFeedButtonTapped() {
        navigateToFeedScreen()
    }

}

extension AuthCoordinatingViewController: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        if viewController is WelcomeViewController ||
            viewController is LoginViewController ||
            viewController is PinCodeViewController ||
            viewController is WorkplaceTabBarController {
            authNavigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            authNavigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

}

extension AuthCoordinatingViewController: WorkplaceTabBarControllerNavigationDelegate {

    func deauthorize() {
        navigateToLoginScreen()
    }

}
