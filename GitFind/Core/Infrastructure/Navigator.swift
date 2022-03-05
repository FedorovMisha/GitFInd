//
//  Navigator.swift
//  GitFind
//
//  Created by Misha Fedorov on 05.03.2022.
//

import Foundation

protocol Navigator {
    associatedtype Flow
    
    func navigate(to flow: Flow)
}
