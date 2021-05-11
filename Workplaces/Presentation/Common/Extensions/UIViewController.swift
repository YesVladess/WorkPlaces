//
//  UIViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

protocol ErrorDisplayable {
    func showError(_ message: String)
}

extension ErrorDisplayable where Self: UIViewController {

    func showError(_ message: String) {
        let alertController = UIAlertController(
            title: "Ups".localized,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Got that".localized, style: .cancel))
        view.subviews.first(where: { $0.tag == 1 })?.isHidden = true
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController: ErrorDisplayable {}

extension UIViewController {

    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    func get<T>(child: T) -> T? {
        return self.children.compactMap({ ($0 as? T) }).first
    }

    func transition(
        to child: UIViewController,
        fullScreen: Bool = false,
        completion: ((Bool) -> Void)? = nil
    ) {
        let duration = 0.4

        let current = children.last
        addChild(child)

        let newView = child.view!
        newView.translatesAutoresizingMaskIntoConstraints = true
        newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if fullScreen { newView.frame = view.bounds }

        if let existing = current {
            existing.willMove(toParent: nil)

            transition(
                from: existing,
                to: child,
                duration: duration,
                options: [.transitionCrossDissolve],
                animations: { },
                completion: { done in
                    existing.removeFromParent()
                    child.didMove(toParent: self)
                    completion?(done)
                }
            )

        } else {
            view.addSubview(newView)

            UIView.animate(
                withDuration: duration,
                delay: 0,
                options: [.transitionCrossDissolve],
                animations: { },
                completion: { done in
                    child.didMove(toParent: self)
                    completion?(done)
                }
            )
        }
    }

}
