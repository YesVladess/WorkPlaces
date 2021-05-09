//
//  SetLikeEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by YesVladess on 09.05.2021.
//

@testable import WorkplacesAPI
import XCTest

class SetLikeEndpointTests: XCTestCase {

    func testSetLikeEndpoint() throws {
        let endpoint = SetLikeEndpoint(likeID: "someTestID")
        let urlRequest = try endpoint.makeRequest()

        Asserts.assertPOST(urlRequest)
        Asserts.assertNoBody(urlRequest)
        Asserts.assertURL(urlRequest, "feed/someTestID/like")
    }

}
