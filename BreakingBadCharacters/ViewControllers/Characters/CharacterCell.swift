//
//  CharacterCell.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    func setup(_ character: BreakingBadCharacter) {
        nameLabel.text = character.name
        nicknameLabel.text = character.nickname
        imageView.kf.setImage(with: character.imageURL)
    }
}
