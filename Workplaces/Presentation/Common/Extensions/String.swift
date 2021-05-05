//
//  String.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

extension String {

    private func attributes(font: UIFont, color: UIColor?) -> [NSAttributedString.Key: Any] {
        return [
            .font: font,
            .foregroundColor: color ?? .black
        ]
    }

    func addAttributes(font: UIFont, color: UIColor?) -> NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: attributes(font: font, color: color))
    }

}
