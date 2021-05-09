//
//  UserCredentials.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 25.04.2021.
//

import Foundation

public struct UserCredentials: Codable {

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    let email: String
    let password: String

}
