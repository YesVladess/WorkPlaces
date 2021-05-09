//
//  TokenStorage.swift
//  workplaces
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation
import WorkplacesAPI

protocol TokenStorageProtocol: AnyObject {
    func set(token value: Token?)
    func get() -> Token?
}

final class TokenStorage: TokenStorageProtocol {

    private let storage = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let accessTokenKeyString = "AccessToken"
    private let refreshTokenKeyString = "RefreshToken"

    func set(token value: Token?) {
        if let token = value {
            storage.set(token.accessToken, forKey: accessTokenKeyString)
            storage.set(token.refreshToken, forKey: refreshTokenKeyString)
        } else {
            storage.removeObject(forKey: accessTokenKeyString)
            storage.removeObject(forKey: refreshTokenKeyString)
        }
    }

    func get() -> Token? {
        guard let refreshToken = storage.object(forKey: refreshTokenKeyString) as? String else { return nil }
        guard let accessToken = storage.object(forKey: accessTokenKeyString) as? String else { return nil }
        return Token(accessToken: accessToken, refreshToken: refreshToken)
    }

}
