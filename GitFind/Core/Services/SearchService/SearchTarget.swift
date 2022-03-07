//
//  SearchTarget.swift
//  GitFind
//
//  Created by Misha Fedorov on 07.03.2022.
//

import Moya

enum SearchTarget {
    case search(_ model: SearchRequestModel)
}

extension SearchTarget: TargetType {
    
    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }

    var method: Method {
        .get
    }

    var path: String {
        "search/repositories"
    }
    
    var task: Task {
        switch self {
        case .search(let model):
            return .requestParameters(parameters: ["q": model.query,
                                                   "per_page": model.resultCount,
                                                   "page": model.page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/vnd.github.v3+json"]
    }
}
