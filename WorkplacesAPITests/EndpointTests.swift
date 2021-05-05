//
//  workplacesAPITests.swift
//  workplacesAPITests
//
//  Created by YesVladess on 27.04.2021.
//

@testable import WorkplacesAPI
import XCTest

class EndpointTests: XCTestCase {

    func testSetLikeEndpoint() throws {
        let endpoint = SetLikeEndpoint(likeID: "someTestID")
        let urlRequest = try endpoint.makeRequest()

        Asserts.assertPOST(urlRequest)
        Asserts.assertNoBody(urlRequest)
        Asserts.assertURL(urlRequest, "feed/someTestID/like")
    }

    func testAddPostEndpoint() throws {
        let makePost = MakePost(text: "test", imageUrl: URL(string: "test")!, lon: 1.0, lat: 1.0)
        let endpoint = AddPostEndpoint(makePost: makePost)
        let urlRequest = try endpoint.makeRequest()

        Asserts.assertPOST(urlRequest)
        Asserts.assertBody(urlRequest)
        Asserts.assertURL(urlRequest, "auth/registration")
    }

}
