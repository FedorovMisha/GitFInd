//
//  SearchService.swift
//  GitFind
//
//  Created by Misha Fedorov on 07.03.2022.
//

import Foundation
import RxSwift
import Moya


protocol SearchServiceProtocol {
    func search(request model: SearchRequestModel) -> Single<SearchResponseModel>
}

class SearchService: SearchServiceProtocol {

    private enum SearchServiceError: Error {
        case invalidStatusCode
        case invalidMap
    }

    private let provider = MoyaProvider<SearchTarget>()
    
    func search(request model: SearchRequestModel) -> Single<SearchResponseModel> {
        return Single.create { single in
            self.provider.request(.search(model)) { result in
                switch result {
                case .success(let response):
                    switch response.statusCode {
                    case 200..<300:
                        guard let map = try? JSONDecoder().decode(SearchResponseModel.self, from: response.data) else {
                            single(.failure(SearchServiceError.invalidMap))
                            return
                        }
                        single(.success(map))
                    default:
                        single(.failure(SearchServiceError.invalidStatusCode))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
