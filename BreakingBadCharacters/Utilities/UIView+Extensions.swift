//
//  UIView+Extensions.swift
//  BreakingBadCharacters
//
//  Created by Voro on 3.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func animateViewAlphaToAppear() {
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1
        }
    }
    
    func animateViewAlphaToDisappear() {
        UIView.animate(withDuration: 0.4) {
            self.alpha = 0
        }
    }
}
