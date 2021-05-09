//
//  GetMyPostsEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct GetMyPostsEndpoint: JsonEndpoint {

    public init() {}

    public typealias Content = [Post]

    public func makeRequest() throws -> URLRequest {
        get(URL(string: "me/posts")!)
    }

}
