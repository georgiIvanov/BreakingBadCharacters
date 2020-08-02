//
//  FilterButton.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit

class FilterButton: UIButton {
    @IBInspectable
    var season: Int = 0
    
    @IBInspectable
    var filterEnabled: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTint()
    }
    
    func toggleSelectedState() {
        filterEnabled = !filterEnabled
        applyTint()
    }
    
    func applyTint() {
        if filterEnabled {
            tintColor = UIColor.white
        } else {
            tintColor = UIColor.white.withAlphaComponent(0.5)
        }
    }
}
