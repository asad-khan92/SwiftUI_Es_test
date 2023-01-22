//
//  ListResponse.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Foundation

struct ItemsResponse : Codable {
    let items : [ListItem]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case items = "results"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([ListItem].self, forKey: .items)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}
