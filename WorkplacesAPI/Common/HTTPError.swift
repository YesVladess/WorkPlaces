//
//  HTTPError.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct HTTPError: Error {
    let statusCode: Int
    let url: URL?

    var localizedDescription: String {
        return HTTPURLResponse.localizedString(forStatusCode: statusCode)
    }
}

// MARK: - CustomNSError
extension HTTPError: CustomNSError {
    public static var errorDomain = "Example.HTTPErrorDomain"

    public var errorCode: Int { return statusCode }

    public var errorUserInfo: [String: Any] {
        var userInfo: [String: Any] = [NSLocalizedDescriptionKey: localizedDescription]
        userInfo[NSURLErrorKey] = url
        return userInfo
    }
}
