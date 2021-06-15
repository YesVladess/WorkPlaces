//
//  ServiceLayer.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Apexy
import Foundation
import WorkplacesAPI

final class ServiceLayer {

    private init() {}

    static let shared = ServiceLayer()

    private(set) lazy var apiClient: Client = {
        let clientRequestInterceptor = ClientRequestInterceptor(
            baseURL: URL(string: Config.baseUrl)!,
            accessTokenStorage: accessTokenStorage
        )
        return AlamofireClient(
            requestInterceptor: clientRequestInterceptor,
            configuration: .ephemeral,
            responseObserver: { [weak self] _, _, _, error in
                self?.validateSession(responseError: error)
            })
    }()

    private func validateSession(responseError: Error?) {
        if let error = responseError as? APIError, error.code == .tokenInvalid {
            authorizationService.logout()
            // TODO: Выкинуть на экран логина
        }
    }

    // MARK: - Storages

    private(set) lazy var accessTokenStorage: AccessTokenStorageProtocol = AccessTokenStorage()

    private(set) lazy var keychainStorage: KeychainStorageProtocol = KeychainStorage()

    // MARK: - Services

    private(set) lazy var authorizationService: AutorizationServiceProtocol = AutorizationService(
        apiClient: apiClient,
        accessTokenStorage: accessTokenStorage,
        keychainStorage: keychainStorage
    )

    private(set) lazy var feedService: FeedServiceProtocol = FeedService(apiClient: apiClient)

    private(set) lazy var profileService: ProfileServiceProtocol = ProfileService(apiClient: apiClient)

    private(set) lazy var searchService: SearchServiceProtocol = SearchService(apiClient: apiClient)

}
