//
//  ServiceLayer.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Foundation

final class ServiceLayer {

    private init() {}

    static let shared = ServiceLayer()

    lazy var authorizationService: AutorizationServiceProtocol = { AutorizationService() }()
    lazy var feedService: FeedServiceProtocol = { FeedService() }()
    lazy var profileService: ProfileServiceProtocol = { ProfileService() }()

}
