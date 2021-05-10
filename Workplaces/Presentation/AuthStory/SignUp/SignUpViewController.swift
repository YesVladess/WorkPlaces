//
//  SignUpViewController.swift
//  Workplaces
//
//  Created by YesVladess on 05.05.2021.
//

import UIKit

final class SignUpViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var dataBirthTextField: UITextField!
    @IBOutlet private weak var signUpButton: PrimaryButton!

    // MARK: - IBAction

    @IBAction private func tapAlreadySignedUpButton(_ sender: Any) {
        navigateToSignInScreen()
    }

    @IBAction private func tapBirthDateField(_ sender: Any) {
        showDatePicker()
    }

    // MARK: - Private Properties

    private let authService: AutorizationServiceProtocol
    private let profileService: ProfileServiceProtocol
    private let datePicker = UIDatePicker()
    
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
        title = "Регистрация"
        signUpButton.delegate = self
        signUpButton.setTitle("Зарегистрироваться")
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

    // MARK: - Private Methods

    private func updateProfileInfo(
        nickname: String?,
        name: String,
        surname: String,
        birthDate: String
    ) {
        profileService.changeMyProfile(
            firstName: name,
            lastName: surname,
            nickname: nickname,
            avatarUrl: nil,
            birthDay: birthDate,
            completion: { [weak self] result in
                switch result {
                case .success:
                    break
                case.failure(let error):
                    self?.showError(error.localizedDescription)
                }
            })
    }

    private func showDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = .black
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateChosen))
        toolbar.setItems([done], animated: false)
        dataBirthTextField.inputAccessoryView = toolbar
        dataBirthTextField.inputView = datePicker
    }

    @objc private func dateChosen() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dataBirthTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

}

extension SignUpViewController: PrimaryButtonViewDelegate {

    func primaryButtonTapped(_ button: PrimaryButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let nickname = nicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let surname = surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let date = dataBirthTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return }
        // TODO: Тут сделать валидацию:
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
