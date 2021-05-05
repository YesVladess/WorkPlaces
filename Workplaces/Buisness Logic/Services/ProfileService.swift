//
//  ProfileService.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Apexy
import Foundation
import WorkplacesAPI

final class ProfileService: ApiService, ProfileServiceProtocol {

    func getMyProfile(completion: @escaping (Result<UserProfile, WorkspaceError>) -> Void) {
        let endpoint = GetProfileEndpoint()
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func changeMyProfile(
        profile: UserProfileWithoutID,
        completion: @escaping (Result<UserProfile, WorkspaceError>) -> Void
    ) {
        let endpoint = ChangeProfileEndpoint(userProfileWithoutID: profile)
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func getFriends(completion: @escaping (Result<[UserProfile], WorkspaceError>) -> Void) {
        let endpoint = GetFriendsEndpoint()
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func addFriend(userID: String, completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        let endpoint = AddFriendEndpoint(userID: userID)
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func deleteFriend(userID: String, completion: @escaping (Result<Void, WorkspaceError>) -> Void) {
        let endpoint = DeleteFriendEndpoint(userID: userID)
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func getMyPosts(completion: @escaping (Result<[Post], WorkspaceError>) -> Void) {
        let endpoint = GetMyPostsEndpoint()
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

    func addPost(post: MakePost, completion: @escaping (Result<Post, WorkspaceError>) -> Void) {
        let endpoint = AddPostEndpoint(makePost: post)
        _ = apiClient.request(endpoint) { [weak self] result in
            self?.commonResultHandler(result: result, completion: completion)
        }
    }

}
