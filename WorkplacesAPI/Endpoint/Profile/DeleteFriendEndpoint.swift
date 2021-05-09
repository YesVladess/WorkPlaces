//
//  DeleteFriendEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct DeleteFriendEndpoint: EmptyEndpoint {

    public init(userID: String) {
        self.userID = userID
    }

    public let userID: String

    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "me/friends/")!.appendingPathComponent(userID)
        return delete(url)
    }

}
