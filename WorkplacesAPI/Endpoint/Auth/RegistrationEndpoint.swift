//
//  RegistrationEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct RegistrationEndpoint: JsonEndpoint {

    public typealias Content = Token

    public let userCredentials: UserCredentials

    public init(userCredentials: UserCredentials) {
        self.userCredentials = userCredentials
    }

    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/registration")!, body: .json(try encoder.encode(userCredentials)))
    }

}
