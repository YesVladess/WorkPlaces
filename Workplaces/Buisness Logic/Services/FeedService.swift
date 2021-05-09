//
//  FeedService.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Foundation
import WorkplacesAPI

final class FeedService: ApiService, FeedServiceProtocol {

    func getFeed(completion: @escaping (Result<[Post], WorkplaceError>) -> Void) {
        let endpoint = GetFeedEndpoint()
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func getFavoriteFeed(completion: @escaping (Result<[Post], WorkplaceError>) -> Void) {
        let endpoint = GetFavoriteEndpoint()
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func setLike(likeID: String, completion: @escaping (Result<Void, WorkplaceError>) -> Void) {
        let endpoint = SetLikeEndpoint(likeID: likeID)
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func deleteLike(likeID: String, completion: @escaping (Result<Void, WorkplaceError>) -> Void) {
        let endpoint = DeleteLikeEndpoint(likeID: likeID)
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

}
