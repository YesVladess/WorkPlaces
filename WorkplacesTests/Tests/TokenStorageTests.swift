//
//  TokenStorageTests.swift
//  WorkplacesTests
//
//  Created by YesVladess on 09.05.2021.
//

@testable import Workplaces
import XCTest

class TokenStorageTests: XCTestCase {

    var tokenStorage: AccessTokenStorage!

    override func setUpWithError() throws {
        try super.setUpWithError()
        tokenStorage = AccessTokenStorage()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        tokenStorage = nil
    }

}
