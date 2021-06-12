//
//  AuthorizationIntegrationTests.swift
//  WorkplacesTests
//
//  Created by YesVladess on 05.05.2021.
//

import Apexy
import Foundation
@testable import Workplaces
@testable import WorkplacesAPI
import XCTest

class AuthorizationIntegrationTests: XCTestCase {

    let commonTimeout = 5.0

    var authService: AutorizationService!
    var tokenStorage: AccessTokenStorage!
    var apiClient: Client!

    override func setUpWithError() throws {
        try super.setUpWithError()
        tokenStorage = AccessTokenStorage()
        tokenStorage.set(accessToken: nil)
        apiClient = {
            let clientRequestInterceptor = ClientRequestInterceptor(baseURL: URL(string: Config.baseUrl)!)
            return AlamofireClient(
                requestInterceptor: clientRequestInterceptor,
                configuration: .ephemeral,
                responseObserver: { _, _, _, _ in
                })
        }()
        authService = AutorizationService(apiClient: apiClient, tokenStorage: tokenStorage)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        tokenStorage = nil
        authService = nil
    }

    func testPositiveSignIn() {

        let email = "vladess444@yandex.ru"
        let password = "Mypass12"
        let exp = expectation(description: "Successfull sign in")

        authService.signIn(email: email, password: password,
                           completion: { [weak self] result in
                            switch result {
                            case .success:
                                exp.fulfill()
                                let token = self?.tokenStorage.accessToken
                                XCTAssertNotNil(token)
                            case.failure(let error):
                                XCTFail("Couldn't sign in! Error - \(error.localizedDescription)")
                            }
                           })
        wait(for: [exp], timeout: commonTimeout)
    }

    func testSignInWithError() {

        let email = "vladess444@yandex.ru"
        let password = "Mypass12!"
        let exp = expectation(description: "Successfull sign in")

        authService.signIn(email: email, password: password,
                           completion: { [weak self] result in
                            switch result {
                            case .success:
                                XCTFail("Did sign in with bad creds!")
                            case.failure(let error):
                                exp.fulfill()
                                let token = self?.tokenStorage.accessToken
                                XCTAssertNil(token)
                                XCTAssertEqual(error.localizedDescription, "Unknowned error", "Wrong Error!")
                            }
                           })
        wait(for: [exp], timeout: commonTimeout)
    }
}
