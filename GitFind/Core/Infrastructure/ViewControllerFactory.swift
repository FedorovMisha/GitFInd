//
//  ViewControllerFactory.swift
//  GitFind
//
//  Created by Misha Fedorov on 05.03.2022.
//

import UIKit

protocol ViewControllerFactoryProtocol {
    var navigationViewController: UINavigationController? { get set }
    init(_ navigationController: UINavigationController?)
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    var navigationViewController: UINavigationController?
    
    required init(_ navigationController: UINavigationController? = nil) {
        self.navigationViewController = navigationController
    }
}

