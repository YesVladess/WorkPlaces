//
//  AutorizationServiceProtocol.swift
//  workplaces
//
//  Created by YesVladess on 25.04.2021.
//

import FBSDKLoginKit
import GoogleSignIn
import VK_ios_sdk

protocol AutorizationServiceProtocol: class {

    func signIn(
        withCredentials: Credentials,
        completion: @escaping (Result<Void, WorkspaceError>)
            -> Void)

    func singUp(
        withCredentials: Credentials,
        andUser: Profile,
        completion: @escaping (Result<Void, WorkspaceError>)
            -> Void)

    func signInWithFacebook(completion: @escaping (Result<Void, WorkspaceError>) -> Void)

    func signInWithVK(completion: @escaping (Result<Void, WorkspaceError>) -> Void)

    func signInWithGoogle(
        presentingViewController viewController: UIViewController,
        completion: @escaping (Result<Void, WorkspaceError>)
            -> Void)

    func logout()

    var isUserAuthorized: Bool { get }

}
