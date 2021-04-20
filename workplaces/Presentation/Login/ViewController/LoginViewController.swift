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
    }

    @IBOutlet private weak var primaryButton: PrimaryButton!

    private func congifure() {
        primaryButton.setTitle("Sign in By Mail Or Login".localized)
    }

}
