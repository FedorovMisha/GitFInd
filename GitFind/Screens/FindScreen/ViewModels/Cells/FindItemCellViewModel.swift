//
//  FindItemCellViewModel.swift
//  GitFind
//
//  Created by Misha Fedorov on 07.03.2022.
//

import Foundation

class FindItemCellViewModel: ReusableTableCellViewModel {

    private let model: RepositoryItemModel

    init(_ model: RepositoryItemModel) {
        self.model = model
    }
    
    func setup(cell: FindItemCell) {
        cell.configure(model)
    }
}
