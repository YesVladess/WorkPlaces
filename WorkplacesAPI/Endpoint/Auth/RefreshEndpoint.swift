//
//  RefreshEndpoint.swift
//  workplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct RefreshEndpoint: JsonEndpoint {

    public typealias Content = Token

    public let token: RefreshToken

    public init(token: RefreshToken) {
        self.token = token
    }

    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/refresh")!, body: .json(try encoder.encode(token)))
    }

}
