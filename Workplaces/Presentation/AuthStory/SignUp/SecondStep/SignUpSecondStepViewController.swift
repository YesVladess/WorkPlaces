//
//  SignUpSecondStepViewController.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import UIKit

protocol SignUpSecondStepViewControllerDelegate: class {
    func nextstep()
}

class SignUpSecondStepViewController: UIViewController {

    weak var delegate: SignUpSecondStepViewControllerDelegate?
    
    // MARK: - Private Properties

    private let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBOutlet

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var dataBirthTextField: UITextField!

    // MARK: - IBAction

    @IBAction private func tapBirthDateField(_ sender: Any) {
        showDatePicker()
    }

    // MARK: - Private Methods

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

    func getData() -> (String, String, String)? {
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let surname = surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let date = dataBirthTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return nil }
        return (name, surname, date)
    }

}
