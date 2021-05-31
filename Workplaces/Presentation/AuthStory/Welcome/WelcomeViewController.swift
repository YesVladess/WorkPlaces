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
        configure()
        primaryButton.onTap = { [weak self] in
            self?.navigationDelegate?.navigateToFeed()
        }
    }

    private func configure() {
        primaryButton.setTitle("Перейти к ленте")
    }

}
