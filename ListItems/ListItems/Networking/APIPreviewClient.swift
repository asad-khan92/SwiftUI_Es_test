//
//  APIClientPreview.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Combine
import Foundation

struct APIPreviewClient: APIService {
    
    // MARK: - Methods

    func items() -> AnyPublisher<ItemsResponse, APIError> {
        publisher(for: "list_response")
    }
    
    func items() async throws -> ItemsResponse {
        return try await asyncData(for: "list_response")
    }

}

fileprivate extension APIPreviewClient {

    func asyncData<T: Decodable>(for resource: String)async throws -> T{
        
        return stubData(for: resource)
    }
    
    func publisher<T: Decodable>(for resource: String) -> AnyPublisher<T, APIError> {

        Just(stubData(for: resource))
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func stubData<T: Decodable>(for resource: String) -> T {
        guard
            let url = Bundle.main.url(forResource: resource, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let stubData = try? JSONDecoder().decode(T.self, from: data)
        else {
            fatalError("Unable to Load Stub Data")
        }

        return stubData
    }

}
