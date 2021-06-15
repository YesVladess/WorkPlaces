//
//  AddFriendEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct AddFriendEndpoint: EmptyEndpoint {

    public init(userID: String) {
        self.userId = userID
    }

    public let userId: String

    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "me/friends")!
        return post(url, body: .json(try JSONEncoder.default.encode(["user_id": userId])))
    }

}
