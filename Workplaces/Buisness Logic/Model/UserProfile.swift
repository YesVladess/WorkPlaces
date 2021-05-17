//
//  UserProfile.swift
//  Workplaces
//
//  Created by YesVladess on 09.05.2021.
//

import Foundation

struct UserProfile: Identifiable {

    public let id: String
    let firstName: String
    let lastName: String
    let nickname: String?
    let avatarUrl: URL?
    let birthDay: Date

}

struct UserProfileWithoutID {

    let firstName: String
    let lastName: String
    let nickname: String?
    let avatarUrl: URL?
    let birthDay: String

}
