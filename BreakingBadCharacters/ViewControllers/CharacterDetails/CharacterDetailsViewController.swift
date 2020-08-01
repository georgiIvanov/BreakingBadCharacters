//
//  CharacterDetailsViewController.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var character: BreakingBadCharacter!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        imageView.kf.setImage(with: character.imageURL)
    }
}
