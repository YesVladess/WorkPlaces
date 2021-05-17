//
//  FeedServiceProtocol.swift
//  workplaces
//
//  Created by YesVladess on 25.04.2021.
//

import Foundation
import WorkplacesAPI

protocol FeedServiceProtocol: AnyObject {

    func getFeed(completion: @escaping (Result<[Post], WorkplaceError>) -> Void)

    func getFavoriteFeed(completion: @escaping (Result<[Post], WorkplaceError>) -> Void)

    func setLike(
        likeID: String,
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
    )
    
    func deleteLike(
        likeID: String,
        completion: @escaping (Result<Void, WorkplaceError>) -> Void
    )

}
