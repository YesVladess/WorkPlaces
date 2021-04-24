//
//  LoginViewController.swift
//  workplaces
//
//  Created by YesVladess on 18.04.2021.
//

import UIKit

class LoginViewController: UIViewController, CanShowSpinner {

    var spinner: SpinnerView = SpinnerView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        congifure()
        primaryButton.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showSpinner()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.hideSpinner()
        }
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
