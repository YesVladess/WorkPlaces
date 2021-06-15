//
//  SearchService.swift
//  Workplaces
//
//  Created by YesVladess on 14.06.2021.
//

import Foundation
import WorkplacesAPI

final class SearchService: ApiService, SearchServiceProtocol {

    // MARK: - Public methods

    func searchFriends(
        searchString: String,
        completion: @escaping (Result<[UserProfile], WorkplaceError>) -> Void
    ) {
        let endpoint = SearchUserEndpoint(searchString: searchString)
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success(let resultData):
                let profiles = resultData.compactMap { ModelMapper.convertUserProfileToAppModelFrom(model: $0) }
                completion(.success((profiles)))
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

    func searchPosts(
        searchString: String,
        completion: @escaping (Result<[Post], WorkplaceError>) -> Void
    ) {
        let endpoint = SearchPostEndpoint(searchString: searchString)
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success(let resultData):
                let posts = resultData.compactMap { ModelMapper.convertPostToAppModelFrom(model: $0) }
                completion(.success((posts)))
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

}
