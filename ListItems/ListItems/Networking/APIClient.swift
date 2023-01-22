//
//  APIClient.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Combine
import Foundation

final class APIClient: APIService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func items() async throws -> ItemsResponse {
        try await request(.items)
    }
    

    // MARK: - API Service

    func items() -> AnyPublisher<ItemsResponse, APIError> {
        request(.items)
    }

    

    private func request<T: Decodable>(_ endpoint: APIEndpoint) async throws ->T{
        
        do {
            let request = try endpoint.request(accessToken: nil)
             let (data,response) = try await session.data(for:request)
            
            return try parseData(data: data, response: response)
            
        }catch{
            throw APIError.failedRequest
        }
        
    }
    
    // MARK: - Helper Methods

    private func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, APIError> {
        do {

            let request = try endpoint.request(accessToken: nil)
            
            return self.session.dataTaskPublisher(for: request)
                .tryMap { [weak self] data, response -> T in
                    if let self{
                       return try self.parseData(data: data, response: response)
                    }
                    
                    throw APIError.unknown
                }
                .mapError { error -> APIError in
                    switch error {
                    case let apiError as APIError:
                        return apiError
                    case URLError.notConnectedToInternet:
                        return APIError.unreachable
                    default:
                        return APIError.failedRequest
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
                
        } catch {
            if let apiError = error as? APIError {
                return Fail(error: apiError)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
        }
    }
    
    private func parseData<T: Decodable>(data:Data,response:URLResponse) throws -> T{
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.failedRequest
        }

        guard (200..<300).contains(statusCode) else {
            if statusCode == 401 {
                throw APIError.unauthorized
            } else {
                throw APIError.failedRequest
            }
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Unable to Decode Response \(error)")
            throw APIError.invalidResponse
        }
    }

}
