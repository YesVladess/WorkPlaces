//
//  SignUpFirstStepViewController.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import UIKit

class SignUpFirstStepViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapOutside()
        configureTextFields()
    }

    // MARK: - Objc
    
    @objc func tapOutside(gesture: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        nicknameTextField.resignFirstResponder()
    }

    // MARK: - Public Methods
    
    /**
     Method for getting data from fields at 1st step

     - returns: return tuple with email, pass and nickname

     */
    func getData() -> (email: String, password: String, nickname: String)? {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let nickname = nicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
        return (email, password, nickname)
    }

    // MARK: - Configure

    private func configureTapOutside() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func configureTextFields() {
        emailTextField.tintColor = .orange
        emailTextField.tintColorDidChange()
        passwordTextField.tintColor = .orange
        passwordTextField.tintColorDidChange()
        nicknameTextField.tintColor = .orange
        nicknameTextField.tintColorDidChange()
    }

}
