//
//  CharactersViewModel.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation

protocol CharactersViewModelProtocol: class {
    func fetchCharacters()
}

class CharactersViewModel {

    private let breakingBadService: BreakingBadApiServiceProtocol

    init(breakingBadService: BreakingBadApiServiceProtocol) {
        self.breakingBadService = breakingBadService
    }
}

extension CharactersViewModel: CharactersViewModelProtocol {
    func fetchCharacters() {

    }
}
