//
//  ClientInterceptor.swift
//  Workplaces
//
//  Created by YesVladess on 27.04.2021.
//

import Alamofire

final public class ClientRequestInterceptor: Alamofire.RequestInterceptor {

    /// Contains Base `URL`.
    ///
    /// Must end with a slash character `https://example.com/api/v1/`
    ///
    /// - Warning: declared as open variable for debug purposes only.
    public var baseURL: URL

    /// Creates a `BaseRequestInterceptor` instance with specified Base `URL`.
    ///
    /// - Parameter baseURL: Base `URL` for adapter.
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    // MARK: - Alamofire.RequestInterceptor

    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        guard let url = urlRequest.url else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = urlRequest
        let tokenStorage = TokenStorage()
        if let token = tokenStorage.get() {
            request.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }

        request.url = appendingBaseURL(to: url)

        completion(.success(request))
    }

    public func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        return completion(.doNotRetry)
    }

    // MARK: - Private

    private func appendingBaseURL(to url: URL) -> URL {
        URL(string: url.absoluteString, relativeTo: baseURL)!
    }

}
