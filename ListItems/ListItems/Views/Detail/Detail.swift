//
//  Detail.swift
//  ListItems
//
//  Created by Asad Khan on 22/01/2023.
//

import SwiftUI
import Kingfisher

struct KFImageView: View {
    
    var url:URL
    
    var body: some View {
        
        KFImage.url(url)
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in  }
            .onFailure { error in
                print(error)
            }
            .placeholder {
                ProgressView().progressViewStyle(.circular)
            }
    }
}

struct Detail: View {
    
    var item:ListItem
    
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment: .leading){
            
                ScrollView(.horizontal,showsIndicators: true){
                    HStack{
                        if let urls = item.imageURL{
                            ForEach(urls,id: \.self){img in
                                
                                
                                KFImageView(url: img)
                                    .scaledToFill()
                                    .frame(width: geo.size.width )
                                    .frame(width: geo.size.width, height : geo.size.height * 0.4)
                                    .clipped()
                                
                            }
                        }else{
                            // Can add placeholder image here
                            Spacer()
                            Text("No image found")
                                .frame(alignment: .center)
                            Spacer()
                        }
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(item.name ?? "")
                        .font(.headline)
                        .fontWeight(.light)
                    
                    Text(item.price ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                }
                .padding([.leading], 20)
                Spacer()
            }
            .navigationTitle(item.name ?? "")
        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(item: ListItem.items[0])
       
    }
}
