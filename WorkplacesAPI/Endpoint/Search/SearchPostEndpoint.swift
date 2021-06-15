//
//  SearchPostEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 15.06.2021.
//

import Apexy
import Foundation

public struct SearchPostEndpoint: JsonEndpoint {

    public typealias Content = [Post]

    public let searchString: String

    public init(searchString: String) {
        self.searchString = searchString
    }

    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "search")!
        let urlQueryItem = URLQueryItem(name: "post", value: searchString)
        return get(url, queryItems: [urlQueryItem])
    }

}
