//
//  AppNavigator.swift
//  GitFind
//
//  Created by Misha Fedorov on 05.03.2022.
//

import Foundation
import UIKit

class AppNavigator: Navigator {
    enum Flow {
        case toFindScreen
    }

    private let navigationViewController: UINavigationController

    init(_ navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }

    func navigate(to flow: Flow) {
        switch flow {
        case .toFindScreen:
            self.navigateToFindScreen()
        }
    }

    private func navigateToFindScreen() {
        let controller = ViewControllerFactory.createFindViewController()
        navigationViewController.setViewControllers([controller], animated: true)
    }
}
