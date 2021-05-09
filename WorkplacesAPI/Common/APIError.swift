//
//  APIError.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

/// Error from API.
public struct APIError: Decodable, Error {

    public struct Code: RawRepresentable, Decodable, Equatable {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }

    /// Error code.
    public let code: Code

    /// Error description.
    public let description: String?

    public init(
        code: Code,
        description: String? = nil) {

        self.code = code
        self.description = description
    }

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case description = "message"
    }
}

// MARK: - General Error Code
extension APIError.Code {

    public static let tokenInvalid = APIError.Code("INVALID_TOKEN")
    public static let invalidCredentials = APIError.Code("INVALID_CREDENTIALS")
    public static let emailValidation = APIError.Code("EMAIL_VALIDATION_ERROR")
    public static let passwordValidation = APIError.Code("PASSWORD_VALIDATION_ERROR")
    public static let duplicateUser = APIError.Code("DUPLICATE_USER_ERROR")
    public static let serialization = APIError.Code("SERIALIZATION_ERROR")
    public static let fileNotFound = APIError.Code("FILE_NOT_FOUND_ERROR")
    public static let tooBigFile = APIError.Code("TOO_BIG_FILE_ERROR")
    public static let badFileExstention = APIError.Code("BAD_FILE_EXTENSION_ERROR")

    public static let generic = APIError.Code("GENERIC_ERROR")
    public static let unnkown = APIError.Code("UNKNOWN_ERROR")

}
