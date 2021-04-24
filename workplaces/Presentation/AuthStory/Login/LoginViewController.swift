//
//  LoginViewController.swift
//  workplaces
//
//  Created by YesVladess on 18.04.2021.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        congifure()
        primaryButton.delegate = self
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var primaryButton: PrimaryButton!

    private func congifure() {
        primaryButton.setTitle("Sign in By Mail Or Login".localized)
        imageView.image = Images.loginScreenImage
    }

}

extension LoginViewController: PrimaryButtonViewDelegate {
    
    func primaryButtonTapped(_ button: PrimaryButton) {
        let signInViewController = SignInViewController()
        self.navigationController?.pushViewController(signInViewController, animated: true)
    }

}
