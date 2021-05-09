//
//  Token.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct Token: Codable {

    public init(refreshToken: String, accessToken: String) {
        self.refreshToken = refreshToken
        self.accessToken = accessToken
    }

    public let accessToken: String

    public let refreshToken: String

}

public struct RefreshToken: Codable {

    public init(token: String) {
        self.token = token
    }

    public let token: String

}
