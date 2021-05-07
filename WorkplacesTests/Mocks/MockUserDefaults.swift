//
//  MockUserDefaults.swift
//  WorkplacesTests
//
//  Created by YesVladess on 05.05.2021.
//

import Foundation
@testable import Workplaces
@testable import WorkplacesAPI

class MockUserDefaults: UserDefaults {

    var token: Token?
    var changeCount = 0

  override func set(_ value: Int, forKey defaultName: String) {
    token = Token(refreshToken: "TestRefreshToken", accessToken: "TestAccessToken")
    changeCount += 1
  }

}
