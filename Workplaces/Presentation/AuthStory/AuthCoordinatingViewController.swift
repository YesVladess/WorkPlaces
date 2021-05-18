//
//  AuthCoordinatingViewController.swift
//  Workplaces
//
//  Created by YesVladess on 12.05.2021.
//

import UIKit

class AuthCoordinatingViewController: UIViewController, CanShowSpinner {

    // MARK: - Private Properties

    private var authNavigationController: UINavigationController?
    var spinner: SpinnerView = SpinnerView(style: .large)

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
        let signUpViewController = SignUpCoordinatingViewController()
        signUpViewController.navigationDelegate = self
        authNavigationController?.pushViewController(signUpViewController, animated: true)
    }

    private func navigateToFeedScreen() {
        let tabBarController = WorkplaceTabBarController()
        authNavigationController?.isNavigationBarHidden = true
        authNavigationController?.pushViewController(tabBarController, animated: true)
    }

    // MARK: - Private Methods

    private func instantiateNavigationController() {
        let loginViewController = LoginViewController()
        loginViewController.navigationDelegate = self
        let authNavigationController = UINavigationController(rootViewController: loginViewController)
        authNavigationController.isNavigationBarHidden = true
        add(authNavigationController)
        self.authNavigationController = authNavigationController
    }

    private func configureNavigationController() {
        authNavigationController?.navigationBar.barStyle = .default
        authNavigationController?.navigationBar.barTintColor = .white
        authNavigationController?.navigationBar.tintColor = .middleGrey
        authNavigationController?.navigationBar.isTranslucent = false
        authNavigationController?.navigationBar.titleTextAttributes =
            [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont(name: "IBMPlexSans", size: 16)!
            ]
    }

}

extension AuthCoordinatingViewController: LoginViewControllerNavigationDelegate {

    func navigateToSignIn() {
        navigateToSignInScreen()
        authNavigationController?.isNavigationBarHidden = false
    }

    func navigateToSignUp() {
        navigateToSignUpScreen()
        authNavigationController?.isNavigationBarHidden = false
    }

    func navigateToWelcome() {
        navigateToWelcomeScreen()
        authNavigationController?.isNavigationBarHidden = true
    }

}

extension AuthCoordinatingViewController: WelcomeViewControllerNavigationDelegate {

    func navigateToFeed() {
        navigateToFeedScreen()
        authNavigationController?.isNavigationBarHidden = true
    }

}

extension AuthCoordinatingViewController: SignInViewControllerNavigationDelegate {

    func signedIn() {
        navigateToWelcome()
    }

    func goToSignUp() {
        navigateToSignUpScreen()
        guard let controllersCount = authNavigationController?.viewControllers.count else { return }
        authNavigationController?.viewControllers.remove(at: controllersCount - 2)
    }

}

extension AuthCoordinatingViewController: SignUpCoordinatingViewControllerNavigationDelegate {

    func alreadySignedUp() {
        navigateToSignInScreen()
        guard let controllersCount = authNavigationController?.viewControllers.count else { return }
        authNavigationController?.viewControllers.remove(at: controllersCount - 2)
    }

    func signedUp() {
        navigateToWelcome()
    }

}
