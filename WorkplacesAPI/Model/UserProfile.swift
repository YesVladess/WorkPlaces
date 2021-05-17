//
//  UserProfile.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct UserProfile: Codable, Identifiable {

    public let id: String
    public let firstName: String
    public let lastName: String
    public let nickname: String?
    public let avatarUrl: URL?
    public let birthDay: Date

}

public struct UserProfileWithoutID: Codable {

    public init(
        firstName: String,
        lastName: String,
        nickname: String?,
        avatarUrl: URL?,
        birthDay: String
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.nickname = nickname
        self.avatarUrl = avatarUrl
        self.birthDay = birthDay
    }

    public let firstName: String
    public let lastName: String
    public let nickname: String?
    public let avatarUrl: URL?
    public let birthDay: String

}
