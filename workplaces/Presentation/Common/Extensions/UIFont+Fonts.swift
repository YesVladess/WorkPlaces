//
//  UIFont+Fonts.swift
//  workplaces
//
//  Created by YesVladess on 19.04.2021.
//

import UIKit

// MARK: - AppFonts

private extension UIFont {

    struct DesignSystemFonts {
        static let title: DesignSystemFontType = (size: 36, weight: .regular)
        static let subTitle: DesignSystemFontType = (size: 22, weight: .regular)
        static let bodyLarge: DesignSystemFontType = (size: 17, weight: .regular)
        static let bodySmall: DesignSystemFontType = (size: 17, weight: .regular)
    }

}

extension UIFont {

    public static var title: UIFont {
        .monospacedFont(ofSize: DesignSystemFonts.title.size, weight: DesignSystemFonts.title.weight)
    }

    public static var subTitle: UIFont {
        .monospacedFont(ofSize: DesignSystemFonts.subTitle.size, weight: DesignSystemFonts.subTitle.weight)
    }

    public static var bodyLarge: UIFont {
        .monospacedFont(ofSize: DesignSystemFonts.bodyLarge.size, weight: DesignSystemFonts.bodyLarge.weight)
    }

    public static var bodySmall: UIFont {
        .monospacedFont(ofSize: DesignSystemFonts.bodySmall.size, weight: DesignSystemFonts.bodySmall.weight)
    }

}

// MARK: - Private methods

private extension UIFont {

    typealias DesignSystemFontType = (size: CGFloat, weight: UIFont.Weight)

    class func monospacedFont(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        guard let font = UIFont(name: "IBMPlexSans-Regular", size: size) else {
           return UIFont.monospacedSystemFont(ofSize: size, weight: weight)
        }
        return font.withSize(size)

    }

}

