//
//  ListRowView.swift
//  ListItems
//
//  Created by Asad Khan on 22/01/2023.
//

import SwiftUI
import Kingfisher

extension KFOptionSetter{
    public func keepCurrentImageWhileLoading(_ enabled: Bool = true) -> Self {
        options.keepCurrentImageWhileLoading = enabled
        return self
    }
}
struct ListRowView: View {
    @ObservedObject var viewModel:ItemRowViewModel
    
    var body: some View {
       
        HStack(spacing: 8.0) {
           
            KFImage.url(viewModel.item.imageThumbnailsURL?.first)
                .keepCurrentImageWhileLoading()
                .resizable()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onSuccess { result in  }
                .onFailure { error in
                    print(error)
                }
                .placeholder {
                    ProgressView().progressViewStyle(.circular)
                }
                .cornerRadius(8)
                .frame(width: 50,height: 50)
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(viewModel.name)
                    .font(.headline)
                    .fontWeight(.light)
                
                Text(viewModel.price)
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(viewModel: ItemRowViewModel(item: ListItem.items[0], service: APIPreviewClient()))
    }
}
