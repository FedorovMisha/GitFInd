//
//  SearchResponseModel.swift
//  GitFind
//
//  Created by Misha Fedorov on 07.03.2022.
//

import Foundation

struct SearchResponseModel: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [SearchItem]

    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}


// MARK: - SearchResponseModel
struct SearchItem: Codable {
    let name: String
    let fullName: String
    let owner: SearchOwner
    let url: URL

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case owner
        case url = "html_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        fullName = try container.decode(String.self, forKey: .fullName)
        owner = try container.decode(SearchOwner.self, forKey: .owner)
        url = try container.decode(URL.self, forKey: .url)
    }
}


// MARK: - SearchOwner
struct SearchOwner: Codable {

    let login: String
    let avatarURL: URL
    let url: URL

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarURL = "avatar_url"
        case url = "url"
    }
}
