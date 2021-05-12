//
//  ProfileViewController.swift
//  Workplaces
//
//  Created by YesVladess on 05.05.2021.
//

import UIKit

final class ProfileCoordinatingViewController: UIViewController {

    // MARK: - Private Properties

    private let profileService: ProfileServiceProtocol

    // MARK: - Initializers

    init(
        profileService: ProfileServiceProtocol = ServiceLayer.shared.profileService
    ) {
        self.profileService = profileService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Профиль"
        getProfile()
    }

    // MARK: - Coordinate Childs

    private func configureMyProfile(profile: UserProfile) {
        let myProfileViewController = MyProfileViewController()
        transition(to: myProfileViewController)
        myProfileViewController.setupViewController(profile: profile)
    }

    private func configureProfileTab() {
        let profileTabViewController = ProfileTabViewController()
        profileTabViewController.delegate = self
        add(profileTabViewController)
    }

    // MARK: - Private Methods

    private func getProfile() {
        profileService.getMyProfile(completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.showProfile(profile: result)
            case.failure(let error):
                self?.showError(error.localizedDescription)
            }
        })
    }

    private func showProfile(profile: UserProfile) {
        if let profileNickname = profile.nickname {
            self.navigationItem.title = "@\(profileNickname)"
        } else {
            self.navigationItem.title = "Профиль"
        }
        configureMyProfile(profile: profile)
        configureProfileTab()
    }

    private func showPosts() {

    }

    private func showLikes() {

    }

    private func showFriends() {

    }
}

extension ProfileCoordinatingViewController: ProfileTabViewControllerDelegate {

    func postsTapped() {
        showPosts()
    }

    func likesTapped() {
        showLikes()
    }

    func friendTapped() {
        showFriends()
    }

}
