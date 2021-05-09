//
//  WelcomeViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

final class WelcomeViewController: UIViewController {

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

    // MARK: - Navigation

    private func navigateToFeedScreen() {
        let tabBarController = WorkplaceTabBarController()
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(tabBarController, animated: true)
    }

}

extension WelcomeViewController: PrimaryButtonViewDelegate {

    func primaryButtonTapped(_ button: PrimaryButton) {
        navigateToFeedScreen()
    }

}
