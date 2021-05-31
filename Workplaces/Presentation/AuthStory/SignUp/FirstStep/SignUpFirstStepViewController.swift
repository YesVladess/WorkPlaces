//
//  SignUpFirstStepViewController.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import UIKit

protocol SignUpFirstStepNavigationDelegate: AnyObject {
    func alreadySignedUpTapped()
    func firstStepPrimaryButtonTapped()
}

class SignUpFirstStepViewController: UIViewController, CanShowKeyboard {

    // MARK: - Public Properties

    weak var navigationDelegate: SignUpFirstStepNavigationDelegate?

    // MARK: - IBOutlet

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var primaryButton: PrimaryButton!
    @IBOutlet internal var buttonsBottomConstraint: NSLayoutConstraint!

    // MARK: - IBAction

    @IBAction private func tapAlreadySignedUpButton(_ sender: Any) {
         navigationDelegate?.alreadySignedUpTapped()
    }

    @IBAction private func textFieldDidChange(_ sender: UITextField) {
        validatePrimaryButton()
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapOutside()
        configureTextFields()
        configurePrimaryButton()
        configureObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeObservers()
    }

    // MARK: - Public Methods
    
    /**
     Method for getting data from fields at 1st step

     - returns: return tuple with email and pass

     */
    func getData() -> (email: String, password: String)? {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return nil }
        return (email, password)
    }

    // MARK: - Configure

    private func configureTapOutside() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func configureTextFields() {
        emailTextField.tintColor = .black
        emailTextField.tintColorDidChange()
        passwordTextField.tintColor = .black
        passwordTextField.tintColorDidChange()
    }

    private func configurePrimaryButton() {
        primaryButton.setTitle("Next".localized)
        primaryButton.isEnabled = false
        primaryButton.onTap = { [weak self] in
            self?.navigationDelegate?.firstStepPrimaryButtonTapped()
        }
    }

    private func validatePrimaryButton() {
        if let emailText = emailTextField.text,
           let passText = passwordTextField.text,
           !emailText.isEmpty,
           !passText.isEmpty {
            primaryButton.isEnabled = true
        } else {
            primaryButton.isEnabled = false
        }
    }

    // MARK: - Objc

    @objc private func tapOutside(gesture: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

}
