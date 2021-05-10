//
//  ChangeProfileEndpoint.swift
//  workplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

public struct ChangeProfileEndpoint: JsonEndpoint {

    public typealias Content = UserProfile

    public init(userProfileWithoutID: UserProfileWithoutID) {
        self.userProfileWithoutID = userProfileWithoutID
    }

    public let userProfileWithoutID: UserProfileWithoutID

    public func makeRequest() throws -> URLRequest {
        return patch(URL(string: "me")!, body: .multipart(try encoder.encode(userProfileWithoutID)))
    }

}
