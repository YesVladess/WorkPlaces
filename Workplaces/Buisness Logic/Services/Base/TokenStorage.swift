//
//  TokenStorage.swift
//  workplaces
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation
import WorkplacesAPI

protocol TokenStorageProtocol: AnyObject {
    var token: Atomic<Token>? { get set }
    func set(token value: Token?)
}

final class TokenStorage: TokenStorageProtocol {

    private let storage = UserDefaults.standard
    private let accessTokenKeyString = "AccessToken"
    private let refreshTokenKeyString = "RefreshToken"
    
    public var token: Atomic<Token>? {
        get {
            if let refreshToken = storage.object(forKey: refreshTokenKeyString) as? String,
               let accessToken = storage.object(forKey: accessTokenKeyString) as? String {
                let token = Atomic(wrappedValue: Token(accessToken: accessToken, refreshToken: refreshToken))
                return token
            } else { return nil }
        }
        set {}
    }

    func set(token value: Token?) {
        if let token = value {
            self.token?.mutate { _ in
                storage.set(token.accessToken, forKey: accessTokenKeyString)
                storage.set(token.refreshToken, forKey: refreshTokenKeyString)
            }
        } else {
            storage.removeObject(forKey: accessTokenKeyString)
            storage.removeObject(forKey: refreshTokenKeyString)
        }

    }

}
