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
}

extension WorkspaceError: LocalizedError {

    var localizedDescription: String {
        switch self {
        case .serverError(let error):
            return "Server error occured \(error.localizedDescription)"
        case .credentialsError:
            return "Check username and password"
        case .unknowned:
            return "Unknowned"
        }
    }
}
