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

    // MARK: - Public properties

    weak var vkUIDelegate: VKSdkUIDelegate?

    // MARK: - Private properties

    private let apiClient: Client
    private var googleAuthHandler: ((Result<Void, WorkplaceError>) -> Void)?
    private let accessTokenStorage: AccessTokenStorageProtocol
    private let keychainStorage: KeychainStorageProtocol

    // MARK: - Initializers

    init(
        apiClient: Client,
        accessTokenStorage: AccessTokenStorageProtocol,
        keychainStorage: KeychainStorageProtocol
    ) {
        self.apiClient = apiClient
        self.accessTokenStorage = accessTokenStorage
        self.keychainStorage = keychainStorage
    }

    // MARK: - Public methods

    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<String, WorkplaceError>) -> Void
    ) {
        let credentials = UserCredentials(email: email, password: password)

        let endpoint = LoginEndpoint(
            userCredentials: ModelMapper.convertUserCredentialsToApiModelFrom(model: credentials)
        )
        _ = apiClient.request(endpoint) { [weak self] result in
            switch result {
            case .success(let token):
                let token = ModelMapper.convertTokenToAppModelFrom(model: token)
                self?.accessTokenStorage.set(accessToken: token.accessToken)
                completion(.success((token.refreshToken)))
            case .failure(let error):
                let errorUnwrapped = error.unwrapAFError()
                if let apiError = errorUnwrapped as? APIError {
                    completion(.failure(.apiError(apiError)))
                } else {
                    completion(.failure(.unknowned))
                }
            }
        }
    }

    func signUp(
        email: String,
        password: String,
        completion: @escaping (Result<String, WorkplaceError>) -> Void
    ) {
        let credentials = UserCredentials(email: email, password: password)
        let endpoint = RegistrationEndpoint(
            userCredentials: ModelMapper.convertUserCredentialsToApiModelFrom(model: credentials)
        )
        _ = apiClient.request(endpoint) { [weak self] result in
            switch result {
            case .success(let token):
                let token = ModelMapper.convertTokenToAppModelFrom(model: token)
                self?.accessTokenStorage.set(accessToken: token.accessToken)
                completion(.success((token.refreshToken)))
            case .failure(let error):
                let errorUnwrapped = error.unwrapAFError()
                if let apiError = errorUnwrapped as? APIError {
                    completion(.failure(.apiError(apiError)))
                } else {
                    completion(.failure(.unknowned))
                }
            }
        }
    }

    func logout() {
        guard let accessToken = accessTokenStorage.accessToken?.value,
              let pinCode = keychainStorage.pinCode?.value,
              let refreshToken = keychainStorage.getRefreshTokenFromKeychain(withPin: pinCode) else { return }
        let token = Token(accessToken: accessToken, refreshToken: refreshToken)
        let endpoint = LogoutEndpoint(token: ModelMapper.convertTokenToApiModelFrom(model: token))
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success:
                return
            case .failure:
                return
            }
        }
    }

    func refreshToken(
        withToken refreshToken: String,
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
    ) {
        let refreshTokenStruct = RefreshToken(token: refreshToken)
        let endpoint = RefreshEndpoint(token: refreshTokenStruct)
        _ = apiClient.request(endpoint) { [weak self] result in
            guard let keychainStorage = self?.keychainStorage else { return }
            switch result {
            case .success(let token):
                let token = ModelMapper.convertTokenToAppModelFrom(model: token)
                self?.accessTokenStorage.set(accessToken: token.accessToken)
                if let pinCode = keychainStorage.pinCode?.value {
                    keychainStorage.saveRefreshTokenToKeychain(
                        withRefreshToken: token.refreshToken,
                        andPin: pinCode
                    )
                    if keychainStorage.checkIfPinCodeIsSetInKeychain() {
                        keychainStorage.savePinToKeychainWithBiometry(pin: pinCode)
                    }
                }
                completion(.success(()))
            case .failure(let error):
                let errorUnwrapped = error.unwrapAFError()
                if let apiError = errorUnwrapped as? APIError {
                    completion(.failure(.apiError(apiError)))
                } else {
                    completion(.failure(.unknowned))
                }
            }
        }
    }

    func signInWithFacebook(completion: @escaping (Result<Void, WorkplaceError>) -> Void) {
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
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
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
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
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

// MARK: - GIDSignInDelegate

extension AutorizationService: GIDSignInDelegate {

    func sign(
        _ signIn: GIDSignIn!,
        didSignInFor user: GIDGoogleUser!,
        withError error: Error!
    ) {
        if let error = error {
            let result: (Result<Void, WorkplaceError>) = .failure(.otherServerError(error))
            googleAuthHandler?(result)
        } else {
            let result: (Result<Void, WorkplaceError>) = .success(())
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

// MARK: - VKSdkDelegate

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
