//
//  ResponseValidator.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 27.04.2021.
//

import Foundation

private struct ResponseError: Decodable {
    let error: APIError
}

/// Response validation helper.
internal enum ResponseValidator {

    /// Error response validation.
    ///
    /// - Parameters:
    ///   - response: The metadata associated with the response.
    ///   - body: The response body.
    /// - Throws: `APIError`.
    internal static func validate(_ response: URLResponse?, with body: Data) throws {
        try validateAPIResponse(response, with: body)
        try validateHTTPstatus(response)
    }

    private static func validateAPIResponse(_ response: URLResponse?, with body: Data) throws {
        let decoder = JSONDecoder.default
        if let error = try? decoder.decode(APIError.self, from: body) {
            throw error
        }
    }

    private static func validateHTTPstatus(_ response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse,
            !(200..<300).contains(httpResponse.statusCode) else { return }

        throw HTTPError(statusCode: httpResponse.statusCode, url: httpResponse.url)
    }
}
