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
    func viewModelFor(_ indexPath: IndexPath)
}

class FindScreenViewModel: FindViewModel {
    
    var resultRelay: BehaviorRelay<[RepositoryItemModel]> = .init(value: [])
    
    private let disposeBag = DisposeBag()
    private let queryRelay = BehaviorRelay<String?>(value: nil)
    var numberOfRows: Int = 0
    
    private var fakeData: [RepositoryItemModel] = [
        RepositoryItemModel(name: "Treelllo",
                            fullName: "FedorovMisha",
                            ownerModel: OwnerPreviewModel(login: "FedorovMisha",
                                                          avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/60353834?v=4"),
                                                          profileUrl: URL(string: "https://api.github.com/users/FedorovMisha")!),
                            url: URL(string: "https://github.com/FedorovMisha/treelllo")!),
        RepositoryItemModel(name: "Treelllo",
                            fullName: "FedorovMisha",
                            ownerModel: OwnerPreviewModel(login: "FedorovMisha",
                                                          avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/60353834?v=4"),
                                                          profileUrl: URL(string: "https://api.github.com/users/FedorovMisha")!),
                            url: URL(string: "https://github.com/FedorovMisha/treelllo")!),
        RepositoryItemModel(name: "Treelllo",
                            fullName: "FedorovMisha",
                            ownerModel: OwnerPreviewModel(login: "FedorovMisha",
                                                          avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/60353834?v=4"),
                                                          profileUrl: URL(string: "https://api.github.com/users/FedorovMisha")!),
                            url: URL(string: "https://github.com/FedorovMisha/treelllo")!),
    ]

    init() {
        setupBind()
    }
    
    func execute(query: String? = nil) {
        queryRelay.accept(query)
    }

    func viewModelFor(_ indexPath: IndexPath) {
        
    }

    private func setupBind() {
        queryRelay.map { _ -> [RepositoryItemModel] in
            return self.fakeData
        }.subscribe(onNext: {
            self.fakeData.append(contentsOf: $0)
            self.numberOfRows = self.fakeData.count
            self.resultRelay.accept(self.fakeData)
        }).disposed(by: disposeBag)
    }
}
