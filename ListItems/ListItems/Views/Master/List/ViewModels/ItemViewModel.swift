//
//  ItemViewModel.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Foundation
import Combine
import Connectivity

final class ItemViewModel:ObservableObject{
    
    // MARK: - Properties
    
    @Published private(set) var items: [ListItem] = []

    @Published private(set) var isFetching = false

    @Published private(set) var errorMessage: String?
    @Published private(set) var showErrorAlert: Bool = false
    
    @Published var status:ConnectivityStatus = .determining
    @Published var showConnectivityStatus:Bool = true
    // MARK: -

    var listRowViewModels: [ItemRowViewModel] {
        items.map { ItemRowViewModel(item: $0, service: APIClient()) }
    }
    
    // MARK: -
    
    private var client: APIService
    
    // MARK: -

    private var subscribers: Set<AnyCancellable> = []
    
    init(client:APIService){
        self.client = client
        observerConnection()
        fetchItems()
    }
    
    private func observerConnection(){
        
        Reachability().observerConnection()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch completion{
                case .finished:()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: {[weak self] connectivity in
                
                print("Connection status = \(connectivity.status)")
                self?.status = connectivity.status
                switch connectivity.status{
                    
                case .connectedViaWiFiWithoutInternet,.notConnected,.connectedViaCellularWithoutInternet,.connectedViaEthernetWithoutInternet:
                    self?.showConnectivityStatus = true
                    
                default:
                    self?.showConnectivityStatus = false
//                     refresh list again
                    if let self, self.items.isEmpty{
                        self.fetchItems()
                    }
                }
            }
            .store(in: &subscribers)
    }
    
    func fetchItems(){
        
        isFetching = true
        showErrorAlert = false
        
        client.items()
            .sink {[weak self] completion in
                self?.isFetching = false
                switch completion{
                case .finished:()
                case .failure(let error):
                    self?.errorMessage = APIErrorMapper(
                        error: error,
                        context: .items
                    ).message
                    self?.showErrorAlert = true
                }
            } receiveValue: {[weak self] response in
                if let i = response.items{
                    self?.items = i
                }
            }.store(in: &subscribers)
        
    }
}
