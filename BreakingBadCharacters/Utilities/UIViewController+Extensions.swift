//
//  UIViewController+Extensions.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
