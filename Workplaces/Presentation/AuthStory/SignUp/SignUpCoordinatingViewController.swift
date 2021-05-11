//
//  SignUpViewController.swift
//  Workplaces
//
//  Created by YesVladess on 05.05.2021.
//

import UIKit

final class SignUpCoordinatingViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var signUpButton: PrimaryButton!

    // MARK: - Private Properties

    private let authService: AutorizationServiceProtocol
    private let profileService: ProfileServiceProtocol

    private var isFirstStep: Bool = true
    private var email: String?
    private var password: String?
    private var nickname: String?
    
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
        signUpButton.delegate = self
        configureFirstStep()
    }

    // MARK: - Navigation

    private func navigateToWelcomeScreen() {
        let welcomeViewController = WelcomeViewController()
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }

    private func navigateToSignInScreen() {
        let signInViewController = SignInViewController()
        navigationController?.pushViewController(signInViewController, animated: true)
    }

    // MARK: - Coordination

    private func configureFirstStep() {
        isFirstStep = true
        title = "Регистрация 1 шаг"
        signUpButton.setTitle("Далее")
        let firstStepViewController = SignUpFirstStepViewController()
        firstStepViewController.delegate = self
        transition(to: firstStepViewController)
    }

    private func configureSecondStep() {
//        guard let firstStepViewController = get(child: SignUpFirstStepViewController()) else { return }
//        firstStepViewController.remove()
        isFirstStep = false
        title = "Регистрация 2 шаг"
        signUpButton.setTitle("Зарегистрироваться")
        let secondStepViewController = SignUpSecondStepViewController()
        secondStepViewController.delegate = self
        transition(to: secondStepViewController)
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

}

extension SignUpCoordinatingViewController: SignUpFirstStepViewControllerDelegate {

    func alreadySignedIn() {
        navigateToSignInScreen()
    }

}

extension SignUpCoordinatingViewController: SignUpSecondStepViewControllerDelegate {

    func nextstep() {
        
    }

}

extension SignUpCoordinatingViewController: PrimaryButtonViewDelegate {

    func primaryButtonTapped(_ button: PrimaryButton) {
        if isFirstStep {
            guard let firstStepViewController = get(child: SignUpFirstStepViewController()) else { return }
            guard let resultTuple = firstStepViewController.getData() else { return }
            email = resultTuple.0
            password = resultTuple.1
            nickname = resultTuple.2
            configureSecondStep()
        } else {
            guard let secondStepViewController = get(child: SignUpSecondStepViewController()) else { return }
            guard let resultTuple = secondStepViewController.getData() else { return }
            let name = resultTuple.0
            let surname = resultTuple.1
            let date = resultTuple.2
            // TODO: Тут сделать валидацию:
            guard let email = email,
                  let password = password,
                  let nickname = nickname else { return }
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
                        self?.navigateToWelcomeScreen()
                    case.failure(let error):
                        self?.showError(error.localizedDescription)
                    }
                })
        }
    }

}
