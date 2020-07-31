//
//  ViewModelAssembly.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Swinject

class ViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CharactersViewModelProtocol.self) { _ in
            return CharactersViewModel()
        }
    }
}
