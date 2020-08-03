//
//  ErrorMessageView.swift
//  BreakingBadCharacters
//
//  Created by Voro on 3.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit

class ErrorMessageView: UIView {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 3
        layer.borderColor = AppConfig.mainColorLight.cgColor
    }
}
