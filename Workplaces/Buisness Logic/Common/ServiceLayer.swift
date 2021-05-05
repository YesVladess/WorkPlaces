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
        let clientRequestInterceptor = ClientRequestInterceptor(baseURL: URL(string: Config.baseUrl)!)
        return AlamofireClient(
            requestInterceptor: clientRequestInterceptor,
            configuration: .ephemeral,
            responseObserver: { [weak self] _, _, _, error in
                self?.validateSession(responseError: error)
            })
    }()

    private(set) lazy var authorizationService: AutorizationServiceProtocol = AutorizationService(
        apiClient: apiClient,
        tokenStorage: TokenStorage()
    )

    private(set) lazy var feedService: FeedServiceProtocol = FeedService(apiClient: apiClient)

    private(set) lazy var profileService: ProfileServiceProtocol = ProfileService(apiClient: apiClient)

    // MARK: - Private methods

    private func validateSession(responseError: Error?) {
        if let error = responseError as? APIError, error.code == .tokenInvalid {
            authorizationService.logout()
            // Выкинуть на экран логина
        }
    }

}
