//
//  SignUpSecondStepViewController.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import UIKit

protocol SignUpSecondStepNavigationDelegate: AnyObject {
    func secondStepPrimaryButtonTapped()
}

class SignUpSecondStepViewController: BaseViewController {
    
    // MARK: - Private Properties

    private let datePicker = UIDatePicker()

    // MARK: - Public Properties

    weak var navigationDelegate: SignUpSecondStepNavigationDelegate?

    // MARK: - IBOutlet

    @IBOutlet private var buttonsBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var primaryButton: PrimaryButton!
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var dateBirthTextField: UITextField!

    override func updateKeyboardConstraints() {
        buttonsBottomConstraint.constant = buttonsBottomConstraintConstant
    }

    // MARK: - IBAction

    @IBAction private func tapBirthDateField(_ sender: Any) {
        showDatePicker()
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
    }

    // MARK: - Public Methods

    /**
     Method for getting data from fields at 2nd step

     - returns: return tuple with nickname, name, surname and date

     */
    func getData() -> (nickname: String, name: String, surname: String, date: String)? {
        guard let nickname = nicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let surname = surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let date = dateBirthTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return nil }
        return (nickname, name, surname, date)
    }

    /**
     Method shows error shake animation on child text fields.
     Fields are moving from left to right and back several times
     */
    func showErrorAnimation() {
        errorShakeAnimationFor(view: nameTextField)
        errorShakeAnimationFor(view: surnameTextField)
        errorShakeAnimationFor(view: dateBirthTextField)
    }
    // MARK: - Configure

    private func configureTapOutside() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func configureTextFields() {
        nicknameTextField.tintColor = .black
        nicknameTextField.tintColorDidChange()
        nameTextField.tintColor = .black
        nameTextField.tintColorDidChange()
        surnameTextField.tintColor = .black
        surnameTextField.tintColorDidChange()
        dateBirthTextField.tintColor = .black
        dateBirthTextField.tintColorDidChange()
    }

    private func configurePrimaryButton() {
        primaryButton.setTitle("Sign Up".localized)
        primaryButton.isEnabled = false
        primaryButton.onTap = { [weak self] in
            self?.navigationDelegate?.secondStepPrimaryButtonTapped()
        }
    }

    private func validatePrimaryButton() {
        if let nicknameText = nicknameTextField.text,
           let nameText = nameTextField.text,
           let surnameText = surnameTextField.text,
           let dateBirthText = dateBirthTextField.text,
           !nicknameText.isEmpty,
           !nameText.isEmpty,
           !surnameText.isEmpty,
           !dateBirthText.isEmpty {
            primaryButton.isEnabled = true
        } else {
            primaryButton.isEnabled = false
        }
    }

    // MARK: - DatePicker

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
        dateBirthTextField.inputAccessoryView = toolbar
        dateBirthTextField.inputView = datePicker
    }

    @objc private func dateChosen() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateBirthTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    // MARK: - ErrorAnimation

    private func errorShakeAnimationFor(view: UIView) {
        let rotation = CAKeyframeAnimation(keyPath: "position.x")
        rotation.duration = 0.4
        rotation.isAdditive = true
        rotation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        rotation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        view.layer.add(rotation, forKey: "moveIt")
    }

    // MARK: - Objc

    @objc func tapOutside(gesture: UITapGestureRecognizer) {
        nicknameTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        dateBirthTextField.resignFirstResponder()
    }

}
