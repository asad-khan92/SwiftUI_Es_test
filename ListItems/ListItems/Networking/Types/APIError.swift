//
//  APIError.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

enum APIError: Error {

    // MARK: - Cases

    case unknown
    case unreachable
    case unauthorized
    case failedRequest
    case invalidResponse

}
