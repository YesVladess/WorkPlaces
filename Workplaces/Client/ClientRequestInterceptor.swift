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
        let tokenStorage = TokenStorage()
        if let token = tokenStorage.get() {
            request.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
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
        let lock = NSLock()
        lock.lock()
        if let underlyingError = (error as? AFError)?.underlyingError {
            if let error = underlyingError as? URLError {
                print(error)
                return completion(.retryWithDelay(1.0))
            } else if let error = underlyingError as? HTTPError {
                print(error)
                return completion(.retryWithDelay(1.0))
            } else if let error = underlyingError as? APIError {
                print(error)
                return completion(.doNotRetry)
            }
        }
        lock.unlock()
    }

    // MARK: - Private

    private func appendingBaseURL(to url: URL) -> URL {
        URL(string: url.absoluteString, relativeTo: baseURL)!
    }

}
