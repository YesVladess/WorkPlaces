//
//  Post.swift
//  workplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct Post: Codable, Identifiable {

    public let id: String

    public let text: String

    public let imageUrl: URL

    public let lon: Double

    public let lat: Double

    public let author: UserProfile

    public let likes: Int

}

public struct MakePost: Codable {

    public init(text: String, imageUrl: URL, lon: Double, lat: Double) {
        self.text = text
        self.imageUrl = imageUrl
        self.lon = lon
        self.lat = lat
    }

    let text: String

    let imageUrl: URL

    let lon: Double

    let lat: Double

}
