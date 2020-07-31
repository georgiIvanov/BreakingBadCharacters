//
//  ServiceEntry+DI.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Swinject

extension ServiceEntry {
    func singleton() {
        inObjectScope(.container)
    }
}
