//
//  SignUpViewController.swift
//  Workplaces
//
//  Created by YesVladess on 05.05.2021.
//

import UIKit

protocol SignUpCoordinatingViewControllerNavigationDelegate: AnyObject {
    func alreadySignedUp()
    func signedUp()
}

final class SignUpCoordinatingViewController: UIViewController {

    // MARK: - Public Properties

    weak var navigationDelegate: SignUpCoordinatingViewControllerNavigationDelegate?

    // MARK: - Private Properties

    private let signInBottomConstrainFoldedValue: CGFloat = 0.0
    private let signInBottomConstraintExpandedValue: CGFloat = 0.0

    private let authService: AutorizationServiceProtocol
    private let profileService: ProfileServiceProtocol

    private var isFirstStep: Bool = true
    private var email: String?
    private var password: String?
    private var nickname: String?

    // MARK: - IBOutlet

    @IBOutlet private weak var stepContainerView: UIView!
    @IBOutlet private weak var primaryButton: PrimaryButton!
    @IBOutlet private weak var signInButtonBottomConstraint: NSLayoutConstraint!

    // MARK: - IBAction

    @IBAction private func tapAlreadySignedUpButton(_ sender: Any) {
        navigationDelegate?.alreadySignedUp()
    }
    
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
        configureObservers()
        configurePrimaryButton()
        configureFirstStep()
    }

    // MARK: - Coordination

    private func configureFirstStep() {
        isFirstStep = true
        title = "Регистрация 1 шаг"
        primaryButton.setTitle("Далее")
        let firstStepViewController = SignUpFirstStepViewController()
        addChild(firstStepViewController)
        firstStepViewController.view.frame = stepContainerView.bounds
        stepContainerView.addSubview(firstStepViewController.view)
        view.sendSubviewToBack(stepContainerView)
        firstStepViewController.didMove(toParent: self)
    }

    private func configureSecondStep() {
        isFirstStep = false
        title = "Регистрация 2 шаг"
        primaryButton.setTitle("Зарегистрироваться")
        let secondStepViewController = SignUpSecondStepViewController()
        addChild(secondStepViewController)
        secondStepViewController.view.frame = stepContainerView.bounds
        stepContainerView.addSubview(secondStepViewController.view)
        view.sendSubviewToBack(stepContainerView)
        secondStepViewController.didMove(toParent: self)
    }

//    @IBAction private func emailTextfieldDidChange(_ sender: Any) {
//        validatePrimaryButton()
//    }
//
//    @IBAction private func passwordTextFieldDidChange(_ sender: Any) {
//        validatePrimaryButton()
//    }

    @objc func keyboardNotification(_ notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo,
              let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        if endFrame.origin.y >= UIScreen.main.bounds.size.height {
            signInButtonBottomConstraint.constant = signInBottomConstraintExpandedValue
        } else {
            let height = endFrame.height + signInBottomConstrainFoldedValue
            signInButtonBottomConstraint.constant = height
        }
        UIView.animate(withDuration: 0.33,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { self.view.layoutIfNeeded() })
    }

    // MARK: - Private Methods

    private func configurePrimaryButton() {
        primaryButton.delegate = self
        primaryButton.setTitle("Sign in".localized)
        primaryButton.delegate = self
        primaryButton.isEnabled = true
    }

    private func validatePrimaryButton() {
//        if let emailText = emailLoginTextField.text,
//           !emailText.isEmpty,
//           let passText = passwordTextField.text,
//           !passText.isEmpty {
//            setPrimaryButtonEnabled(true)
//        } else {
//            setPrimaryButtonEnabled(false)
//        }
    }

    private func configureObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardNotification(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }

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

}

extension SignUpCoordinatingViewController: PrimaryButtonViewDelegate {

    func primaryButtonTapped(_ button: PrimaryButton) {
        if isFirstStep {
            guard let firstStepViewController = get(child: SignUpFirstStepViewController()) else { return }
            guard let resultTuple = firstStepViewController.getData() else { return }
            email = resultTuple.email
            password = resultTuple.password
            nickname = resultTuple.nickname
            configureSecondStep()
        } else {
            guard let secondStepViewController = get(child: SignUpSecondStepViewController()) else { return }
            guard let resultTuple = secondStepViewController.getData() else { return }
            let name = resultTuple.name
            let surname = resultTuple.surname
            let date = resultTuple.date
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
                        self?.navigationDelegate?.signedUp()
                    case.failure:
                        // self?.showError(error.localizedDescription)
                        self?.showErrorAnimation()
                    }
                })
        }
    }

}
