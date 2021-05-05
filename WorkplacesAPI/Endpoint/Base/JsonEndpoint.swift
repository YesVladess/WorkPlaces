//
//  JsonEndpoint.swift
//  workplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Apexy

/// Base Endpoint for application remote resource.
///
/// Contains shared logic for all endpoints in app.
protocol JsonEndpoint: Endpoint, URLRequestBuildable where Content: Decodable {}

extension JsonEndpoint {

    /// Request body encoder.
    internal var encoder: JSONEncoder { return JSONEncoder.default }

    public func validate(_ request: URLRequest?, response: HTTPURLResponse, data: Data?) throws {
        try ResponseValidator.validate(response, with: data ?? Data())
    }

    public func content(from response: URLResponse?, with body: Data) throws -> Content {
        let decoder = JSONDecoder.default
        return try decoder.decode(Content.self, from: body)
    }
}
