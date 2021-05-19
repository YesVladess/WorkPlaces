//
//  SignUpSecondStepViewController.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import UIKit

class SignUpSecondStepViewController: UIViewController {
    
    // MARK: - Private Properties

    private let datePicker = UIDatePicker()

    // MARK: - IBOutlet

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var dataBirthTextField: UITextField!

    // MARK: - IBAction

    @IBAction private func tapBirthDateField(_ sender: Any) {
        showDatePicker()
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapOutside()
    }

    // MARK: - Objc

    @objc func tapOutside(gesture: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        dataBirthTextField.resignFirstResponder()
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

    private func configureTapOutside() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func errorShakeAnimationFor(view: UIView) {
        let rotation = CAKeyframeAnimation(keyPath: "position.x")
        rotation.duration = 0.4
        rotation.isAdditive = true
        rotation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        rotation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        view.layer.add(rotation, forKey: "moveIt")
    }

    // MARK: - Public Methods

    /**
     Method for getting data from fields at 2nd step

     - returns: return tuple with name, surname and date

     */
    func getData() -> (name: String, surname: String, date: String)? {
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let surname = surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let date = dataBirthTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return nil }
        return (name, surname, date)
    }

    /**
     Method shows error shake animation on child text fields.
     Fields are moving from left to right and back several times
     */
    func showErrorAnimation() {
        errorShakeAnimationFor(view: nameTextField)
        errorShakeAnimationFor(view: surnameTextField)
        errorShakeAnimationFor(view: dataBirthTextField)
    }

}
