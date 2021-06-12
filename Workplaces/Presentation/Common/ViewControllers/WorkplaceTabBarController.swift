//
//  WorkplaceTabBarController.swift
//  Workplaces
//
//  Created by YesVladess on 05.05.2021.
//

import UIKit

protocol WorkplaceTabBarControllerNavigationDelegate: AnyObject {
    func deauthorize()
}

final class WorkplaceTabBarController: UITabBarController {

    // MARK: - Public Properties

    weak var navigationDelegate: WorkplaceTabBarControllerNavigationDelegate?

    // MARK: - Private Properties

    private let authService: AutorizationServiceProtocol
    private let keychainStorage: KeychainStorageProtocol

    // MARK: - UIViewController

    init(
        authService: AutorizationServiceProtocol = ServiceLayer.shared.authorizationService,
        keychainStorage: KeychainStorageProtocol = ServiceLayer.shared.keychainStorage
    ) {
        self.authService = authService
        self.keychainStorage = keychainStorage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabs()
        configureTabBar()
    }

    private func configureTabs() {

        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        feedViewController.setNavigationBarHidden(true, animated: true)
        feedViewController.tabBarItem = UITabBarItem(
            title: "Мой Фид",
            image: #imageLiteral(resourceName: "homeDefault"),
            selectedImage: #imageLiteral(resourceName: "homeActive")
        )

        let newPostViewController = UINavigationController(rootViewController: NewPostViewController())
        newPostViewController.tabBarItem = UITabBarItem(
            title: "Пост",
            image: #imageLiteral(resourceName: "newPostDefault"),
            selectedImage: #imageLiteral(resourceName: "newPostActive")
        )

        let profileCoordinatingViewController = ProfileCoordinatingViewController()
        profileCoordinatingViewController.navigationItem.rightBarButtonItem = setupExitButton()
        let profileViewController = UINavigationController(rootViewController: profileCoordinatingViewController)
        profileViewController.setNavigationBarHidden(false, animated: true)
        profileViewController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: #imageLiteral(resourceName: "profileDefault"),
            selectedImage: #imageLiteral(resourceName: "profileActive")
        )
        viewControllers = [feedViewController, newPostViewController, profileViewController]
    }

    private func configureTabBar() {
        tabBar.tintColor = .white
        tabBar.barStyle = .black
    }

    private func setupExitButton() -> UIBarButtonItem {
        let exitButton = UIBarButtonItem(
            title: "Выйти",
            style: .plain,
            target: self,
            action: #selector(logOutTapped)
        )
        exitButton.tintColor = .black
        return exitButton
    }

    @objc func logOutTapped() {
        authService.logout()
        keychainStorage.clearKeychain()
        navigationDelegate?.deauthorize()
    }

}
