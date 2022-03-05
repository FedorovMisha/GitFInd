//
//  Reusable.swift
//  GitFind
//
//  Created by Misha Fedorov on 05.03.2022.
//

import Foundation
import UIKit

protocol Reusable: AnyObject {
    var reuseIdentifier: String { get }
}

protocol ReusableViewModel {
    func setup(any object: AnyObject)
}

protocol ReusableTableCellViewModel: ReusableViewModel {
    associatedtype Cell: UITableViewCell
    
    func setup(cell: Cell)
}

extension ReusableTableCellViewModel {
    func setup(any object: AnyObject) {
        guard let cell = object as? Cell else { fatalError("Cant't pass object") }
        self.setup(cell: cell)
    }
}

extension UITableViewCell: Reusable {
    var reuseIdentifier: String {
        return "\(Self.self)"
    }
}
