//
//  FIndViewModel.swift
//  GitFind
//
//  Created by Misha Fedorov on 05.03.2022.
//

import Foundation
import RxSwift
import RxRelay


protocol FindViewModel {
    var resultRelay: BehaviorRelay<[RepositoryItemModel]> { get }
    func execute(query: String?)
    var numberOfRows: Int { get set }
    func viewModelFor(_ indexPath: IndexPath) -> ReusableViewModel
}

class FindScreenViewModel: FindViewModel {
    
    var resultRelay: BehaviorRelay<[RepositoryItemModel]> = .init(value: [])
    
    private let disposeBag = DisposeBag()
    private let queryRelay = PublishRelay<String>()
    private var viewModels: [ReusableViewModel] = []
    private let service = SearchService()
    private var currentPage = 1
    var numberOfRows: Int = 0

    init() {
        setupBind()
    }
    
    func execute(query: String? = nil) {
        if let query = query, !query.isEmpty {
            queryRelay.accept(query)
        }
    }

    func viewModelFor(_ indexPath: IndexPath) -> ReusableViewModel {
        return viewModels[indexPath.row]
    }

    private func setupBind() {
        queryRelay.map { query -> SearchRequestModel in
            return SearchRequestModel(query: query,
                                      resultCount: 25,
                                      page: self.currentPage)
        }.flatMap {
            self.service.search(request: $0)
        }
        .map {
            $0.items.map { item -> RepositoryItemModel in
                let owner = OwnerPreviewModel(login: item.owner.login,
                                              avatarUrl: item.owner.avatarURL,
                                              profileUrl: item.owner.url)
                return RepositoryItemModel(name: item.name,
                                           fullName: item.fullName,
                                           ownerModel: owner,
                                           url: item.url)
            }
        }.subscribe(onNext: {
            self.resultRelay.accept($0)
        }).disposed(by: disposeBag)
        
        resultRelay.subscribe(onNext: {
            self.numberOfRows = $0.count
            self.viewModels = $0.map {
                FindItemCellViewModel($0)
            }
        }).disposed(by: disposeBag)
    }
}
