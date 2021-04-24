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

    lazy var authorizationService: AutorizationService = { AutorizationService() }()
    lazy var feedService: FeedService = { FeedService() }()
    lazy var profileService: ProfileService = { ProfileService() }()

}
