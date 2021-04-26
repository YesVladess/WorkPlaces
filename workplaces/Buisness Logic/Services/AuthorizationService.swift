//
//  AuthorizationService.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import FBSDKLoginKit
import GoogleSignIn
import VK_ios_sdk

class AutorizationService: NSObject, AutorizationServiceProtocol {

    // MARK: - Private vars

    private var googleAuthHandler: ((Result<Void, WorkspaceError>) -> Void)?

    func signIn(withCredentials: Credentials, completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        return completion(.success(()))
        // return completion(.failure(.credentialsError))
    }

    func singUp(
        withCredentials: Credentials,
        andUser: Profile,
        completion: @escaping (Result<Void, WorkspaceError>
        ) -> Void) {
        return completion(.success(()))
        // return completion(.failure(.credentialsError))
    }

    func signInWithFacebook(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        Settings.appID = Config.facebookAppID
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

    func signInWithGoogle(
        presentingViewController viewController: UIViewController,
        completion: @escaping (Result<Void, WorkspaceError>)
            -> Void
    ) {
        setupGoogleSignIn(presentingViewController: viewController)
        googleAuthHandler = { result in
            completion(result)
        }
    }

    func logout() {

    }

    var isUserAuthorized: Bool { false }

    weak var vkUIDelegate: VKSdkUIDelegate?

    // MARK: - Private methods

    private func setupGoogleSignIn(presentingViewController viewController: UIViewController) {
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
        GIDSignIn.sharedInstance()?.clientID = Config.googleClientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }

}

extension AutorizationService: GIDSignInDelegate {

    func sign(
        _ signIn: GIDSignIn!,
        didSignInFor user: GIDGoogleUser!,
        withError error: Error!
    ) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                let result: (Result<Void, WorkspaceError>) = .failure(.serverError(error))
                googleAuthHandler?(result)
            }
            return
        } else {
            let result: (Result<Void, WorkspaceError>) = .success(())
            googleAuthHandler?(result)
        }
        // Perform any operations on signed in user here.
        //      let userId = user.userID                  // For client-side use only!
        //      let idToken = user.authentication.idToken // Safe to send to the server
        //      let fullName = user.profile.name
        //      let givenName = user.profile.givenName
        //      let familyName = user.profile.familyName
        //      let email = user.profile.email
    }

    func sign(
        _ signIn: GIDSignIn!,
        didDisconnectWith user: GIDGoogleUser!,
        withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
}
