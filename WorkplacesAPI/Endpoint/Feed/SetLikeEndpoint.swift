//
//  SetLikeEndpoint.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct SetLikeEndpoint: EmptyEndpoint {

    public init(likeID: String) {
        self.likeID = likeID
    }
    
    public let likeID: String

    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "feed/")!.appendingPathComponent(likeID).appendingPathComponent("/like")
        return post(url, body: nil)
    }

}
