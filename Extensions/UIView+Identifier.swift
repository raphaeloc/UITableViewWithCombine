//
//  UIView+Identifier.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//

import UIKit

extension UIView {
    static var identifier: String {
        String(describing: type(of: self))
    }
}
