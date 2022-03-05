//
//  Styling.swift
//  GitFind
//
//  Created by Misha Fedorov on 05.03.2022.
//

import UIKit

precedencegroup StylingGroup {
    associativity: left
}

infix operator =>>

func =>><T: UIView>(_ firstStyle: @escaping (T)->Void,
                    _ secondStyle: @escaping (T) -> Void) -> (T) -> Void {
    return {
        firstStyle($0)
        secondStyle($0)
    }
}

extension UIView {
    static func withStyle(_ style: @escaping (Self) -> Void) -> Self {
        let view = Self.init()
        style(view)
        return view
    }
}
