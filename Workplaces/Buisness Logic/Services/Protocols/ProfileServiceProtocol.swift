//
//  ProfileServiceProtocol.swift
//  workplaces
//
//  Created by YesVladess on 25.04.2021.
//

import Foundation
import WorkplacesAPI

protocol ProfileServiceProtocol: AnyObject {

    func getMyProfile(
        completion: @escaping (Result<UserProfile, WorkplaceError>) -> Void
    )

    func changeMyProfile(
        profile: UserProfileWithoutID,
        completion: @escaping (Result<UserProfile, WorkplaceError>) -> Void
    )

    func getFriends(
        completion: @escaping (Result<[UserProfile], WorkplaceError>) -> Void
    )

    func addFriend(
        userID: String,
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
    )

    func deleteFriend(
        userID: String,
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
    )

    func getMyPosts(completion: @escaping (Result<[Post], WorkplaceError>) -> Void)

    func addPost(
        post: MakePost,
        completion: @escaping (Result<Post, WorkplaceError>) -> Void
        )

}
