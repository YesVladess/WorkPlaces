//
//  SignInViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet private weak var emailLoginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var primaryButton: PrimaryButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        congifure()
        primaryButton.delegate = self
    }

    private func congifure() {
        primaryButton.setTitle("Sign in By Mail Or Login".localized)
    }

}

extension SignInViewController: PrimaryButtonViewDelegate {
    
    func primaryButtonTapped(_ button: PrimaryButton) {
        let welcomeViewController = WelcomeViewController()
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }

}
