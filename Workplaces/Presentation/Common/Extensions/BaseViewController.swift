//
//  UIViewController + Keyboard.swift
//  Workplaces
//
//  Created by YesVladess on 26.05.2021.
//

import Foundation
import UIKit

public protocol CanShowKeyboard {
    func updateKeyboardConstraints()
}

class BaseViewController: UIViewController, CanShowKeyboard {

    // MARK: - Public Properites

    var buttonsBottomConstraintConstant: CGFloat = 0

    // MARK: - Public Methods

    func updateKeyboardConstraints() {}

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }

    @objc
    dynamic func keyboardWillShow(
        _ notification: NSNotification
    ) {
        animateWithKeyboard(notification: notification) { keyboardFrame in
            let constant = -30 + keyboardFrame.height
            self.buttonsBottomConstraintConstant = constant
            self.updateKeyboardConstraints()
        }
    }

    @objc
    dynamic func keyboardWillHide(
        _ notification: NSNotification
    ) {
        animateWithKeyboard(notification: notification) { _ in
            self.buttonsBottomConstraintConstant = 0
            self.updateKeyboardConstraints()
        }
    }

}

extension BaseViewController {

    func animateWithKeyboard(
        notification: NSNotification,
        animations: ((_ keyboardFrame: CGRect) -> Void)?
    ) {
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        guard let duration = notification.userInfo![durationKey] as? Double,
              let keyboardFrameValue = notification.userInfo![frameKey] as? NSValue,
              let curveValue = notification.userInfo![curveKey] as? Int,
              let curve = UIView.AnimationCurve(rawValue: curveValue)
        else { return }
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: curve
        ) {
            animations?(keyboardFrameValue.cgRectValue)
            self.view?.layoutIfNeeded()
        }
        animator.startAnimation()
    }

}
