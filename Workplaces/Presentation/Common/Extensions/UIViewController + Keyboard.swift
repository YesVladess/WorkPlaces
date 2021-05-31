//
//  UIViewController + Keyboard.swift
//  Workplaces
//
//  Created by YesVladess on 26.05.2021.
//

import Foundation
import UIKit

public protocol CanShowKeyboard {

    func configureObservers()
    func removeObservers()
    var buttonsBottomConstraint: NSLayoutConstraint! { get }

}

extension CanShowKeyboard where Self: UIViewController {
    
    func configureObservers() {
        var keyboardShown = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: nil,
            using: { [weak self] notification in
                guard self == self else {
                    NotificationCenter.default.removeObserver(keyboardShown)
                    return
                }
                self?.keyboardNotification((notification as NSNotification) as Notification)
            }
        )
    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }

    private func keyboardNotification(_ notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo,
              let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        if endFrame.origin.y >= UIScreen.main.bounds.size.height {
            buttonsBottomConstraint.constant = 0.0
        } else {
            let height = endFrame.height + 0.0
            buttonsBottomConstraint.constant = height
        }
        UIView.animate(withDuration: 0.33,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { self.view.layoutIfNeeded() })
    }

}
