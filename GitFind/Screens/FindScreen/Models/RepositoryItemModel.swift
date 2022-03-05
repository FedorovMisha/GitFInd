//
//  RepositoryItemModel.swift
//  GitFind
//
//  Created by Misha Fedorov on 05.03.2022.
//

import Foundation


struct RepositoryItemModel {
    let name: String
    let fullName: String
    let ownerModel: OwnerPreviewModel
    let url: URL
}
