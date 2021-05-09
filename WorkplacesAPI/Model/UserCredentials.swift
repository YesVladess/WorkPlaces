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

    // example: admin@server.com
    public let email: String

    // pattern: ^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])[a-zA-Z0-9]{8,}$
    // example: QqxhNuvvqaoNFRhF6ZcgAJ6r43x2hm
    // minLength: 8
    public let password: String

}
