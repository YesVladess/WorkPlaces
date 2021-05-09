//
//  ModelMapper.swift
//  Workplaces
//
//  Created by YesVladess on 09.05.2021.
//

import Foundation
import WorkplacesAPI

class ModelMapper {

    static func convertUserCredentialsToApiModelFrom(model: UserCredentials) -> WorkplacesAPI.UserCredentials {
        return WorkplacesAPI.UserCredentials(
            email: model.email,
            password: model.password
        )
    }

    static func convertTokenToAppModelFrom(model: WorkplacesAPI.Token) -> Token {
        return Token(accessToken: model.accessToken, refreshToken: model.refreshToken)
    }

    static func convertTokenToApiModelFrom(model: Token) -> WorkplacesAPI.Token {
        return WorkplacesAPI.Token(accessToken: model.accessToken, refreshToken: model.refreshToken)
    }

    static func convertPostToAppModelFrom(model: WorkplacesAPI.Post) -> Post {
        return Post(
            id: model.id,
            text: model.text,
            imageUrl: model.imageUrl,
            lon: model.lon,
            lat: model.lat,
            author: UserProfile(
                id: model.author.id,
                firstName: model.author.firstName,
                lastName: model.author.lastName,
                nickname: model.author.nickname,
                avatarUrl: model.author.avatarUrl,
                birthDay: model.author.birthDay
            ),
            likes: model.likes,
            liked: model.liked
        )
    }

    static func convertUserProfileToAppModelFrom(model: WorkplacesAPI.UserProfile) -> UserProfile {
        return UserProfile(
            id: model.id,
            firstName: model.firstName,
            lastName: model.lastName,
            nickname: model.nickname,
            avatarUrl: model.avatarUrl,
            birthDay: model.birthDay
        )
    }
    
}
