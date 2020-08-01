//
//  DIContainer.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import Swinject

protocol DIContainer: class {
    static var container: Container { get }
    static func createContainer() -> Container
}

extension DIContainer where Self: AppDelegate {

    static func createContainer() -> Container {
        Container.loggingFunction = nil

        let container = Container()
        _ = Assembler([ViewControllerAssembly(),
                       ViewModelAssembly(),
                       ServiceAssembly()], container: container)
        return container
    }
}
