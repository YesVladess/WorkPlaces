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

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instantiateNavigationController()
        configureNavigationController()
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
        authNavigationController?.pushViewController(tabBarController, animated: true)
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

}

extension AuthCoordinatingViewController: LoginViewControllerNavigationDelegate {

    func navigateToSignInButtonTapped() {
        navigateToSignInScreen()
    }

    func navigateToSignUpButtonTapped() {
        navigateToSignUpScreen()
    }

    func authPassed() {
        navigateToWelcomeScreen()
    }

}

extension AuthCoordinatingViewController: SignInViewControllerNavigationDelegate {

    func signInPassed() {
        authPassed()
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

    func signUpPassed() {
        authPassed()
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
            viewController is WorkplaceTabBarController {
            authNavigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            authNavigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

}
