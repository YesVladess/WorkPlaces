//
//  SeparatorView.swift
//  Workplaces
//
//  Created by YesVladess on 19.05.2021.
//

import UIKit

public final class SeparatorView: UIView {

    override public var intrinsicContentSize: CGSize {
        let height: CGFloat = 1.0 / UIScreen.main.scale
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }

}
