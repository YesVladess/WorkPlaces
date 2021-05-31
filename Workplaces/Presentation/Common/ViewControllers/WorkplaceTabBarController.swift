//
//  WorkplaceTabBarController.swift
//  Workplaces
//
//  Created by YesVladess on 05.05.2021.
//

import UIKit

final class WorkplaceTabBarController: UITabBarController {

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

        let profileViewController = UINavigationController(rootViewController: ProfileCoordinatingViewController())
        profileViewController.setNavigationBarHidden(true, animated: true)
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

}
