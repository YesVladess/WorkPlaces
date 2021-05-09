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

    /**
     Method used to authorize user with given credentials

     - parameter email: User email. example: admin@server.com
     - parameter password: Password. minLength: 8
     - parameter completion: Method result containing either success or failture result with WorkplaceError

     */
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
    )

    func signUp(
        email: String,
        password: String,
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
    )

    func signInWithFacebook(completion: @escaping (Result<Void, WorkplaceError>) -> Void)

    func signInWithVK(vkUIDelegate: VKSdkUIDelegate, completion: @escaping (Result<Void, WorkplaceError>) -> Void)

    func signInWithGoogle(
        presentingViewController viewController: UIViewController,
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
    )

    func logout()

    func refreshToken(completion: @escaping (Result<Void, WorkplaceError>) -> Void)

    var isUserAuthorized: Bool { get }

    var vkUIDelegate: VKSdkUIDelegate? { get }

}
