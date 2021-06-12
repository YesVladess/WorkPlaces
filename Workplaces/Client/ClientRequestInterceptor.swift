//
//  ClientInterceptor.swift
//  Workplaces
//
//  Created by YesVladess on 27.04.2021.
//

import Alamofire
import Apexy
import WorkplacesAPI

final public class ClientRequestInterceptor: Apexy.BaseRequestInterceptor {

    convenience init(baseURL: URL, accessTokenStorage: AccessTokenStorageProtocol) {
        self.init(baseURL: baseURL)
        self.accessTokenStorage = accessTokenStorage
    }

    private var accessTokenStorage: AccessTokenStorageProtocol?

    override public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        guard let url = urlRequest.url else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = urlRequest
        if let accessToken = accessTokenStorage?.accessToken?.value {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        request.url = appendingBaseURL(to: url)

        completion(.success(request))
    }

    override public func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        let defaultRetryTime = 0.5
        let maxRetryCount = 4

        guard request.retryCount < maxRetryCount else { return completion(.doNotRetry) }
        if let underlyingError = (error as? AFError)?.underlyingError {
            if underlyingError as? URLError != nil {
                return completion(.retryWithDelay(defaultRetryTime * Double(request.retryCount)))
            } else if underlyingError as? HTTPError != nil {
                return completion(.retryWithDelay(defaultRetryTime * Double(request.retryCount)))
            } else if underlyingError as? APIError != nil {
                return completion(.doNotRetry)
            }
        }
    }

    // MARK: - Private

    private func appendingBaseURL(to url: URL) -> URL {
        URL(string: url.absoluteString, relativeTo: baseURL)!
    }

}
