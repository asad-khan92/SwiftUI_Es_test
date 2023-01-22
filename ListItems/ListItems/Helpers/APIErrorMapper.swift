//
//  APIErrorMapper.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Foundation

struct APIErrorMapper {

    // MARK: - Types

    enum Context {
        case items
    }

    // MARK: - Properties

    let error: APIError
    let context: Context

    // MARK: - Public API

    var message: String {
        switch error {
        case .unreachable:
            return "You need to have a network connection."
        case .unauthorized:
            switch context {
            default:
                return "You need to be signed in."
            }
        case .unknown,
             .failedRequest,
             .invalidResponse:
            switch context {
            case .items:
                return "The list of items could not be fetched."
            }
        }
    }

}
