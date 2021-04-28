//
//  ProfileService.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Foundation

class ProfileService: ProfileServiceProtocol {
    
    func getProfileInfo() -> Profile {

        return Profile(name: "", surname: "", age: 0, location: "", email: "")
    }

}
