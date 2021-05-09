//
//  FeedService.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Foundation
import WorkplacesAPI

final class FeedService: ApiService, FeedServiceProtocol {

    // MARK: - Public methods
    
    func getFeed(completion: @escaping (Result<[Post], WorkplaceError>) -> Void) {
        let endpoint = GetFeedEndpoint()
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success(let resultData):
                let posts = resultData.compactMap { ModelMapper.convertPostToAppModelFrom(model: $0) }
                completion(.success((posts)))
            case .failure(let error):
                if let error = error as? APIError {
                    completion(.failure(.apiError(error)))
                } else {
                    completion(.failure(.unknowned))
                }
            }
        }
    }

    func getFavoriteFeed(completion: @escaping (Result<[Post], WorkplaceError>) -> Void) {
        let endpoint = GetFavoriteEndpoint()
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success(let resultData):
                let posts = resultData.compactMap { ModelMapper.convertPostToAppModelFrom(model: $0) }
                completion(.success((posts)))
            case .failure(let error):
                if let error = error as? APIError {
                    completion(.failure(.apiError(error)))
                } else {
                    completion(.failure(.unknowned))
                }
            }
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
