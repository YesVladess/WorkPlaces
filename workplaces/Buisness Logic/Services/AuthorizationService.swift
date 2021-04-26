//
//  AuthorizationService.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Foundation

class AutorizationService: AutorizationServiceProtocol {

    func signIn(withCredentials: Credentials, completion: @escaping (Result<Void, WorkspaceError>) -> Void) {

    }

    func singUp(
        withCredentials: Credentials,
        andUser: Profile,
        completion: @escaping (Result<Void, WorkspaceError>)
            -> Void) {

    }

    func signInWithFacebook(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {

    }

    func signInWithVK(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {

    }

    func signInWithGoogle(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {

    }

    func logout() {

    }

    var isUserAuthorized: Bool { false }

}
