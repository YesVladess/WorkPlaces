//
//  LogoutEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct LogoutEndpoint: EmptyEndpoint {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }

    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/logout")!, body: .json(try JSONEncoder.default.encode(token.refreshToken)))
    }

}
