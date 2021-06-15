//
//  SearchEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Apexy
import Foundation

public struct SearchUserEndpoint: JsonEndpoint {

    public typealias Content = [UserProfile]

    public let searchString: String

    public init(searchString: String) {
        self.searchString = searchString
    }

    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "search")!
        let urlQueryItem = URLQueryItem(name: "user", value: searchString)
        return get(url, queryItems: [urlQueryItem])
    }

}
