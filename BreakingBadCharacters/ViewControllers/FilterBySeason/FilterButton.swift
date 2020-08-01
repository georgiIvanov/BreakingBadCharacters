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
    
    func toggleSelectedState() {
        filterEnabled = !filterEnabled
        
        if filterEnabled {
            tintColor = .systemBlue
        } else {
            tintColor = .white
        }
    }
}
