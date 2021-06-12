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

    var tokenStorage: AccessTokenStorage!
    var authService: AuthorizationServiceStub!
    let commonTimeout = 5.0

    override func setUpWithError() throws {
        try super.setUpWithError()
        tokenStorage = AccessTokenStorage()
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
        let exp = expectation(description: "Successfull sign in")

        // TODO: Сейчас ничего не тестируется, так как запускаются методы тестового двойника
        authService.signIn(email: email, password: password,
                           completion: { result in
                            switch result {
                            case .success:
                                exp.fulfill()
                            case.failure:
                                exp.fulfill()
                                XCTFail("Authorization failed")
                            }
                           })
        wait(for: [exp], timeout: commonTimeout)
    }

    func testAuthSignInWithError() {
        let email = "vls4@yandex.ru"
        let password = "Mypass12"
        authService.error = .unknowned

        // TODO: А тут я что проверяю, если это тестовый двойник?
        // Тип ошибки и текст ошибки лучше проверять в разных тестах
        // Для UserDefaults не нужно создавать моков. Достаточно создавать экземпляры тестовые - стабы. Либо как рассказывал на лекции выделять протоколы
        authService.signIn(email: email, password: password,
                           completion: { result in
                            switch result {
                            case .success:
                                XCTFail("Authorization didn't fail")
                            case.failure(let error):
                                XCTAssertEqual(error, WorkplaceError.unknowned, "Wrong WorkspaceError type!")
                            }
                           })
    }

}
