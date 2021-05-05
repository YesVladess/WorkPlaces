//
//  XibLoadable.swift
//  workplaces
//
//  Created by YesVladess on 24.04.2021.
//

import UIKit

public protocol XibLoadable {

    static func loadFromXib() -> CustomViewType
    associatedtype CustomViewType

}

extension XibLoadable where Self: UIView {

    static func loadFromXib() -> UIView {
        let bundle = Bundle(for: Self.self)
        let nib = UINib(nibName: String(describing: Self.self), bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            preconditionFailure("Couldn't load xib for view: \(self)")
        }
        return nibView
    }

    func setupView(view: UIView) {
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }

}
