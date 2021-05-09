//
//  SetLikeEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by YesVladess on 09.05.2021.
//

@testable import WorkplacesAPI
import XCTest

class SetLikeEndpointTests: EndpointTests {

    func testSetLikeEndpoint() throws {
        let endpoint = SetLikeEndpoint(likeID: "someTestID")
        let urlRequest = try endpoint.makeRequest()

        assertPOST(urlRequest)
        assertNoBody(urlRequest)
        assertURL(urlRequest, "feed/someTestID/like")
    }

}
