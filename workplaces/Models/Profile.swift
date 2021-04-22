//
//  Profile.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Foundation

class Profile {

    var name: String
    var surname: String
    var age: Int
    var location: String
    var email: String

    init( _ name: String, _ surname: String, _ age: Int, _ location: String, _ email: String) {
        self.name = name
        self.surname = surname
        self.age = age
        self.location = location
        self.email = email
    }
}
