//
//  ListItemsApp.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import SwiftUI

@main
struct ListItemsApp: App {
    var body: some Scene {
        WindowGroup {
            ListView(viewModel: ItemViewModel(client: APIClient()))
        }
    }
}
