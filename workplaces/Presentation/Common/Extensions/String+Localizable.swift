//
//  String+Localizable.swift
//  workplaces
//
//  Created by YesVladess on 19.04.2021.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, tableName: nil, value: "", comment: "")
    }

    static func localized(_ format: String, _ arguments: CVarArg...) -> String {
        return String(format: format.localized, locale: Locale.current, arguments: arguments)
    }

}
