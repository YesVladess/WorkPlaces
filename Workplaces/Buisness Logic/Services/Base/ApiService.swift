//
//  ApiService.swift
//  workplaces
//
//  Created by YesVladess on 27.04.2021.
//

import Apexy
import Foundation
import WorkplacesAPI

// Базовый класс с API клиентом
class ApiService {

    let apiClient: Client

    init(apiClient: Client) {
        self.apiClient = apiClient
    }

    func commonResultHandler<T>(
        result: (Result<T, Error>),
        completion: @escaping ((Result<T, WorkplaceError>) -> Void)
    ) {
        switch result {
        case .success(let resultData):
            completion(.success((resultData)))
        case .failure(let error):
            if let error = error as? APIError {
                completion(.failure(.apiError(error)))
            } else {
                completion(.failure(.unknowned))
            }
        }
    }

}
