//
//  Token.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct Token: Codable {

    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
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
