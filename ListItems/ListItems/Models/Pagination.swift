//
//  Pagination.swift
//  ListItems
//
//  Created by Asad Khan on 21/01/2023.
//

import Foundation

struct Pagination : Codable {
    let key : String?

    enum CodingKeys: String, CodingKey {

        case key = "key"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self, forKey: .key)
    }

}
