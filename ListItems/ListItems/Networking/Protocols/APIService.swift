//
//  APIService.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Combine
import Foundation

protocol APIService {

    // MARK: - Properties
    func items() -> AnyPublisher<ItemsResponse, APIError>
    // Async Await Structured Concurrency method
    func items() async throws -> ItemsResponse
}
