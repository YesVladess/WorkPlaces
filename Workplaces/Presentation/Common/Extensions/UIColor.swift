//
//  UIColor.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

extension UIColor {

    public static var orange: UIColor {
        UIColor(named: "orange") ?? UIColor.systemOrange
    }

    public static var grey: UIColor {
        UIColor(named: "grey") ?? UIColor.gray
    }

    public static var lightGreyBlue: UIColor {
        UIColor(named: "light_grey_blue") ?? UIColor.gray
    }

    public static var lightGrey: UIColor {
        UIColor(named: "light_grey") ?? UIColor.lightGray
    }

    public static var middleGrey: UIColor {
        UIColor(named: "middle_grey") ?? UIColor.gray
    }

    public static var darkGrey: UIColor {
        UIColor(named: "dark_grey") ?? UIColor.darkGray
    }
}
