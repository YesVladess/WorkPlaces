//
//  ProfileService.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Foundation
import WorkplacesAPI

final class ProfileService: ApiService, ProfileServiceProtocol {

    // MARK: - Public methods
    
    func getMyProfile(completion: @escaping (Result<UserProfile, WorkplaceError>) -> Void) {
        let endpoint = GetProfileEndpoint()
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success(let resultData):
                let profile = ModelMapper.convertUserProfileToAppModelFrom(model: resultData)
                completion(.success((profile)))
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

    func changeMyProfile(
        firstName: String,
        lastName: String,
        nickname: String?,
        avatarUrl: URL?,
        birthDay: String,
        completion: @escaping (Result<UserProfile, WorkplaceError>) -> Void
    ) {
        let profile = UserProfileWithoutID(
            firstName: firstName,
            lastName: lastName,
            nickname: nickname,
            avatarUrl: nil,
            birthDay: birthDay
        )
        let endpoint = ChangeProfileEndpoint(userProfileWithoutID: profile)
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success(let resultData):
                let profile = ModelMapper.convertUserProfileToAppModelFrom(model: resultData)
                completion(.success((profile)))
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

    func getFriends(completion: @escaping (Result<[UserProfile], WorkplaceError>) -> Void) {
        let endpoint = GetFriendsEndpoint()
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

    func addFriend(userID: String, completion: @escaping (Result<Void, WorkplaceError>) -> Void) {
        let endpoint = AddFriendEndpoint(userID: userID)
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func deleteFriend(userID: String, completion: @escaping (Result<Void, WorkplaceError>) -> Void) {
        let endpoint = DeleteFriendEndpoint(userID: userID)
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func getMyPosts(completion: @escaping (Result<[Post], WorkplaceError>) -> Void) {
        let endpoint = GetMyPostsEndpoint()
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

    func addPost(post: MakePost, completion: @escaping (Result<Post, WorkplaceError>) -> Void) {
        let endpoint = AddPostEndpoint(makePost: post)
        _ = apiClient.request(endpoint) { result in
            switch result {
            case .success(let resultData):
                let post = ModelMapper.convertPostToAppModelFrom(model: resultData)
                completion(.success((post)))
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
