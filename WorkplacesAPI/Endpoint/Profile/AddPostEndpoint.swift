//
//  AddPostEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct AddPostEndpoint: JsonEndpoint {

    public typealias Content = Post

    public let makePost: MakePost

    public init(makePost: MakePost) {
        self.makePost = makePost
    }

    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/registration")!, body: .json(try encoder.encode(makePost)))
    }

}
