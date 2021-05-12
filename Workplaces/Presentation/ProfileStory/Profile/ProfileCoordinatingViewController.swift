//
//  ProfileViewController.swift
//  Workplaces
//
//  Created by YesVladess on 05.05.2021.
//

import UIKit

final class ProfileCoordinatingViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    // MARK: - Private Properties

    private let profileService: ProfileServiceProtocol
    private var profileViewController: MyProfileViewController?

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
        addChildsAndSetupStack()
        getProfile()
        
    }

    // MARK: - Coordinate Childs

    private func addChildsAndSetupStack() {
        let myProfileViewController = MyProfileViewController()
        addChild(myProfileViewController)
        stackView.addArrangedSubview(myProfileViewController.view)
        myProfileViewController.didMove(toParent: self)
        self.profileViewController = myProfileViewController

        let profileTabViewController = ProfileTabViewController()
        profileTabViewController.delegate = self
        addChild(profileTabViewController)
        stackView.addArrangedSubview(profileTabViewController.view)
        profileTabViewController.didMove(toParent: self)

        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 20.0
    }

    private func configureMyProfile(profile: UserProfile) {
        profileViewController?.setupViewController(profile: profile)
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
