//
//  PinCodeViewController.swift
//  Workplaces
//
//  Created by YesVladess on 08.06.2021.
//

import LocalAuthentication
import UIKit

protocol PinCodeViewControllerNavigationDelegate: AnyObject {
    func secondFactorPassed()
    func resetPinCode()
}

final class PinCodeViewController: BaseViewController {

    // MARK: - Public Properties

    weak var navigationDelegate: PinCodeViewControllerNavigationDelegate?
    public var refreshToken: String?

    // MARK: - Private Properties

    private var pinCode: String?
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
        configureTapOutside()
        configureTextField()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkForBioAuth()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tapOutside()
    }

    // MARK: - IBOutlet

    @IBOutlet private weak var pinCodeTextField: UITextField!

    // MARK: - IBAction
    @IBAction private func secondaryButtonTapped(_ sender: Any) {
        keychainStorage.clearKeychain()
        navigationDelegate?.resetPinCode()
    }

    @IBAction private func textfieldDidChange(_ sender: UITextField) {
        validateTextField()
    }

    @objc func tapOutside() {
        pinCodeTextField.resignFirstResponder()
    }

    // MARK: - Private Methods

    // MARK: - UI
    
    private func configureTextField() {
        pinCodeTextField.tintColor = .black
        pinCodeTextField.tintColorDidChange()
    }

    private func configureTapOutside() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside))
        view.addGestureRecognizer(tapGesture)
    }

    private func validateTextField() {
        if let pinCodeText = pinCodeTextField.text,
           !pinCodeText.isEmpty,
           pinCodeText.count == 4 {
            self.pinCode = pinCodeText
            pinCodeIsSet()
        }
    }

    private func successAuth() {
        self.hideSpinner()
        self.navigationDelegate?.secondFactorPassed()
    }

    private func authFailed() {
        showError("Не удалось авторизоваться")
        hideSpinner()
        navigationDelegate?.resetPinCode()
    }

    private func showPinInvalid() {
        hideSpinner()
        showError("Неправильный пин")
    }

    // MARK: - Auth Logic

    private func pinCodeIsSet() {
        guard let pinCode = self.pinCode else { return }
        showSpinner()
        if refreshToken != nil {
            tryBiometryAuth(completion: { [weak self] biometryPassed in
                guard let pinCode = self?.pinCode,
                      let refreshToken = self?.refreshToken else { return }
                self?.keychainStorage.saveRefreshTokenToKeychain(withRefreshToken: refreshToken, andPin: pinCode)
                if biometryPassed {
                    self?.keychainStorage.savePinToKeychainWithBiometry(pin: pinCode)
                }
                DispatchQueue.main.async { [unowned self] in
                    self?.successAuth()
                }
            })
        } else if keychainStorage.checkIfRefreshTokenIsSetInKeychain() {
            guard let refreshToken = keychainStorage.getRefreshTokenFromKeychain(withPin: pinCode) else {
                showPinInvalid()
                return
            }
            keychainStorage.set(pinCode: pinCode)
            updateToken(withRefreshToken: refreshToken)
        }
    }

    private func checkForBioAuth() {
        guard keychainStorage.checkIfPinCodeIsSetInKeychain() else { return }
        showSpinner()
        guard let pinCode = keychainStorage.getPinCodeFromKeychain(),
              let refreshToken = keychainStorage.getRefreshTokenFromKeychain(withPin: pinCode) else {
            hideSpinner()
            return
        }
        keychainStorage.set(pinCode: pinCode)
        updateToken(withRefreshToken: refreshToken)
    }

    private func tryBiometryAuth(completion: @escaping (Bool) -> Void) {
        #if targetEnvironment(simulator)
        completion(false)
        return
        #else
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            if let laError = error as? LAError,
               laError.code == .biometryNotEnrolled {
                showError("Биометрия на этом устройстве не доступна")
            }
            completion(false)
            return
        }
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Используйте отпечаток пальца для входа в приложение") { success, evalError in
            guard success else {
                if let evalError = evalError as? LAError {
                    switch evalError.code {
                    case .userCancel:
                        completion(false)
                    default:
                        completion(false)
                    }
                }
                return
            }
            completion(true)
        }
        #endif
    }

    private func updateToken(withRefreshToken refreshToken: String) {
        authService.refreshToken(
            withToken: refreshToken,
            completion: { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async { [unowned self] in
                        self.successAuth()
                    }
                case .failure(_):
                    self.authFailed()
                }
            }
        )
    }

}
