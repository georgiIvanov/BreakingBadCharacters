//
//  CharacterDetailCell.swift
//  BreakingBadCharacters
//
//  Created by Voro on 2.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailCell: UITableViewCell {
    
    @IBOutlet weak var fieldNameLabel: UILabel!
    @IBOutlet weak var fieldValueLabel: UILabel!
    
    func setup(name: String, value: String) {
        fieldNameLabel.text = name
        fieldValueLabel.text = value
    }
}
