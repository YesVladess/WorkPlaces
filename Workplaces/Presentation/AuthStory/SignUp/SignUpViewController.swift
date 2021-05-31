//
//  SignUpViewController.swift
//  Workplaces
//
//  Created by YesVladess on 05.05.2021.
//

import UIKit

protocol SignUpNavigationDelegate: AnyObject {
    func needSignInButtonTapped()
    func signUpPassed()
}

final class SignUpViewController: UIViewController {

    // MARK: - Public Properties

    weak var navigationDelegate: SignUpNavigationDelegate?

    // MARK: - Private Properties

    private let authService: AutorizationServiceProtocol
    private let profileService: ProfileServiceProtocol

    private var isFirstStep: Bool = true
    private var email: String?
    private var password: String?
    
    // MARK: - Initializers

    init(
        authService: AutorizationServiceProtocol = ServiceLayer.shared.authorizationService,
        profileService: ProfileServiceProtocol = ServiceLayer.shared.profileService
    ) {
        self.authService = authService
        self.profileService = profileService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFirstStep()
    }

    // MARK: - Coordination

    private func configureFirstStep() {
        isFirstStep = true
        title = "Регистрация 1 шаг"
        let firstStepViewController = SignUpFirstStepViewController()
        firstStepViewController.navigationDelegate = self
        addFullScreen(child: firstStepViewController)
    }

    private func configureSecondStep() {
        isFirstStep = false
        title = "Регистрация 2 шаг"
        let secondStepViewController = SignUpSecondStepViewController()
        secondStepViewController.navigationDelegate = self
        transition(to: secondStepViewController, fullScreen: true)
    }

    // MARK: - Private Methods

    private func updateProfileInfo(
        nickname: String?,
        name: String,
        surname: String,
        birthDate: String
    ) {
        let profile = UserProfileWithoutID(
            firstName: name,
            lastName: surname,
            nickname: nickname,
            avatarUrl: nil,
            birthDay: birthDate
        )
        profileService.changeMyProfile(
            profile: profile,
            completion: { [weak self] result in
                switch result {
                case .success:
                    break
                case.failure(let error):
                    self?.showError(error.localizedDescription)
                }
            })
    }

    private func showErrorAnimation() {
        guard let secondStepViewController = get(child: SignUpSecondStepViewController()) else {
            return
        }
        secondStepViewController.showErrorAnimation()
    }

    private func validateStep() {
        if isFirstStep {
            guard let firstStepViewController = get(child: SignUpFirstStepViewController()) else { return }
            guard let resultTuple = firstStepViewController.getData() else { return }
            email = resultTuple.email
            password = resultTuple.password
            configureSecondStep()
        } else {
            guard let secondStepViewController = get(child: SignUpSecondStepViewController()) else { return }
            guard let resultTuple = secondStepViewController.getData() else { return }
            let nickname = resultTuple.nickname
            let name = resultTuple.name
            let surname = resultTuple.surname
            let date = resultTuple.date
            // TODO: Тут сделать валидацию:
            guard let email = email,
                  let password = password else { return }
            authService.signUp(
                email: email,
                password: password,
                completion: { [weak self] result in
                    switch result {
                    case .success:
                        self?.updateProfileInfo(
                            nickname: nickname,
                            name: name,
                            surname: surname,
                            birthDate: date
                        )
                        self?.navigationDelegate?.signUpPassed()
                    case.failure(let error):
                        self?.showError(error.localizedDescription)
                        // self?.showErrorAnimation()
                    }
                })
        }
    }
    
}

extension SignUpViewController: SignUpFirstStepNavigationDelegate {
    
    func firstStepPrimaryButtonTapped() {
        validateStep()
    }

    func secondaryButtonTapped() {
        navigationDelegate?.needSignInButtonTapped()
    }

}

extension SignUpViewController: SignUpSecondStepNavigationDelegate {

    func secondStepPrimaryButtonTapped() {
        validateStep()
    }

}
