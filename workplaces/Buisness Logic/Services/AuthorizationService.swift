//
//  AuthorizationService.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import FBSDKLoginKit
import GoogleSignIn
import VK_ios_sdk

class AutorizationService: AutorizationServiceProtocol {

    func signIn(withCredentials: Credentials, completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        return completion(.success(()))
        // return completion(.failure(.credentialsError))
    }

    func singUp(
        withCredentials: Credentials,
        andUser: Profile,
        completion: @escaping (Result<Void, WorkspaceError>)
            -> Void) {
        return completion(.success(()))
        // return completion(.failure(.credentialsError))
    }

    func signInWithFacebook(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        LoginManager().logIn(permissions: ["email"], from: nil) { result, error in
            if let error = error {
                completion(.failure(.serverError(error)))
            } else if let result = result {
                if result.grantedPermissions.contains("email") {
                    completion(.success(()))
                } else {
                    completion(.failure(.permissionsError))
                }
            }
        }
    }

    func signInWithVK(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {

    }

    func signInWithGoogle(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {

    }

    func logout() {

    }

    var isUserAuthorized: Bool { false }

}
