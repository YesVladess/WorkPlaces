//
//  ClientStub.swift
//  WorkplacesTests
//
//  Created by YesVladess on 05.05.2021.
//

import Foundation
@testable import VK_ios_sdk
@testable import Workplaces
@testable import WorkplacesAPI

class AuthorizationServiceStub: AutorizationServiceProtocol {

    var token: Token = Token(refreshToken: "TestRefreshToken", accessToken: "TestAccessToken")
    var error: WorkspaceError?

    func signIn(email: String, password: String, completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        if error != nil {
            completion(.failure(.unknowned))
        } else {
            completion(.success(()))
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<Void, WorkspaceError>) -> Void) {

    }

    func signInWithFacebook(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {

    }

    func signInWithVK(vkUIDelegate: VKSdkUIDelegate, completion: @escaping (Result<Void, WorkspaceError>) -> Void) {

    }

    func signInWithGoogle(
        presentingViewController viewController: UIViewController,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    ) {

    }

    func logout() {

    }

    func refreshToken(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        
    }

    var isUserAuthorized: Bool = true

    weak var vkUIDelegate: VKSdkUIDelegate?

}
