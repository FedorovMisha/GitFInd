//
//  SerchRequestModel.swift
//  GitFind
//
//  Created by Misha Fedorov on 07.03.2022.
//

import Foundation

struct SearchRequestModel: Encodable {

    private enum CodingKeys: String, CodingKey {
        case query = "q"
        case resultCount = "per_page"
        case page
    }
    let query: String
    let resultCount: Int
    let page: Int

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(query, forKey: .query)
        try container.encode(resultCount, forKey: .resultCount)
        try container.encode(page, forKey: .page)
    }
}
