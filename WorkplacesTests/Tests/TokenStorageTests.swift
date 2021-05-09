//
//  TokenStorageTests.swift
//  WorkplacesTests
//
//  Created by YesVladess on 09.05.2021.
//

// TODO: Не должно импортироваться сразу два модуля для теста. Должно быть что-то одно
@testable import Workplaces
@testable import WorkplacesAPI
import XCTest

class TokenStorageTests: XCTestCase {

    var tokenStorage: TokenStorage!

    override func setUpWithError() throws {
        try super.setUpWithError()
        tokenStorage = TokenStorage()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        tokenStorage = nil
    }

    // TODO: Но вообще этот тест бесполезный, т.к. ты в нем тестируешь UserDefaults.standart.
    // Он у тебя уже не пустой будет если ты раз зашел с того же симулятора и авторизовался
    func testTokenStorage() throws {
        let token = Token(refreshToken: "testRefreshToken", accessToken: "testAccessToken")

        tokenStorage.set(token: token)
        let receviedToken = tokenStorage.get()

        XCTAssertEqual(token.accessToken, receviedToken?.accessToken, "Access Token doesn't match!")
        XCTAssertEqual(token.refreshToken, receviedToken?.refreshToken, "Refresh Token doesn't match!")
    }

}
