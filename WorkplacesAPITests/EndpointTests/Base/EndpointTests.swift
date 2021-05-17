//
//  EndpointTests.swift
//  WorkplacesAPITests
//
//  Created by YesVladess on 05.05.2021.
//

import Foundation
import XCTest

public class EndpointTests: XCTestCase {

    func assertBody(_ urlRequest: URLRequest, file: StaticString = #file, line: UInt = #line) {
        guard let method = urlRequest.httpMethod else {
            return XCTFail("У запроса остутствует HTTP метод", file: file, line: line)
        }
        XCTAssertNotEqual(method, "GET", "GET запрос не должен иметь тела", file: file, line: line)
        XCTAssertNotNil(urlRequest.httpBody)
    }

    func assertNoBody(_ urlRequest: URLRequest, file: StaticString = #file, line: UInt = #line) {
        XCTAssertNil(urlRequest.httpBody)
    }

    func assertGET(_ urlRequest: URLRequest, file: StaticString = #file, line: UInt = #line) {
        guard let method = urlRequest.httpMethod else {
            return XCTFail("У запроса остутствует HTTP метод", file: file, line: line)
        }
        XCTAssertEqual(method, "GET", file: file, line: line)
        XCTAssertNil(urlRequest.httpBody, "GET запрос не должен иметь тела", file: file, line: line)
    }

    func assertPOST(_ urlRequest: URLRequest, file: StaticString = #file, line: UInt = #line) {
        guard let method = urlRequest.httpMethod else {
            return XCTFail("У запроса остутствует HTTP метод", file: file, line: line)
        }
        XCTAssertEqual(method, "POST", file: file, line: line)
    }

    func assertDELETE(_ urlRequest: URLRequest, file: StaticString = #file, line: UInt = #line) {
        guard let method = urlRequest.httpMethod else {
            return XCTFail("У запроса остутствует HTTP метод", file: file, line: line)
        }
        XCTAssertEqual(method, "DELETE", file: file, line: line)
    }

    func assertPATCH(_ urlRequest: URLRequest, file: StaticString = #file, line: UInt = #line) {
        guard let method = urlRequest.httpMethod else {
            return XCTFail("У запроса остутствует HTTP метод", file: file, line: line)
        }
        XCTAssertEqual(method, "PATCH", file: file, line: line)
    }

    func assertPath(_ urlRequest: URLRequest, _ path: String, file: StaticString = #file, line: UInt = #line) {
        guard let url = urlRequest.url else {
            return XCTFail("У запроса остутствует URL", file: file, line: line)
        }
        XCTAssertEqual(url.path, path, "путь запроса не совпадает", file: file, line: line)
    }

    func assertURL(
        _ urlRequest: URLRequest,
        _ urlString: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard let url = urlRequest.url else {
            return XCTFail("У запроса остутствует URL", file: file, line: line)
        }
        XCTAssertEqual(url.absoluteString, urlString, "URL запроса не совпадает", file: file, line: line)
    }

}
