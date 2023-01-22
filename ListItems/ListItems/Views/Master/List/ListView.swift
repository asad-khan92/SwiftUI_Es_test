//
//  Root.swift
//  ListItems
//
//  Created by Asad Khan on 22/01/2023.
//

import SwiftUI
import Connectivity

struct ListView: View {
    
    @StateObject var reachability = Reachability()
    
    @StateObject var viewModel: ItemViewModel
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            
            VStack{
                if viewModel.showConnectivityStatus{
                    Text(viewModel.status.description).animation(.easeIn)
                }
                List(viewModel.listRowViewModels) { viewModel in
                    NavigationLink {
                        Detail(item: viewModel.item)
                    } label: {
                        ListRowView(viewModel: viewModel)
                    }
                }
                .listStyle(.sidebar)
                .refreshable {
                    viewModel.fetchItems()
                }
                .overlay{
                    if viewModel.showErrorAlert {
                        Text(viewModel.errorMessage ?? "")
                    }else if viewModel.isFetching{
                        
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    
                }
                .navigationTitle("What's New")
                
            }
        }
    }
}

struct Root_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ItemViewModel(client: APIPreviewClient()))
    }
}
