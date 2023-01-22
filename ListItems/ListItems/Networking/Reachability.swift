//
//  Reachability.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Foundation
import Combine
import Connectivity

final class Reachability:ObservableObject{
    
    private let configuration:URLSessionConfiguration
    
    init(config:URLSessionConfiguration = .default ){
        self.configuration = config
    }
    
    func observerConnection()->AnyPublisher<Connectivity,Never>{
        
        return Connectivity.Publisher(configuration:
                .init()
                .configureURLSession(self.configuration)
        ).eraseToAnyPublisher()
        
    }
}
