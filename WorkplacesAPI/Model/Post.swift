//
//  Post.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

public struct Post: Codable, Identifiable {

    public let id: String
    public let text: String?
    public let imageUrl: URL?
    public let lon: Double?
    public let lat: Double?
    public let author: UserProfile
    public let likes: Int
    public let liked: Bool

}

public struct MakePost: Codable {

    public init(text: String, imageUrl: URL, lon: Double, lat: Double) {
        self.text = text
        self.imageUrl = imageUrl
        self.lon = lon
        self.lat = lat
    }

    public let text: String
    public let imageUrl: URL
    public let lon: Double
    public let lat: Double

}
