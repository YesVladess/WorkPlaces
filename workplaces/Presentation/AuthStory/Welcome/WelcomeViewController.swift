//
//  WelcomeViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet private weak var primaryButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        primaryButton.setTitle("Sign in By Mail Or Login".localized)
    }

}
