//
//  AuthorizationService.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Apexy
import FBSDKLoginKit
import GoogleSignIn
import VK_ios_sdk
import WorkplacesAPI

final class AutorizationService: NSObject, AutorizationServiceProtocol {

    // MARK: - Public vars

    var isUserAuthorized: Bool { false }

    weak var vkUIDelegate: VKSdkUIDelegate?

    // MARK: - Private vars

    private let apiClient: Client

    private var googleAuthHandler: ((Result<Void, WorkspaceError>) -> Void)?

    private let tokenStorage: TokenStorageProtocol

    // MARK: - Initializers

    init(apiClient: Client, tokenStorage: TokenStorageProtocol) {
        self.tokenStorage = tokenStorage
        self.apiClient = apiClient
    }

    // MARK: - Public methods

    func signIn(
        withCredentials: UserCredentials,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    ) {
        let endpoint = LoginEndpoint(userCredentials: withCredentials)
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success(let token):
                self.tokenStorage.set(token: token)
                completion(.success(()))
            case .failure(let error):
                if let error = error as? APIError {
                    completion(.failure(.apiError(error)))
                } else {
                    completion(.failure(.unknowned))
                }
            }
        }
    }

    func singUp(
        withCredentials: UserCredentials,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    ) {
        let endpoint = RegistrationEndpoint(userCredentials: withCredentials)
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success(let token):
                self.tokenStorage.set(token: token)
                completion(.success(()))
            case .failure(let error):
                if let error = error as? APIError {
                    completion(.failure(.apiError(error)))
                } else {
                    completion(.failure(.unknowned))
                }
            }
        }
    }

    func logout() {
        guard let token = tokenStorage.get() else { return }
        let endpoint = LogoutEndpoint(token: token)
        _ = apiClient.request(endpoint) { [weak self] result in
            switch result {
            case .success:
                self?.tokenStorage.set(token: nil)
            case .failure:
                return
            }
        }
    }

    func refreshToken(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        guard let token = tokenStorage.get() else { return }
        let refreshToken = RefreshToken(token: token.refreshToken)
        let endpoint = RefreshEndpoint(token: refreshToken)
        _ = apiClient.request(endpoint) { [weak self] result in
            switch result {
            case .success(let token):
                self?.tokenStorage.set(token: token)
            case .failure(let error):
                if let error = error as? APIError {
                    completion(.failure(.apiError(error)))
                } else {
                    completion(.failure(.unknowned))
                }
                self?.logout()
            }
        }
    }

    func signInWithFacebook(completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        Settings.appID = Config.facebookAppID
        LoginManager().logIn(permissions: ["email"], from: nil) { result, error in
            if let error = error {
                completion(.failure(.otherServerError(error)))
            } else if let result = result {
                if result.grantedPermissions.contains("email") {
                    completion(.success(()))
                } else {
                    completion(.failure(.permissionsError))
                }
            }
        }
    }

    func signInWithVK(
        vkUIDelegate: VKSdkUIDelegate,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    ) {
        setupVKSignIn(vkUIDelegate: vkUIDelegate)
        let scope = ["email"]
        VKSdk.wakeUpSession(scope) { state, error in
            if state == .authorized {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(.otherServerError(error)))
            } else {
                VKSdk.authorize(scope)
            }
        }
    }

    func signInWithGoogle(
        presentingViewController viewController: UIViewController,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    ) {
        setupGoogleSignIn(presentingViewController: viewController)
        googleAuthHandler = { result in
            completion(result)
        }
    }

    // MARK: - Private methods

    private func setupGoogleSignIn(presentingViewController viewController: UIViewController) {
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
        GIDSignIn.sharedInstance()?.clientID = Config.googleClientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }

    private func setupVKSignIn(vkUIDelegate: VKSdkUIDelegate) {
        let sdk = VKSdk.initialize(withAppId: Config.vkAppID)
        self.vkUIDelegate = vkUIDelegate
        sdk?.uiDelegate = self.vkUIDelegate
        sdk?.register(self)
    }

}

extension AutorizationService: GIDSignInDelegate {

    func sign(
        _ signIn: GIDSignIn!,
        didSignInFor user: GIDGoogleUser!,
        withError error: Error!
    ) {
        if let error = error {
            let result: (Result<Void, WorkspaceError>) = .failure(.otherServerError(error))
            googleAuthHandler?(result)
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
        withError error: Error!
    ) {
        // Perform any operations when the user disconnects from app here.
    }
}

extension AutorizationService: VKSdkDelegate {

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        // if let token = result.token {
        // } else if let error = result.error {
        // }
    }

    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult!) {
    }

    func vkSdkUserAuthorizationFailed() {
    }

}
