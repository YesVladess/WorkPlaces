//
//  TokenStorage.swift
//  workplaces
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation
import WorkplacesAPI

protocol AccessTokenStorageProtocol: AnyObject {
    var accessToken: Atomic<String>? { get set }
    func set(accessToken value: String?)
}

final class AccessTokenStorage: AccessTokenStorageProtocol {
    
    var accessToken: Atomic<String>?
    
    func set(accessToken value: String?) {
        if let accessTokenValue = value {
            accessToken = Atomic(wrappedValue: "")
            accessToken!.mutate { value in value = accessTokenValue }
        } else {
            accessToken = nil
        }
    }
    
}
