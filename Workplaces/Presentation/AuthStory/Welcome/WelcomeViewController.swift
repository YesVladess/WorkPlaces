//
//  WelcomeViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

protocol WelcomeViewControllerNavigationDelegate: AnyObject {
    func navigateToFeed()
}

final class WelcomeViewController: UIViewController {

    weak var navigationDelegate: WelcomeViewControllerNavigationDelegate?

    @IBOutlet private weak var primaryButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePrimaryButton()
    }

    private func configurePrimaryButton() {
        primaryButton.setTitle("Перейти к ленте")
        primaryButton.isEnabled = true
        primaryButton.onTap = { [weak self] in
            self?.navigationDelegate?.navigateToFeed()
        }
    }

}
