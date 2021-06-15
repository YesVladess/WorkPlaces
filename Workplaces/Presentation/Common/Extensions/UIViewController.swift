//
//  UIViewController.swift
//  Workplaces
//
//  Created by YesVladess on 15.06.2021.
//

import UIKit

extension UIViewController {

    func removeZeroScreenIfPresent() {
        if isViewControllerPresentAsChild(viewControllerType: ZeroScreenViewController.self) {
            if let zeroViewController = get(child: ZeroScreenViewController.self) {
                remove(child: zeroViewController)
            }
        }
    }

}
