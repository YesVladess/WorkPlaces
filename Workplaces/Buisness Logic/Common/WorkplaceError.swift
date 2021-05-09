//
//  WorkspaceError.swift
//  workplaces
//
//  Created by YesVladess on 25.04.2021.
//

import Foundation
import WorkplacesAPI

public enum WorkplaceError: Error {
    case apiError(APIError)
    case otherServerError(Error)
    case permissionsError
    case unknowned
}

extension WorkplaceError: LocalizedError {

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

extension WorkplaceError: Equatable {

    public static func == (lhs: WorkplaceError, rhs: WorkplaceError) -> Bool {
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

public extension Error {
    /// Метод нужен для того чтобы достать ошибку валидации из Alamofire
    func unwrapAFError() -> Error {
        guard let afError = asAFError else { return self }
        if case .responseValidationFailed(let reason) = afError,
           case .customValidationFailed(let underlyingError) = reason {
            return underlyingError
        }
        return self
    }
}
