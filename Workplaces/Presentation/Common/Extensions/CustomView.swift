//
//  CustomView.swift
//  workplaces
//
//  Created by YesVladess on 24.04.2021.
//

import UIKit

class CustomView: UIView, XibLoadable {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = CustomView.loadFromXib()
        setupView(view: view)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view = CustomView.loadFromXib()
        setupView(view: view)
    }

}
