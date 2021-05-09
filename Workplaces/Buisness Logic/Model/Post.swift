//
//  Post.swift
//  Workplaces
//
//  Created by YesVladess on 09.05.2021.
//

import Foundation

public struct Post: Identifiable {

    public let id: String
    let text: String?
    let imageUrl: URL?
    let lon: Double?
    let lat: Double?
    let author: UserProfile
    let likes: Int
    let liked: Bool

}
