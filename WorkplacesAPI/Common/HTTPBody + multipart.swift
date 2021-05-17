//
//  HTTPBody + multipart.swift
//  WorkplacesAPI
//
//  Created by YesVladess on 10.05.2021.
//
import Apexy

public extension HTTPBody {
    
    /// Create HTTP body with json content type.
    ///
    /// - Parameters:
    ///   - data: HTTP body data.
    /// - Returns: HTTPBody.
    static func multipart(_ data: Data) -> HTTPBody {
        return HTTPBody(data: data, contentType: "multipart/form-data; boundary=---WebKitFormBoundary7MA4YWxkTrZu0gW")
    }

}
