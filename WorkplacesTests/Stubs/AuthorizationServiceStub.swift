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
    func signIn(email: String, password: String, completion: @escaping (Result<String, WorkplaceError>) -> Void) {
            if error != nil {
                completion(.failure(.unknowned))
            } else {
                completion(.success(("")))
            }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<String, WorkplaceError>) -> Void) {

    }

    func refreshToken(withToken refreshToken: String, completion: @escaping (Result<Void, WorkplaceError>) -> Void) {
    }

    var token: WorkplacesAPI.Token = Token(accessToken: "TestAccessToken", refreshToken: "TestRefreshToken")
    var error: WorkplaceError?

    func signInWithFacebook(completion: @escaping (Result<Void, WorkplaceError>) -> Void) {

    }

    func signInWithVK(vkUIDelegate: VKSdkUIDelegate, completion: @escaping (Result<Void, WorkplaceError>) -> Void) {

    }

    func signInWithGoogle(
        presentingViewController viewController: UIViewController,
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
    ) {

    }

    func logout() {

    }

    weak var vkUIDelegate: VKSdkUIDelegate?

}
