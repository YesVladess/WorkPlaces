//
//  CanShowSpinner.swift
//  workplaces
//
//  Created by YesVladess on 24.04.2021.
//

import UIKit

public protocol CanShowSpinner {

    func showSpinner()
    func hideSpinner()
    var spinner: SpinnerView { get }

}

extension CanShowSpinner where Self: UIViewController {

    func showSpinner() {
        spinner.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        spinner.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(spinner)
        view.alpha = 0.8
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
    }

    func hideSpinner() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.removeFromSuperview()
            self.view.alpha = 1.0
            self.view.isUserInteractionEnabled = true
        }
    }

}
