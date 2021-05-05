//
//  GetFeedEndpoint.swift
//  workplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct GetFeedEndpoint: JsonEndpoint {

    public init() {}
    
    public typealias Content = [Post]

    public func makeRequest() throws -> URLRequest {
        get(URL(string: "feed")!)
    }

}
