//
//  WorkspaceError.swift
//  workplaces
//
//  Created by YesVladess on 25.04.2021.
//

import Foundation
import WorkplacesAPI

public enum WorkspaceError: Error {
    case apiError(APIError)
    case unknowned
    case permissionsError
    case otherServerError(Error)
}

extension WorkspaceError: LocalizedError {

    var localizedDescription: String {
        switch self {
        case .apiError(let apiError):
            return apiError.description ?? "Unknowned error".localized
        case .unknowned:
            return "Unknowned error".localized
        case .permissionsError:
            return "Please give permissions".localized
        case .otherServerError(let error):
            return String(format: "Server error occured".localized, arguments: [error.localizedDescription])
        }
    }
}

extension WorkspaceError: Equatable {

    public static func == (lhs: WorkspaceError, rhs: WorkspaceError) -> Bool {
        switch (lhs, rhs) {
        case (.apiError, .apiError),
             (.otherServerError, .otherServerError),
             (.permissionsError, .permissionsError),
             (.unknowned, .unknowned):
            return true
        case _:
            return false
        }
    }

}
