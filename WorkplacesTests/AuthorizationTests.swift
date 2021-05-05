//
//  workplacesTests.swift
//  workplacesTests
//
//  Created by YesVladess on 18.04.2021.
//

@testable import Workplaces
@testable import WorkplacesAPI
import XCTest

class AuthorizationTests: XCTestCase {

    var tokenStorage: TokenStorage!
    var authService: AuthorizationServiceStub!

    override func setUpWithError() throws {
        try super.setUpWithError()
        tokenStorage = TokenStorage()
        authService = AuthorizationServiceStub()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        tokenStorage = nil
        authService = nil
    }

    func testAuthSignInPositive() {
        let email = "vladess444@yandex.ru"
        let password = "Mypass12"

        authService.signIn(email: email, password: password,
                           completion: { result in
                            switch result {
                            case .success:
                                print("Success")
                            case.failure( _):
                                XCTFail("Authorization failed")
                            }
                           })
    }

    func testAuthSignInError() {
        let email = "vls4@yandex.ru"
        let password = "Mypass12"
        authService.error = .unknowned

        authService.signIn(email: email, password: password,
                           completion: { result in
                            switch result {
                            case .success:
                                XCTFail("Authorization didn't fail")
                            case.failure(let error):
                                XCTAssertEqual(
                                    error.localizedDescription,
                                    "Unknowned error",
                                    "Wrong error desc!"
                                )
                            }
                           })
    }

    func testTokenStorage() throws {
        let token = Token(refreshToken: "testRefreshToken", accessToken: "testAccessToken")

        tokenStorage.set(token: token)
        let receviedToken = tokenStorage.get()

        XCTAssertNotNil(receviedToken?.accessToken)
        XCTAssertNotNil(receviedToken?.refreshToken)
        XCTAssertEqual(token.accessToken, receviedToken?.accessToken, "Access Token doesn't match!")
        XCTAssertEqual(token.refreshToken, receviedToken?.refreshToken, "Refresh Token doesn't match!")
    }

}
