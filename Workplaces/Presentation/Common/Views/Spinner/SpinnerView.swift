//
//  SpinnerView.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

// Задел на кастомный лоадер
final public class SpinnerView: UIActivityIndicatorView {

    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        backgroundColor = .white
        alpha = 0.7
        layer.cornerRadius = 6
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
