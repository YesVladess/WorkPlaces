//
//  AutorizationServiceProtocol.swift
//  workplaces
//
//  Created by YesVladess on 25.04.2021.
//

import FBSDKLoginKit
import GoogleSignIn
import VK_ios_sdk
import WorkplacesAPI

protocol AutorizationServiceProtocol: AnyObject {

    func signIn(
        withCredentials: UserCredentials,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    )

    func singUp(
        withCredentials: UserCredentials,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    )

    func signInWithFacebook(completion: @escaping (Result<Void, WorkspaceError>) -> Void)

    func signInWithVK(vkUIDelegate: VKSdkUIDelegate, completion: @escaping (Result<Void, WorkspaceError>) -> Void)

    func signInWithGoogle(
        presentingViewController viewController: UIViewController,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    )

    func logout()

    func refreshToken(completion: @escaping (Result<Void, WorkspaceError>) -> Void)

    var isUserAuthorized: Bool { get }

    var vkUIDelegate: VKSdkUIDelegate? { get }

}
