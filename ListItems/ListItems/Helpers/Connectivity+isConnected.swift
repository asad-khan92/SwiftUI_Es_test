//
//  Connectivity+isConnected.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Foundation
import Connectivity

extension ConnectivityStatus{
    
    var isConnected:Bool{
        
        switch self{
        case .connected,.connectedViaCellular,.connectedViaEthernet,.connectedViaWiFi:
            return true
        case .determining,.connectedViaCellularWithoutInternet,.connectedViaEthernetWithoutInternet,.connectedViaWiFiWithoutInternet,.notConnected:
            return false
        }
    }
}
