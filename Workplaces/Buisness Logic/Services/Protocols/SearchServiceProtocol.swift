//
//  SearchServiceProtocol.swift
//  Workplaces
//
//  Created by YesVladess on 14.06.2021.
//

import Foundation
import WorkplacesAPI

protocol SearchServiceProtocol: AnyObject {

    func searchFriends(searchString: String,
                       completion: @escaping (Result<[UserProfile], WorkplaceError>) -> Void
    )

    func searchPosts(searchString: String,
                     completion: @escaping (Result<[Post], WorkplaceError>) -> Void
    )

}
