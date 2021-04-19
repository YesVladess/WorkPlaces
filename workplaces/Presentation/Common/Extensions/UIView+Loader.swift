//
//  UIView+Loader.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

extension UIView {

    func showLoader() {
        let loader = ActivityLoader(frame: frame)
        self.addSubview(loader)
    }

    func removeLoader() {
        if let loader = subviews.first(where: { $0 is ActivityLoader }) {
            loader.removeFromSuperview()
        }
    }

}
