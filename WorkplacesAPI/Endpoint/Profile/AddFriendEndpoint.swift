//
//  AddFriendEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct AddFriendEndpoint: EmptyEndpoint {

    public init(userID: String) {
        self.userID = userID
    }

    public let userID: String

    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "me/friends")!
        return post(url, body: .json(try JSONEncoder.default.encode(userID)))
    }

}
