//
//  ListItem.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Foundation

struct ListItem : Codable,Identifiable {
    let id : String?
    let created_at : String?
    let price : String?
    let name : String?
    let image_ids : [String]?
    let image_urls : [String]?
    let image_urls_thumbnails : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case created_at = "created_at"
        case price = "price"
        case name = "name"
        case id = "uid"
        case image_ids = "image_ids"
        case image_urls = "image_urls"
        case image_urls_thumbnails = "image_urls_thumbnails"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image_ids = try values.decodeIfPresent([String].self, forKey: .image_ids)
        image_urls = try values.decodeIfPresent([String].self, forKey: .image_urls)
        image_urls_thumbnails = try values.decodeIfPresent([String].self, forKey: .image_urls_thumbnails)
    }
    
    var imageURL:[URL]?{
        return image_urls?.compactMap({URL(string: $0)})
    }
    
    var imageThumbnailsURL:[URL]?{
        return image_urls_thumbnails?.compactMap({URL(string: $0)})
    }
}

extension ListItem {
    
    static let items: [ListItem] = {
        guard let url = Bundle.main.url(forResource: "items", withExtension: "json") else {
            fatalError("Unable to Find Stub Data")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to Load Stub Data")
        }
        
        return try! JSONDecoder().decode([ListItem].self, from: data)
    }()
    
}
