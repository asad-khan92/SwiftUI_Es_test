//
//  ItemRowViewModel.swift
//  ListItems
//
//  Created by Asad Khan on 22/01/2023.
//

import Foundation
import Combine
import UIKit

final class ItemRowViewModel:ObservableObject,Identifiable{
    
    private var service: APIService
    
    let item:ListItem
    
    // MARK: -

    var id: String {
        item.id ?? ""
    }

    var price: String {
        item.price ?? ""
    }
    
    var name: String {
        item.name ?? ""
    }
    
    // MARK: - Initialization
    init(item:ListItem, service:APIService){
        self.item = item
        self.service = service
    }
    

}
