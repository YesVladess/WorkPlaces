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

}
