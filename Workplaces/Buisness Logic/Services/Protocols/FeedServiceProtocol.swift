//
//  FeedServiceProtocol.swift
//  workplaces
//
//  Created by YesVladess on 25.04.2021.
//

import Foundation
import WorkplacesAPI

protocol FeedServiceProtocol: AnyObject {

    func getFeed(completion: @escaping (Result<[Post], WorkspaceError>) -> Void)

    func getFavoriteFeed(completion: @escaping (Result<[Post], WorkspaceError>) -> Void)

    func setLike(
        likeID: String,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    )
    
    func deleteLike(
        likeID: String,
        completion: @escaping (Result<Void, WorkspaceError>) -> Void
    )

}
