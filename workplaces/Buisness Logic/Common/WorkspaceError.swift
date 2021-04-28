//
//  WorkspaceError.swift
//  workplaces
//
//  Created by YesVladess on 25.04.2021.
//

import Foundation

public enum WorkspaceError: Error {
    case serverError(Error)
    case credentialsError
    case unknowned
    case permissionsError
}

extension WorkspaceError: LocalizedError {

    var localizedDescription: String {
        switch self {
        case .serverError(let error):
            return String(format: "Server error occured".localized, arguments: [error.localizedDescription])
        case .credentialsError:
            return "Check username and password".localized
        case .unknowned:
            return "Unknowned error".localized
        case .permissionsError:
            return "Please give permissions".localized
        }
    }
}
