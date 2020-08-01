//
//  CharactersViewController.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import UIKit
import RxSwift

class CharactersViewController: UIViewController {

    var viewModel: CharactersViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCharacters()
    }
}
