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

    @IBOutlet private weak var navigateToFeedButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        navigateToFeedButton.delegate = self
    }

    private func configure() {
        title = "Добро пожаловать"
        navigateToFeedButton.setTitle("Перейти к ленте")
    }

}

extension WelcomeViewController: PrimaryButtonViewDelegate {

    func primaryButtonTapped(_ button: PrimaryButton) {
        navigationDelegate?.navigateToFeed()
    }

}
