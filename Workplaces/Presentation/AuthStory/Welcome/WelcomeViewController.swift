//
//  WelcomeViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

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
        let feedViewController = FeedViewController()
        navigationController?.pushViewController(feedViewController, animated: true)
    }

}

extension WelcomeViewController: PrimaryButtonViewDelegate {

    func primaryButtonTapped(_ button: PrimaryButton) {
        navigateToFeedScreen()
    }

}
