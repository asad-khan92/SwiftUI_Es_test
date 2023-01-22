//
//  APIEndpoint.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Foundation

enum APIEndpoint {

    // MARK: - Cases
    case items

    // MARK: - Properties

    func request(accessToken: String?) throws -> URLRequest {
        var request = URLRequest(url: url)

        request.addHeaders(headers)
        request.httpMethod = httpMethod.rawValue

        if requiresAuthorization {
            if let accessToken = accessToken {
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            } else {
                throw APIError.unauthorized
            }
        }

        request.httpBody = httpBody

        return request
    }

    private var url: URL {
        Environment.apiBaseURL.appendingPathComponent(path)
    }
    
    private var path: String {
        switch self {
       
        case .items:
            return "/default/dynamodb-writer"
        }
    }

    private var httpMethod: HTTPMethod {
        switch self {
        case .items:
            return .get
        }
    }

    private var httpBody: Data? {
        switch self {
        case .items:
            return nil
        }
    }

    private var requiresAuthorization: Bool {
        switch self {
        case .items:
            return false
            
        }
    }

    private var headers: Headers {
        switch self {
        case .items:
            return [
                "Content-Type": "application/json"
            ]
            
        }
        
        
    }

}

extension URLRequest {

    mutating func addHeaders(_ headers: Headers) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }

}
