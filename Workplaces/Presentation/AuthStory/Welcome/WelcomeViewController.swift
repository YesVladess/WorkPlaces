//
//  WelcomeViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

protocol WelcomeViewControllerNavigationDelegate: AnyObject {
    func navigateToFeedButtonTapped()
}

final class WelcomeViewController: UIViewController {

    weak var navigationDelegate: WelcomeViewControllerNavigationDelegate?

    @IBOutlet private weak var primaryButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        primaryButton.onTap = { [weak self] in
            self?.navigationDelegate?.navigateToFeedButtonTapped()
        }
    }

    private func configure() {
        primaryButton.setTitle("Перейти к ленте")
    }

}
