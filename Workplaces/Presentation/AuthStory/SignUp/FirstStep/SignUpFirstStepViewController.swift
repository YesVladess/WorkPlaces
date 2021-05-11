//
//  SignUpFirstStepViewController.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import UIKit

protocol SignUpFirstStepViewControllerDelegate: class {
    func alreadySignedIn()
}

class SignUpFirstStepViewController: UIViewController {

    weak var delegate: SignUpFirstStepViewControllerDelegate?

    // MARK: - IBOutlet

    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - IBAction

    @IBAction private func tapAlreadySignedUpButton(_ sender: Any) {
        remove()
        delegate?.alreadySignedIn()
    }

    func getData() -> (String, String, String)? {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let nickname = nicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
        return (email, password, nickname)
    }

}
