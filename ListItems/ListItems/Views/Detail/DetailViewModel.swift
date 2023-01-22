//
//  DetailViewModel.swift
//  ListItems
//
//  Created by Asad Khan on 22/01/2023.
//

import Foundation
import Combine
import UIKit

final class DetailCarouselViewModel:ObservableObject{
    
    //MARK: properties
    @Published private(set) var image:UIImage?
    @Published private(set) var error:Error?
    
    // MARK: - Initialization
    init(imageUrl:URL){
        fetchImage(url:imageUrl )
    }
    
    private func fetchImage(url:URL){
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if error != nil {
                DispatchQueue.main.async {
                    self?.error = error
                }
               
            }else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}
