//
//  GetProfileEndpoint.swift
//  workplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct GetProfileEndpoint: JsonEndpoint {

    public init() {}

    public typealias Content = UserProfile

    public func makeRequest() throws -> URLRequest {
        get(URL(string: "me")!)
    }

}
